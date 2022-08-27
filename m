Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5196D5A3945
	for <lists+lvs-devel@lfdr.de>; Sat, 27 Aug 2022 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiH0Rmx (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 27 Aug 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiH0Rmx (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 27 Aug 2022 13:42:53 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A59C357DE
        for <lvs-devel@vger.kernel.org>; Sat, 27 Aug 2022 10:42:52 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 709C130652;
        Sat, 27 Aug 2022 20:42:51 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 2B5233064F;
        Sat, 27 Aug 2022 20:42:50 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 929233C0440;
        Sat, 27 Aug 2022 20:42:41 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 27RHgeeZ220807;
        Sat, 27 Aug 2022 20:42:40 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 27RHgU3M220775;
        Sat, 27 Aug 2022 20:42:30 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>, yunhjiang@ebay.com,
        dust.li@linux.alibaba.com, tangyang@zhihu.com
Subject: [RFC PATCH 0/4] Use kthreads for stats
Date:   Sat, 27 Aug 2022 20:41:50 +0300
Message-Id: <20220827174154.220651-1-ja@ssi.bg>
X-Mailer: git-send-email 2.37.2
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
Please review, comment, test, etc.

	Overview of the basic concepts. More in the
commit messages...

RCU Locking:

- when RCU preemption is enabled the kthreads use just RCU
lock for walking the chains and we do not need to reschedule.
May be this is the common case for distribution kernels.
In this case ip_vs_stop_estimator() is completely lockless.

- when RCU preemption is not enabled, we reschedule by using
refcnt for every estimator to track if the currently removed
estimator is used at the same time by kthread for estimation.
As RCU lock is unlocked during rescheduling, the deletion
should wait kd->mutex, so that a new RCU lock is applied
before the estimator is freed with RCU callback.

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

- to add new estimators we use the last added kthread
context (est_add_ktid). The new estimators are linked to
the chain just before the estimated one, based on add_row.
This ensures their estimation will start after 2 seconds.
If estimators are added in bursts, common case if all
services and dests are initially configured, we may
spread the estimators to more chains. This will reduce
the chain imbalance.

- the chain imbalance is not so fatal when we use
kthreads. We design each kthread for part of the
possible CPU usage, so even if some chain exceeds its
time slot it would happen all the time or sporadic
depending on the scheduling but still keeping the
2-second interval. The cpulist isolation can make
the things more stable as a 2-second time interval
per estimator.

Julian Anastasov (4):
  ipvs: add rcu protection to stats
  ipvs: use kthreads for stats estimation
  ipvs: add est_cpulist and est_nice sysctl vars
  ipvs: run_estimation should control the kthread tasks

 Documentation/networking/ipvs-sysctl.rst |  24 +-
 include/net/ip_vs.h                      | 144 +++++++-
 net/netfilter/ipvs/ip_vs_core.c          |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c           | 287 ++++++++++++++--
 net/netfilter/ipvs/ip_vs_est.c           | 408 +++++++++++++++++++----
 5 files changed, 771 insertions(+), 102 deletions(-)

-- 
2.37.2


