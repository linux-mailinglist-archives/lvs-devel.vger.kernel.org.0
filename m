Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69660B13C
	for <lists+lvs-devel@lfdr.de>; Mon, 24 Oct 2022 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiJXQRt (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 24 Oct 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiJXQPy (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 24 Oct 2022 12:15:54 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 628BCA8CDB
        for <lvs-devel@vger.kernel.org>; Mon, 24 Oct 2022 08:03:47 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 82417A494;
        Mon, 24 Oct 2022 18:01:42 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 597E5A358;
        Mon, 24 Oct 2022 18:01:40 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id ABE873C0437;
        Mon, 24 Oct 2022 18:01:39 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29OF1WQ5071380;
        Mon, 24 Oct 2022 18:01:35 +0300
Date:   Mon, 24 Oct 2022 18:01:32 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv5 3/6] ipvs: use kthreads for stats estimation
In-Reply-To: <20221022181513.GB3484@incl>
Message-ID: <b279182b-58ee-1c76-e194-31539d95982@ssi.bg>
References: <20221009153710.125919-1-ja@ssi.bg> <20221009153710.125919-4-ja@ssi.bg> <20221015092158.GA3484@incl> <64d2975-357d-75f7-1d34-c43a1b3fc72a@ssi.bg> <20221022181513.GB3484@incl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Sat, 22 Oct 2022, Jiri Wiesner wrote:

> On Sun, Oct 16, 2022 at 03:21:10PM +0300, Julian Anastasov wrote:
> 
> > 	It is not a problem to add some wait_event_idle_timeout
> > calls to sleep before/between tests if the system is so busy
> > on boot that it can even disturb our tests with disabled BHs.
> 
> That is definitely not the case. When I get the underestimated max chain length:
> > [  130.699910][ T2564] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> > [  130.707580][ T2564] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
> > [  130.716633][ T2564] IPVS: ipvs loaded.
> > [  130.723423][ T2570] IPVS: [wlc] scheduler registered.
> > [  130.731071][  T477] IPVS: starting estimator thread 0...
> > [  130.737169][ T2571] IPVS: calc: chain_max=12, single est=7379ns, diff=7379, loops=1, ntest=3
> > [  130.746673][ T2571] IPVS: dequeue: 81ns
> > [  130.750988][ T2571] IPVS: using max 576 ests per chain, 28800 per kthread
> > [  132.678012][ T2571] IPVS: tick time: 5930ns for 64 CPUs, 2 ests, 1 chains, chain_max=576
> the system is idle, not running any workload and the booting sequence has finished.

	Hm, can it be some cpufreq/ondemand issue causing this?
Test can be affected by CPU speed.

> > We have 2 seconds
> > for the first tests, so we can add some gaps. If you want to
> > test it you can add some schedule_timeout(HZ/10) between the
> > 3 tests (total 300ms delay of the real estimation).
> 
> schedule_timeout(HZ/10) does not make the thread sleep - the function returns 25, which is the value of the timeout passed to it. msleep(100) works, though:

	Hm, yes. Due to the RUNNING state, msleep works
for testing.

> >  kworker/0:0-eve     7 [000]    70.223673:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.223770:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.223786: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=26009 [ns] vruntime=2654620258 [ns]
> >       ipvs-e:0:0  8927 [051]    70.223787:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=D ==> next_comm=swapper/51 next_pid=0 next_prio=120
> >          swapper     0 [051]    70.331221:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.331234:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.331241: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=11064 [ns] vruntime=2654631322 [ns]
> >       ipvs-e:0:0  8927 [051]    70.331242:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=D ==> next_comm=swapper/51 next_pid=0 next_prio=120
> >          swapper     0 [051]    70.439220:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.439235:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.439242: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=10324 [ns] vruntime=2654641646 [ns]
> >       ipvs-e:0:0  8927 [051]    70.439243:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=D ==> next_comm=swapper/51 next_pid=0 next_prio=120
> >          swapper     0 [051]    70.547220:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.547235:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.556717: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=9486028 [ns] vruntime=2664127674 [ns]
> >       ipvs-e:0:0  8927 [051]    70.561134:       sched:sched_waking: comm=in:imklog pid=2210 prio=120 target_cpu=039
> >       ipvs-e:0:0  8927 [051]    70.561136:       sched:sched_waking: comm=systemd-journal pid=1161 prio=120 target_cpu=001
> >       ipvs-e:0:0  8927 [051]    70.561138: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=4421889 [ns] vruntime=2668549563 [ns]
> >       ipvs-e:0:0  8927 [051]    70.568867:       sched:sched_waking: comm=in:imklog pid=2210 prio=120 target_cpu=039
> >       ipvs-e:0:0  8927 [051]    70.568868:       sched:sched_waking: comm=systemd-journal pid=1161 prio=120 target_cpu=001
> >       ipvs-e:0:0  8927 [051]    70.568870: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=7731843 [ns] vruntime=2676281406 [ns]
> >       ipvs-e:0:0  8927 [051]    70.568878: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=8169 [ns] vruntime=2676289575 [ns]
> >       ipvs-e:0:0  8927 [051]    70.568880:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=I ==> next_comm=swapper/51 next_pid=0 next_prio=120
> >          swapper     0 [051]    70.611220:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.611239:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.611243: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=10196 [ns] vruntime=2676299771 [ns]
> >       ipvs-e:0:0  8927 [051]    70.611245:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=I ==> next_comm=swapper/51 next_pid=0 next_prio=120
> >          swapper     0 [051]    70.651220:       sched:sched_waking: comm=ipvs-e:0:0 pid=8927 prio=120 target_cpu=051
> >          swapper     0 [051]    70.651239:       sched:sched_switch: prev_comm=swapper/51 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ipvs-e:0:0 next_pid=8927 next_prio=120
> >       ipvs-e:0:0  8927 [051]    70.651243: sched:sched_stat_runtime: comm=ipvs-e:0:0 pid=8927 runtime=10985 [ns] vruntime=2676310756 [ns]
> >       ipvs-e:0:0  8927 [051]    70.651245:       sched:sched_switch: prev_comm=ipvs-e:0:0 prev_pid=8927 prev_prio=120 prev_state=I ==> next_comm=swapper/51 next_pid=0 next_prio=120
> After adding msleep(), I have rebooted 3 times and added a service. The max chain length was always at the optimal value - around 35. I think more tests on other architecture would be needed. I can test on ARM next week.

	Then I'll add such pause between the tests in the next
version. Let me know if you see any problems with different NUMA
configurations due to the chosen cache_factor.

	For now, I don't have a good idea how to change the
algorithm to use feedback from real estimation without
complicating it further. The only way to safely change
the chain limit immediately is as it is implemented now: stop
tasks, reallocate, relink and start tasks. If we want to
do it without stopping tasks, it violates the RCU-list
rules: we can not relink entries without RCU grace period.

	So, we have the following options:

1. Use this algorithm if it works in different configurations
2. Use this algorithm but trigger recalculation (stop, relink,
start) if a kthread with largest number of entries detects
big difference for chain_max
3. Implement different data structure to store estimators

	Currently, the problem comes from the fact that we
store estimators in chains. We should cut these chains if
chain_max should be reduced. Second option would be to
put estimators in ptr arrays but then there is a problem
with fragmentation on add/del and as result, slower walking.
Arrays probably can allow the limit used for cond_resched,
that is now chain_max, to be applied without relinking
entries.

	To summarize, the goals are:

- allocations for linking estimators should not be large (many
pages), prefer to allocate in small steps

- due to RCU-list rules we can not relink without task stop+start

- real estimation should give more accurate values for
the parameters: cond_resched rate

- fast lock-free walking of estimators by kthreads

- fast add/del of estimators, by netlink

- if possible, a way to avoid estimations for estimators
that are not updated, eg. added service/dest but no
traffic

- fast and safe way to apply a new chain_max or similar
parameter for cond_resched rate. If possible, without
relinking. stop+start can be slow too.

	While finishing this posting, I'm investigating
the idea to use structures without chains (no relinking),
without chain_len, tick_len, etc. But let me first see
if such idea can work...

Regards

--
Julian Anastasov <ja@ssi.bg>

