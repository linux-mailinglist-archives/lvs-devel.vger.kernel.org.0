Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5F5ACB2F
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Sep 2022 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiIEGfQ (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Sep 2022 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiIEGev (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 5 Sep 2022 02:34:51 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1AF3337D
        for <lvs-devel@vger.kernel.org>; Sun,  4 Sep 2022 23:34:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VOMk3U6_1662359646;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VOMk3U6_1662359646)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 14:34:07 +0800
Date:   Mon, 5 Sep 2022 14:34:06 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     Julian Anastasov <ja@ssi.bg>, Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>, yunhjiang@ebay.com,
        tangyang@zhihu.com
Subject: Re: [RFC PATCH 0/4] Use kthreads for stats
Message-ID: <20220905063406.GA108825@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20220827174154.220651-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827174154.220651-1-ja@ssi.bg>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Sat, Aug 27, 2022 at 08:41:50PM +0300, Julian Anastasov wrote:
>	Hello,
>
>	This patchset implements stats estimation in
>kthread context. Simple tests do not show any problem.
>Please review, comment, test, etc.

Hi, Julian:

Thanks a lot for your work! I tested the patchset, until now, it all
works well.

On my test server with 64 CPUs and 1 million rules. The total
CPU cost of all ipvs kthreads is about 67% of 1 CPU(31 ipvs threads).
No ping slow detected.

Tested-by: Dust Li <dust.li@linux.alibaba.com>

>
>	Overview of the basic concepts. More in the
>commit messages...
>
>RCU Locking:
>
>- when RCU preemption is enabled the kthreads use just RCU
>lock for walking the chains and we do not need to reschedule.
>May be this is the common case for distribution kernels.
>In this case ip_vs_stop_estimator() is completely lockless.
>
>- when RCU preemption is not enabled, we reschedule by using
>refcnt for every estimator to track if the currently removed
>estimator is used at the same time by kthread for estimation.
>As RCU lock is unlocked during rescheduling, the deletion
>should wait kd->mutex, so that a new RCU lock is applied
>before the estimator is freed with RCU callback.
>
>- As stats are now RCU-locked, tot_stats, svc and dest which
>hold estimator structures are now always freed from RCU
>callback. This ensures RCU grace period after the
>ip_vs_stop_estimator() call.
>
>Kthread data:
>
>- every kthread works over its own data structure and all
>such structures are attached to array
>
>- even while there can be a kthread structure, its task
>may not be running, eg. before first service is added or
>while the sysctl var is set to an empty cpulist or
>when run_estimation is 0.
>
>- a task and its structure may be released if all
>estimators are unlinked from its chains, leaving the
>slot in the array empty
>
>- to add new estimators we use the last added kthread
>context (est_add_ktid). The new estimators are linked to
>the chain just before the estimated one, based on add_row.
>This ensures their estimation will start after 2 seconds.
>If estimators are added in bursts, common case if all
>services and dests are initially configured, we may
>spread the estimators to more chains. This will reduce
>the chain imbalance.
>
>- the chain imbalance is not so fatal when we use
>kthreads. We design each kthread for part of the
>possible CPU usage, so even if some chain exceeds its
>time slot it would happen all the time or sporadic
>depending on the scheduling but still keeping the
>2-second interval. The cpulist isolation can make
>the things more stable as a 2-second time interval
>per estimator.
>
>Julian Anastasov (4):
>  ipvs: add rcu protection to stats
>  ipvs: use kthreads for stats estimation
>  ipvs: add est_cpulist and est_nice sysctl vars
>  ipvs: run_estimation should control the kthread tasks
>
> Documentation/networking/ipvs-sysctl.rst |  24 +-
> include/net/ip_vs.h                      | 144 +++++++-
> net/netfilter/ipvs/ip_vs_core.c          |  10 +-
> net/netfilter/ipvs/ip_vs_ctl.c           | 287 ++++++++++++++--
> net/netfilter/ipvs/ip_vs_est.c           | 408 +++++++++++++++++++----
> 5 files changed, 771 insertions(+), 102 deletions(-)
>
>-- 
>2.37.2
