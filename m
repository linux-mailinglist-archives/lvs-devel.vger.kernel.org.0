Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21145FFF10
	for <lists+lvs-devel@lfdr.de>; Sun, 16 Oct 2022 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJPMV2 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 16 Oct 2022 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPMV1 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 16 Oct 2022 08:21:27 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFD1132D8C
        for <lvs-devel@vger.kernel.org>; Sun, 16 Oct 2022 05:21:24 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 8721E23406;
        Sun, 16 Oct 2022 15:21:22 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id E1D3B2337E;
        Sun, 16 Oct 2022 15:21:20 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 99B763C0437;
        Sun, 16 Oct 2022 15:21:19 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29GCLAIN033051;
        Sun, 16 Oct 2022 15:21:12 +0300
Date:   Sun, 16 Oct 2022 15:21:10 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv5 3/6] ipvs: use kthreads for stats estimation
In-Reply-To: <20221015092158.GA3484@incl>
Message-ID: <64d2975-357d-75f7-1d34-c43a1b3fc72a@ssi.bg>
References: <20221009153710.125919-1-ja@ssi.bg> <20221009153710.125919-4-ja@ssi.bg> <20221015092158.GA3484@incl>
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

On Sat, 15 Oct 2022, Jiri Wiesner wrote:

> On Sun, Oct 09, 2022 at 06:37:07PM +0300, Julian Anastasov wrote:
> > +/* Calculate limits for all kthreads */
> > +static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
> > +{
> > +	struct ip_vs_est_kt_data *kd;
> > +	struct ip_vs_stats *s;
> > +	struct hlist_head chain;
> > +	int cache_factor = 4;
> > +	int i, loops, ntest;
> > +	s32 min_est = 0;
> > +	ktime_t t1, t2;
> > +	s64 diff, val;
> > +	int max = 8;
> > +	int ret = 1;
> > +
> > +	INIT_HLIST_HEAD(&chain);
> > +	mutex_lock(&__ip_vs_mutex);
> > +	kd = ipvs->est_kt_arr[0];
> > +	mutex_unlock(&__ip_vs_mutex);
> > +	s = kd ? kd->calc_stats : NULL;
> > +	if (!s)
> > +		goto out;
> > +	hlist_add_head(&s->est.list, &chain);
> > +
> > +	loops = 1;
> > +	/* Get best result from many tests */
> > +	for (ntest = 0; ntest < 3; ntest++) {
> > +		local_bh_disable();
> > +		rcu_read_lock();
> > +
> > +		/* Put stats in cache */
> > +		ip_vs_chain_estimation(&chain);
> > +
> > +		t1 = ktime_get();
> > +		for (i = loops * cache_factor; i > 0; i--)
> > +			ip_vs_chain_estimation(&chain);
> > +		t2 = ktime_get();
> 
> I have tested this. There is one problem: When the calc phase is carried out for the first time after booting the kernel the diff is several times higher than what is should be - it was 7325 ns on my testing machine. The wrong chain_max value causes 15 kthreads to be created when 500,000 estimators have been added, which is not abysmal (It's better to underestimate chain_max than to overestimate it) but not optimal either. When the ip_vs module is unloaded and then a new service is added again the diff has the expected value. The commands:

	Yes, our goal allows underestimation of the tick time,
2-3 times is expected and not a big deal.

> > # ipvsadm -A -t 10.10.10.1:2000
> > # ipvsadm -D -t 10.10.10.1:2000; modprobe -r ip_vs_wlc ip_vs
> > # ipvsadm -A -t 10.10.10.1:2000
> The kernel log:
> > [  200.020287] IPVS: ipvs loaded.
> > [  200.036128] IPVS: starting estimator thread 0...
> > [  200.042213] IPVS: calc: chain_max=12, single est=7319ns, diff=7325, loops=1, ntest=3
> > [  200.051714] IPVS: dequeue: 49ns
> > [  200.056024] IPVS: using max 576 ests per chain, 28800 per kthread
> > [  201.983034] IPVS: tick time: 6057ns for 64 CPUs, 2 ests, 1 chains, chain_max=576

	It is not a problem to add some wait_event_idle_timeout
calls to sleep before/between tests if the system is so busy
on boot that it can even disturb our tests with disabled BHs.
May be there are many IRQs that interrupt us. We have 2 seconds
for the first tests, so we can add some gaps. If you want to
test it you can add some schedule_timeout(HZ/10) between the
3 tests (total 300ms delay of the real estimation).

	Another option is to implement some clever way to dynamically
adjust chain_max in the background depending on the load.
But it is difficult to react on all changes in the system
because while tests run in privileged mode with BHs disabled,
this is not true later. If real estimation deviates from
the determined chain_max more than 4 times (average for some period)
we can trigger some relinking with the goal to increase/decrease
the kthreads. kt 0 can do such measurements.

> > [  237.555043] IPVS: stop unused estimator thread 0...
> > [  237.599116] IPVS: ipvs unloaded.
> > [  268.533028] IPVS: ipvs loaded.
> > [  268.548401] IPVS: starting estimator thread 0...
> > [  268.554472] IPVS: calc: chain_max=33, single est=2834ns, diff=2834, loops=1, ntest=3
> > [  268.563972] IPVS: dequeue: 68ns
> > [  268.568292] IPVS: using max 1584 ests per chain, 79200 per kthread
> > [  270.495032] IPVS: tick time: 5761ns for 64 CPUs, 2 ests, 1 chains, chain_max=1584
> > [  307.847045] IPVS: stop unused estimator thread 0...
> > [  307.891101] IPVS: ipvs unloaded.
> Loading the module and adding a service a third time gives a diff that is close enough to the expected value:
> > [  312.807107] IPVS: ipvs loaded.
> > [  312.823972] IPVS: starting estimator thread 0...
> > [  312.829967] IPVS: calc: chain_max=38, single est=2444ns, diff=2477, loops=1, ntest=3
> > [  312.839470] IPVS: dequeue: 66ns
> > [  312.843800] IPVS: using max 1824 ests per chain, 91200 per kthread
> > [  314.771028] IPVS: tick time: 5703ns for 64 CPUs, 2 ests, 1 chains, chain_max=1824
> Here is a distribution of the time needed to process one estimator - the average value is around 2900 ns (on my testing machine):
> > dmesg | awk '/tick time:/ {d = $(NF - 8); sub("ns", "", d); d /= $(NF - 4); d = int(d / 100) * 100; hist[d]++} END {PROCINFO["sorted_in"] = "@ind_num_asc"; for (d in hist) printf "%5d %5d\n", d, hist[d]}'
> >  2500     2
> >  2700     1
> >  2800   243
> >  2900   427
> >  3000    20
> >  3100     1
> >  3500     1
> >  3600     1
> >  3700     1
> >  4900     1
> I am not sure why the first 3 tests give such a high diff value but the diff value is much closer to the read average time after the module is loaded a second time.
> 
> I ran more tests. All I did was increase ntests to 3000. The diff had a much more realistic value even when the calc phase was carried out for the first time:

	Yes, more tests should give more accurate results
for the current load. But load can change.

Regards

--
Julian Anastasov <ja@ssi.bg>

