Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019985FF969
	for <lists+lvs-devel@lfdr.de>; Sat, 15 Oct 2022 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJOJWD (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 15 Oct 2022 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJOJWB (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 15 Oct 2022 05:22:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB24CA08
        for <lvs-devel@vger.kernel.org>; Sat, 15 Oct 2022 02:22:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB7941F385;
        Sat, 15 Oct 2022 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665825718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zz+ZD8mD7N77+oQcI0k29Bl7HQBKuqbOCElnh15PKJ8=;
        b=gq7iKsECVaCybb8Rb7XeWs1aKzODeu8ZHIrzRFoA/aNoTA4KkOkGyjySOBbmUFbHID3Rac
        LMt2Sp0/r9VYoIT1PW4ic/rfcPAlcukeBNNsbb6Ct9KK3RyYEY8a4RMauDsSPA4SG7prBJ
        t/q0mWrpyNpWaFOP1b3C6xbXiMIQ5ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665825718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zz+ZD8mD7N77+oQcI0k29Bl7HQBKuqbOCElnh15PKJ8=;
        b=MWkygRydO4s/h2tLiIIVW4KFJRMCcUMIsrQNKCH5pLIfJsg8rWpSsztnwc9flbsXGGxv73
        ylFifY2vqZkOFCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2A47139F3;
        Sat, 15 Oct 2022 09:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nm8nJ7Z7SmOzZwAAMHmgww
        (envelope-from <jwiesner@suse.de>); Sat, 15 Oct 2022 09:21:58 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 2DDB119CFC; Sat, 15 Oct 2022 11:21:58 +0200 (CEST)
Date:   Sat, 15 Oct 2022 11:21:58 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv5 3/6] ipvs: use kthreads for stats estimation
Message-ID: <20221015092158.GA3484@incl>
References: <20221009153710.125919-1-ja@ssi.bg>
 <20221009153710.125919-4-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009153710.125919-4-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Sun, Oct 09, 2022 at 06:37:07PM +0300, Julian Anastasov wrote:
> +/* Calculate limits for all kthreads */
> +static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
> +{
> +	struct ip_vs_est_kt_data *kd;
> +	struct ip_vs_stats *s;
> +	struct hlist_head chain;
> +	int cache_factor = 4;
> +	int i, loops, ntest;
> +	s32 min_est = 0;
> +	ktime_t t1, t2;
> +	s64 diff, val;
> +	int max = 8;
> +	int ret = 1;
> +
> +	INIT_HLIST_HEAD(&chain);
> +	mutex_lock(&__ip_vs_mutex);
> +	kd = ipvs->est_kt_arr[0];
> +	mutex_unlock(&__ip_vs_mutex);
> +	s = kd ? kd->calc_stats : NULL;
> +	if (!s)
> +		goto out;
> +	hlist_add_head(&s->est.list, &chain);
> +
> +	loops = 1;
> +	/* Get best result from many tests */
> +	for (ntest = 0; ntest < 3; ntest++) {
> +		local_bh_disable();
> +		rcu_read_lock();
> +
> +		/* Put stats in cache */
> +		ip_vs_chain_estimation(&chain);
> +
> +		t1 = ktime_get();
> +		for (i = loops * cache_factor; i > 0; i--)
> +			ip_vs_chain_estimation(&chain);
> +		t2 = ktime_get();

I have tested this. There is one problem: When the calc phase is carried out for the first time after booting the kernel the diff is several times higher than what is should be - it was 7325 ns on my testing machine. The wrong chain_max value causes 15 kthreads to be created when 500,000 estimators have been added, which is not abysmal (It's better to underestimate chain_max than to overestimate it) but not optimal either. When the ip_vs module is unloaded and then a new service is added again the diff has the expected value. The commands:
> # ipvsadm -A -t 10.10.10.1:2000
> # ipvsadm -D -t 10.10.10.1:2000; modprobe -r ip_vs_wlc ip_vs
> # ipvsadm -A -t 10.10.10.1:2000
The kernel log:
> [  200.020287] IPVS: ipvs loaded.
> [  200.036128] IPVS: starting estimator thread 0...
> [  200.042213] IPVS: calc: chain_max=12, single est=7319ns, diff=7325, loops=1, ntest=3
> [  200.051714] IPVS: dequeue: 49ns
> [  200.056024] IPVS: using max 576 ests per chain, 28800 per kthread
> [  201.983034] IPVS: tick time: 6057ns for 64 CPUs, 2 ests, 1 chains, chain_max=576
> [  237.555043] IPVS: stop unused estimator thread 0...
> [  237.599116] IPVS: ipvs unloaded.
> [  268.533028] IPVS: ipvs loaded.
> [  268.548401] IPVS: starting estimator thread 0...
> [  268.554472] IPVS: calc: chain_max=33, single est=2834ns, diff=2834, loops=1, ntest=3
> [  268.563972] IPVS: dequeue: 68ns
> [  268.568292] IPVS: using max 1584 ests per chain, 79200 per kthread
> [  270.495032] IPVS: tick time: 5761ns for 64 CPUs, 2 ests, 1 chains, chain_max=1584
> [  307.847045] IPVS: stop unused estimator thread 0...
> [  307.891101] IPVS: ipvs unloaded.
Loading the module and adding a service a third time gives a diff that is close enough to the expected value:
> [  312.807107] IPVS: ipvs loaded.
> [  312.823972] IPVS: starting estimator thread 0...
> [  312.829967] IPVS: calc: chain_max=38, single est=2444ns, diff=2477, loops=1, ntest=3
> [  312.839470] IPVS: dequeue: 66ns
> [  312.843800] IPVS: using max 1824 ests per chain, 91200 per kthread
> [  314.771028] IPVS: tick time: 5703ns for 64 CPUs, 2 ests, 1 chains, chain_max=1824
Here is a distribution of the time needed to process one estimator - the average value is around 2900 ns (on my testing machine):
> dmesg | awk '/tick time:/ {d = $(NF - 8); sub("ns", "", d); d /= $(NF - 4); d = int(d / 100) * 100; hist[d]++} END {PROCINFO["sorted_in"] = "@ind_num_asc"; for (d in hist) printf "%5d %5d\n", d, hist[d]}'
>  2500     2
>  2700     1
>  2800   243
>  2900   427
>  3000    20
>  3100     1
>  3500     1
>  3600     1
>  3700     1
>  4900     1
I am not sure why the first 3 tests give such a high diff value but the diff value is much closer to the read average time after the module is loaded a second time.

I ran more tests. All I did was increase ntests to 3000. The diff had a much more realistic value even when the calc phase was carried out for the first time:
> [   98.804037] IPVS: ipvs loaded.
> [   98.819451] IPVS: starting estimator thread 0...
> [   98.834960] IPVS: calc: chain_max=39, single est=2418ns, diff=2464, loops=1, ntest=3000
> [   98.844775] IPVS: dequeue: 67ns
> [   98.849091] IPVS: using max 1872 ests per chain, 93600 per kthread
> [  100.767346] IPVS: tick time: 5895ns for 64 CPUs, 2 ests, 1 chains, chain_max=1872
> [  107.419344] IPVS: stop unused estimator thread 0...
> [  107.459423] IPVS: ipvs unloaded.
> [  114.421324] IPVS: ipvs loaded.
> [  114.435151] IPVS: starting estimator thread 0...
> [  114.451304] IPVS: calc: chain_max=36, single est=2627ns, diff=8136, loops=1, ntest=3000
> [  114.461079] IPVS: dequeue: 77ns
> [  114.465389] IPVS: using max 1728 ests per chain, 86400 per kthread
> [  116.388968] IPVS: tick time: 1632749ns for 64 CPUs, 1433 ests, 1 chains, chain_max=1728
> [  180.387030] IPVS: tick time: 3686870ns for 64 CPUs, 1728 ests, 1 chains, chain_max=1728
> [  232.507642] IPVS: starting estimator thread 1...
> [  244.387184] IPVS: tick time: 3846122ns for 64 CPUs, 1728 ests, 1 chains, chain_max=1728
> [  308.387170] IPVS: tick time: 3835769ns for 64 CPUs, 1728 ests, 1 chains, chain_max=1728
> [  358.227680] IPVS: starting estimator thread 2...
> [  372.387177] IPVS: tick time: 3841369ns for 64 CPUs, 1728 ests, 1 chains, chain_max=1728
> [  436.387204] IPVS: tick time: 3869654ns for 64 CPUs, 1728 ests, 1 chains, chain_max=1728
Setting ntests to 3000 is probably overkill. The message is that increasing ntests is needed to get a realistic value of the diff. When I added 500,000 estimators 5 kthreads where created, which I think is reasonable. After adding 500,000 estimators, the time needed to process one estimator decreased from 2900 ms to circa 2200 ms when a kthread is fully loaded, which I do not think is necessarily a problem.

> +
> +		rcu_read_unlock();
> +		local_bh_enable();
> +
> +		if (!ipvs->enable || kthread_should_stop())
> +			goto stop;
> +		cond_resched();
> +
> +		diff = ktime_to_ns(ktime_sub(t2, t1));
> +		if (diff <= 1 * NSEC_PER_USEC) {
> +			/* Do more loops on low resolution */
> +			loops *= 2;
> +			continue;
> +		}
> +		if (diff >= NSEC_PER_SEC)
> +			continue;
> +		val = diff;
> +		do_div(val, loops);
> +		if (!min_est || val < min_est) {
> +			min_est = val;
> +			/* goal: 95usec per chain */
> +			val = 95 * NSEC_PER_USEC;
> +			if (val >= min_est) {
> +				do_div(val, min_est);
> +				max = (int)val;
> +			} else {
> +				max = 1;
> +			}
> +		}
> +	}
> +
> +out:
> +	if (s)
> +		hlist_del_init(&s->est.list);
> +	*chain_max = max;
> +	return ret;
> +
> +stop:
> +	ret = 0;
> +	goto out;
> +}

-- 
Jiri Wiesner
SUSE Labs
