Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079185B4272
	for <lists+lvs-devel@lfdr.de>; Sat, 10 Sep 2022 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIIWXb (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 9 Sep 2022 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIWXa (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 9 Sep 2022 18:23:30 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CFA86C0F
        for <lvs-devel@vger.kernel.org>; Fri,  9 Sep 2022 15:23:28 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 9AF6F80EC;
        Sat, 10 Sep 2022 01:23:25 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id DC03C80E7;
        Sat, 10 Sep 2022 01:23:23 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 3AB603C0439;
        Sat, 10 Sep 2022 01:23:23 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 289MNJrd156324;
        Sat, 10 Sep 2022 01:23:20 +0300
Date:   Sat, 10 Sep 2022 01:23:19 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv2 0/4] ipvs: Use kthreads for stats
In-Reply-To: <20220909194956.GJ18621@incl>
Message-ID: <9b936c4a-cbd1-bb4f-8657-55bd9855f7ef@ssi.bg>
References: <20220908222109.147452-1-ja@ssi.bg> <20220909194956.GJ18621@incl>
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

On Fri, 9 Sep 2022, Jiri Wiesner wrote:

> On Fri, Sep 09, 2022 at 01:21:05AM +0300, Julian Anastasov wrote:
> > It is interesting to know what value for
> > IPVS_EST_TICK_CHAINS to use, it is used for the
> > IPVS_EST_MAX_COUNT calculation. We should determine
> > it from tests once the loops are in final form.
> > Now the limit increased a little bit to 38400.
> > Tomorrow I'll check again the patches for possible
> > problems.
> 
> I couldn't wait so I have run tests on various machines and used the sched_switch tracepoint to measure the time needed to process one chain. The table contains a median time for processing one chain, the maximum time measured, the median divided by the number of CPUs and the time needed to process one chain if there were 1024 CPUs of that type in a machine:
> > NR         CPU                       Time(ms)  Max(ms)  Time/CPU(ms)  1024 CPUs(ms)
> > 48 Intel Xeon CPU E5-2670 v3, 2 nodes   1.220    1.343         0.025     26.027
> > 64 Intel Xeon Gold 6326, 2 nodes        0.920    1.494         0.014     14.720
> > 192 Intel Xeon Gold 6330H, 4 nodes      3.957    4.153         0.021     21.104
> > 256 AMD EPYC 7713, 2 NUMA nodes         3.927    5.464         0.015     15.708
> >  80 ARM Neoverse-N1, 1 NUMA node        1.833    2.502         0.023     23.462
> > 128 ARM Kunpeng 920, 4 NUMA nodes       3.822    4.635         0.030     30.576
> I have to admit I was hoping the current IPVS_EST_CHAIN_DEPTH would work on machines with more than 1024 CPUs. If the max time values are used the time needed to process one chain on a 1024 CPU machine gets even closer to 40 ms, which it must not reach lest the estimates become inaccurate. I also have profiling data so I intend to look at the disassembly of ip_vs_estimation_kthread() to see which instructions take the most time. I will take a look at the v2 of the code on Monday.

	v2 uses find_next_bit in for_each_set_bit which has
cost. But we should not be surprised, if 268ms are for 50000
estimators on 104 CPUs (I guess this is also the number of
possible CPUs we actually use), one estimator reads from
104 CPUs for 5.36 microsecs, we can conclude for 1024 CPUs
the following:

Num Est		104 CPU		1024 CPU
========================================
1		5.36us		53us
4		21us		211us
16		86us		845us

	The v2 algorithm allows IPVS_EST_CHAIN_DEPTH to
be changed to var which we can determine based on the CPU
count, more CPUs will need more threads and we have CPUs
for them:

kd->chain_depth = max(1800 / num_possible_cpus(), 2);

Goals:
- chain time: sub-100 usec cond_resched rate
- tick time: 10% of max 40ms

CPUs	Depth	est_max_count	Chain Time	Tick Time
=========================================================
4	450	1080000		93us		4453us
16	112	268800		92us		4433us
104	17	40800		91us		4374us
1024	2	4800		106us		5066us
4096	2	4800		422us		20265us

Summary:

- For 4096 CPUs we can start 208 kthreads for 1000000 ests,
crazy :)

- 4096 CPUs need to be fast to go below these 20ms or we
should use chain with 1 estimator for 2048+ CPUs

	If we track somehow when a stats is updated,
may be we can skip estimators that are idle for
some time, this can save CPU cycles for estimating
unused dests.

	Also, I'm investigating the idea to use
task_rlimit(current, RLIMIT_NPROC) as kthread limit when
first service is added and to save it into
ipvs->est_max_threads.

	Another idea is ip_vs_estimation_kthread not to
change add_row but ip_vs_start_estimator to consider instead
est_row for the same purpose but only when kd->est_count
becomes large, say 2 * IPVS_EST_TICK_CHAINS * kd->chain_depth.
The idea is to fill 2 ticks completely when small number
of estimators are added and to prefer est_row when
we exceed this threshold and prefer to spread the
estimators to more ticks by honouring the 2-second
initial timer.

	For example:

	if (kd->est_count >= 2 * IPVS_EST_TICK_CHAINS *
	    kd->chain_depth)
		crow = READ_ONCE(kd->est_row);
	else
		crow = READ_ONCE(kd->add_row);
	crow--;
	...

Regards

--
Julian Anastasov <ja@ssi.bg>

