Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B75B292E
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Sep 2022 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIHWWE (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 8 Sep 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIHWV6 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 8 Sep 2022 18:21:58 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37323F2D62
        for <lvs-devel@vger.kernel.org>; Thu,  8 Sep 2022 15:21:57 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id B24D52BD64;
        Fri,  9 Sep 2022 01:21:54 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 3BAC22BE86;
        Fri,  9 Sep 2022 01:21:53 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 4A65D3C0437;
        Fri,  9 Sep 2022 01:21:52 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 288MLqwU147600;
        Fri, 9 Sep 2022 01:21:52 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 288MLlJ5147586;
        Fri, 9 Sep 2022 01:21:47 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv2 0/4] ipvs: Use kthreads for stats
Date:   Fri,  9 Sep 2022 01:21:05 +0300
Message-Id: <20220908222109.147452-1-ja@ssi.bg>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

	Hello,

	This patchset implements stats estimation in
kthread context. Simple tests do not show any problem.

	As it is late here, I'm sending v2 for
review. It is interesting to know what value for
IPVS_EST_TICK_CHAINS to use, it is used for the
IPVS_EST_MAX_COUNT calculation. We should determine
it from tests once the loops are in final form.
Now the limit increased a little bit to 38400.
Tomorrow I'll check again the patches for possible
problems.

	Overview of the basic concepts. More in the
commit messages...

RCU Locking:

- As stats are now RCU-locked, tot_stats, svc and dest which
hold estimator structures are now always freed from RCU
callback. This ensures RCU grace period after the
ip_vs_stop_estimator() call.

Kthread data:

- every kthread works over its own data structure and all
such structures are attached to array

- even while there can be a kthread structure, its task
may not be running, eg. before first service is added or
while the sysctl var is set to an empty cpulist or
when run_estimation is 0.

- a task and its structure may be released if all
estimators are unlinked from its chains, leaving the
slot in the array empty

- every kthread data structure allows limited number
of estimators

- to add new estimators we use the last added kthread
context (est_add_ktid). The new estimators are linked to
the chains just before the estimated one, based on add_row.
This ensures their estimation will start after 2 seconds.
If estimators are added in bursts, common case if all
services and dests are initially configured, we may
spread the estimators to more chains. This will reduce
the chain imbalance.

Not done yet:
* limit for kthreads (sysctl var)

Changes in v2:
Patch 2:
* kd->mutex is gone, cond_resched rate determined by
  IPVS_EST_CHAIN_DEPTH
* IPVS_EST_MAX_COUNT is a hard limit now
* kthread data is now 1-50 allocated tick structures,
  each containing heads for limited chains. Bitmaps
  should allow faster access. We avoid large
  allocations for structs.
* as the td->present bitmap is shared, use atomic bitops
* ip_vs_start_estimator now returns error code
* _bh locking removed from stats->lock
* bump arg is gone from ip_vs_est_reload_start
* prepare for upcoming changes that remove _irq
  from u64_stats_fetch_begin_irq/u64_stats_fetch_retry_irq
* est_add_ktid is now always valid
Patch 3:
* use .. in est_nice docs

Julian Anastasov (4):
  ipvs: add rcu protection to stats
  ipvs: use kthreads for stats estimation
  ipvs: add est_cpulist and est_nice sysctl vars
  ipvs: run_estimation should control the kthread tasks

 Documentation/networking/ipvs-sysctl.rst |  24 +-
 include/net/ip_vs.h                      | 122 +++++-
 net/netfilter/ipvs/ip_vs_core.c          |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c           | 367 +++++++++++++++---
 net/netfilter/ipvs/ip_vs_est.c           | 450 +++++++++++++++++++----
 5 files changed, 843 insertions(+), 130 deletions(-)

-- 
2.37.3


