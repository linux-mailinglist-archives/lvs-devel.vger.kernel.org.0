Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8955B0C2D
	for <lists+lvs-devel@lfdr.de>; Wed,  7 Sep 2022 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIGSHg (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 7 Sep 2022 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGSHb (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 7 Sep 2022 14:07:31 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9996474CD0
        for <lvs-devel@vger.kernel.org>; Wed,  7 Sep 2022 11:07:29 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 9421824AD3;
        Wed,  7 Sep 2022 21:07:27 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 389F124B1D;
        Wed,  7 Sep 2022 21:07:26 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id E3A533C0437;
        Wed,  7 Sep 2022 21:07:24 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 287I7IN7125851;
        Wed, 7 Sep 2022 21:07:20 +0300
Date:   Wed, 7 Sep 2022 21:07:18 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     "dust.li" <dust.li@linux.alibaba.com>
cc:     Jiri Wiesner <jwiesner@suse.de>, Simon Horman <horms@verge.net.au>,
        lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>
Subject: Re: [RFC PATCH 2/4] ipvs: use kthreads for stats estimation
In-Reply-To: <20220905064725.GB108825@linux.alibaba.com>
Message-ID: <ff10274b-a0a0-9667-f878-99142a3ecca5@ssi.bg>
References: <20220827174154.220651-1-ja@ssi.bg> <20220827174154.220651-3-ja@ssi.bg> <20220905064725.GB108825@linux.alibaba.com>
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

On Mon, 5 Sep 2022, dust.li wrote:

> >+static inline void ip_vs_est_wait_resched(struct netns_ipvs *ipvs,
> >+					  struct ip_vs_estimator *est)
> >+{
> >+#ifdef IPVS_EST_RESCHED_RCU
> >+	/* Estimator kthread is rescheduling on deleted est? Wait it! */
> >+	if (!refcount_dec_and_test(&est->refcnt)) {
> >+		struct ip_vs_est_kt_data *kd = ipvs->est_kt_arr[est->ktid];
> >+
> >+		mutex_lock(&kd->mutex);
> >+		mutex_unlock(&kd->mutex);
> 
> IIUC, this mutex_lock/unlock() is just used for waiting for the ipvs-e
> thread schedule back if it had been scheduled out in cond_resched_rcu() ?
> But not to protect data ?

	Yes

> If so, I am wondering if we can remove the mutex_trylock/unlock() in
> ip_vs_est_cond_resched_rcu, and use some wait/wakeup mechanism to do
> this ? Because when I run perf on 'ipvs-e' kthreads, I saw lots of CPU
> cycles are on the mutex_trylock.

	Yes, wait/wakeup would be better alternative, it will
avoid the possible priority inversion as Jiri noticed.

	Probably, the rate of rescheduling can be reduced,
so that we can achieve sub-millisecond latency. But the time
we spend in the for_each_possible_cpu() loop depends on the
number of possible CPUs, they can have different speed.
I thought of checking initially with need_resched() before
mutex_trylock() but when RCU preemption is disabled, the RCU
reader side is a region with disabled preemption and we should
call cond_resched() often to report a quiescent state with
rcu_all_qs().

For example:

- goal: sub-100-microsecond cond_resched rate to
report a quiescent state and to be nice to other kthreads

	if (!(++resched_counter & 15) || need_resched()) ...

	Thank you for the review and testing!

Regards

--
Julian Anastasov <ja@ssi.bg>

