Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994C5B0C86
	for <lists+lvs-devel@lfdr.de>; Wed,  7 Sep 2022 20:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIGSdN (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 7 Sep 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGSdN (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 7 Sep 2022 14:33:13 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8946AABF16
        for <lvs-devel@vger.kernel.org>; Wed,  7 Sep 2022 11:33:11 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id D161124C85;
        Wed,  7 Sep 2022 21:33:10 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 1B60F24C80;
        Wed,  7 Sep 2022 21:33:09 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id EDF143C0437;
        Wed,  7 Sep 2022 21:33:08 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 287IX754129707;
        Wed, 7 Sep 2022 21:33:08 +0300
Date:   Wed, 7 Sep 2022 21:33:07 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCH 0/4] Use kthreads for stats
In-Reply-To: <20220905082642.GB18621@incl>
Message-ID: <4e16b591-dd0-86e1-afcf-5759362908b@ssi.bg>
References: <20220827174154.220651-1-ja@ssi.bg> <20220905082642.GB18621@incl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Mon, 5 Sep 2022, Jiri Wiesner wrote:

> I believe allowing the kthread the possibility to block in each iteration - for each estimator - introduces some problems:
> 1. Non-preemptive kernels should be optimized for throughput not for latency
> Using the figure reported earlier (50,000 services required 200 ms of processing time) it takes roughly 3 ms to process one chain (32 * 1024 / 50 services). The processing time per chain will vary with the number of NUMA nodes and CPUs. Nevertheless, this number comparable with the processing time limit of __do_softirq() - 2 ms, which gets converted to 1 jiffy. In term of latency of non-preemptive kernels, it is entirely resonable to let one chain be processed without rescheduling the kthread.

	Thank you for the review!

	My worry is that IPVS_EST_MAX_COUNT is not a hard limit,
we allow this limit to be exceeded when ip_vs_est_add_kthread()
fails to create kthread (mostly on ENOMEM) or if we add a limit
for kthreads, so in such cases we can not refuse to add more
estimators to existing kthreads.

> 2. The priority of the kthreads could be set to lower values than the default priority for SCHED_OTHER. If a user space process was trying to stop an estimator the pointer to which is held by a currently sleeping kthread this would constitute priority inversion. The kd->mutex would not be released until the lower priority thread, the kthread, has started running again. AFAIK, the mutex() locking primitive does not implement priority inheritance on non-preemptive kernels.

	I see, alternative would be wait_event() logic to avoid
holding mutex during reschedule and causing priority inversion.

> 3. Blocking while in ip_vs_estimation_chain() will results in wrong estimates for the remaining estimators in a chain. The 2 second interval would not be kept, rate estimates would be overestimated in that interval and underestimated in one of the future intervals.
> In my opinion, any of the above reasons is sufficient to remove ip_vs_est_cond_resched_rcu(), ip_vs_est_wait_resched() and kd->mutex.

	The chains can become too long. I'm not sure it is
good to avoid cond_resched() for long time. Another solution
would be to allocate more chains for a tick and apply some
hard limit for these chains. cond_resched() will be called
after such chain is processed. But it is difficult to
calculate hard limit for these chains, it depends on the
cycles we spend (CPU speed and the number of possible CPUs
we walk in the loop). For example, we can have again 50 ticks
but 16 chains per tick, so total 800 chains per kthread (50*16).
32*1024/800 means 40 estimators per chain before calling
cond_resched(). And a tick can attach more than 16 chains
if the est_max_count is exceeded. It will cost some memory
to provide more chains but it will avoid the kd->mutex
games.

	struct hlist_head *tick_chain = &kd->tick_chains[row];

	rcu_read_lock();
	/* tick_chains has no limit of chains */
	hlist_for_each_entry_rcu(chain, tick_chains, list) {
		/* This list below is limited */
		hlist_for_each_entry_rcu(e, &chain->ests, list) {
			...
			if (kthread_should_stop())
				goto end;
			...
		}
		cond_resched_rcu();
	}

	If we change ip_vs_start_estimator() to return int err
we can safely allocate new chains and track for ENOMEM.
I think, this is possible, with some reordering of the
ip_vs_start_estimator() calls.

> > Kthread data:
> > 
> > - every kthread works over its own data structure and all
> > such structures are attached to array
> 
> It seems to me there is no upper bound on the number of kthreads that could be forked. Therefore, it should be possible to devise an attack that would force the system to run out of PIDs:
> 1. Start adding services so that all chains of kthread A would be used.
> 2. Add one more service to force the forking of kthread B, thus advancing ipvs->est_add_ktid.
> 3. Remove all but one service from kthread A.
> 4. Repeat steps 1-3 but with kthread B.
> I think I could come up with a reproducer if need be.

	Agreed, the chains management can be made more robust.
This patchset is initial version that can serve as basis.
We should consider such things:

- we do not know how many estimators will be added, if we
limit the number of kthreads, then they will be overloaded

- add/del can be made to allocate memory for chains, if needed.
We should not spend many cycles in adding/deleting estimators.

- try more hard to spread estimators to chains, even with
the risk of applying initially a smaller timer for the newly
added estimator.

> Unbalanced chains would not be fatal to the system but there is risk of introducing scheduling latencies tens or even hundreds of milliseconds long. There are patterns of adding and removing chains that would results in chain imbalance getting so severe that a handful of chains would have estimators in them while the rest would be empty or almost empty. Some examples:
> 1. Adding a new service each second after sleeping for 1 second. This would use the add_row value at the time of adding the estimator, which would result in 2 chains holding all the estimators.
> 2. Repeated addition and removal of services. There would always be more services added than removed. The additions would be carried out in bursts. The forking of a new kthread would not be triggered because the number of services would stay under IPVS_EST_MAX_COUNT (32 * 1024).
> 
> The problem is that the code does not guarantee that the length of chains always stays under IPVS_EST_MAX_COUNT / IPVS_EST_NCHAINS (32 * 1024 / 50) estimators. A check and a cycle iterating over available rows could be added to ip_vs_start_estimator() to find the rows that still have fewer estimators than IPVS_EST_MAX_COUNT / IPVS_EST_NCHAINS. This would come at the expense of having inaccurate estimates for a few intervals but I think the trade-off is worth it. Also, the estimates will be inaccurate when estimators are added in bursts. If, depending on how services are added and removed, the code could introduce scheduling latencies there would be someone running into this sooner or later. The probability of severe chain imbalance being low is not good enough there should be a guarantee.

	About balancing the chains: not sure if it is possible
while serving some row for current tick, to look ahead and
advance the current tick work with estimators from the next
tick. Such decisions can be made every tick. I.e. we do not
move entries between the chains but we can walk one chain and
possibly part of the other chain. If we have more chains per
tick, it will be more easy, for example, if current tick
processes 16 chains by default, it can process some from the  
next 16 chains, say 16+8 in total. After 2 seconds, this tick can
process 16+16+8, for example. It will depend on the currently
added estimators per tick and its chains. Every 2 seconds
we can advance with one tick, so that an estimator is
served every 2 seconds or atleast after 1960ms if such
chain stealing happens. Such logic will allow the
estimators to be spread in time even while they are attached   
to chains and ticks with different length. As result, we will
process equal number of estimators per tick by slowly
adjusting to their current number and chain lengths.

Regards

--
Julian Anastasov <ja@ssi.bg>

