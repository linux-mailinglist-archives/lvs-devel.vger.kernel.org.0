Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1835B580E
	for <lists+lvs-devel@lfdr.de>; Mon, 12 Sep 2022 12:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiILKTI (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 12 Sep 2022 06:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiILKTH (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 12 Sep 2022 06:19:07 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCD392AC62
        for <lvs-devel@vger.kernel.org>; Mon, 12 Sep 2022 03:19:06 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 30B0A118DE;
        Mon, 12 Sep 2022 13:19:06 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 9E9B7117C8;
        Mon, 12 Sep 2022 13:19:04 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 94ADE3C07CD;
        Mon, 12 Sep 2022 13:19:00 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 28CAJ03r012582;
        Mon, 12 Sep 2022 13:19:00 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 28CAIqMo012565;
        Mon, 12 Sep 2022 13:18:52 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv3 0/5] ipvs: Use kthreads for stats
Date:   Mon, 12 Sep 2022 13:18:33 +0300
Message-Id: <20220912101838.12522-1-ja@ssi.bg>
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

	Posting v3 (not final yet). New patch 5 just
for debugging, do not apply if not needed.

	This patchset implements stats estimation in
kthread context. Simple tests do not show any problem.

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
* start kthread to calculate chain_max_len and
IPVS_EST_TICK_CHAINS suitable for 100us cond_resched
rate and 10% of 40ms. Current value of IPVS_EST_TICK_CHAINS=48
determines tick time of 4.8ms (i.e. in units of 100us)
which is 12% of max tick time of 40ms. The question is
how valid will be such test. For example, we can add
all ests in temp list until the calculation is done and
then to requeue all estimators into the chains.

Changes in v3:
* calculate chain_max_len (was IPVS_EST_CHAIN_DEPTH) but
  it needs further tuning based on real estimation test
* est_max_threads set from rlimit(RLIMIT_NPROC). I don't
  see analog to get_ucounts_value() to get the max value.
* the atomic bitop for td->present is not needed,
  remove it
* start filling based on est_row after 2 ticks are
  fully allocated. As 2/50 is 4% this can be increased
  more.

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

Julian Anastasov (5):
  ipvs: add rcu protection to stats
  ipvs: use kthreads for stats estimation
  ipvs: add est_cpulist and est_nice sysctl vars
  ipvs: run_estimation should control the kthread tasks
  ipvs: debug the tick time

 Documentation/networking/ipvs-sysctl.rst |  24 +-
 include/net/ip_vs.h                      | 125 +++++-
 net/netfilter/ipvs/ip_vs_core.c          |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c           | 367 ++++++++++++++---
 net/netfilter/ipvs/ip_vs_est.c           | 487 +++++++++++++++++++----
 5 files changed, 883 insertions(+), 130 deletions(-)

-- 
2.37.3


