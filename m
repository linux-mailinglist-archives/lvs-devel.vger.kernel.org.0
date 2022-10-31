Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5761397A
	for <lists+lvs-devel@lfdr.de>; Mon, 31 Oct 2022 15:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiJaO5a (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 31 Oct 2022 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJaO5W (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 31 Oct 2022 10:57:22 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4DBCF037
        for <lvs-devel@vger.kernel.org>; Mon, 31 Oct 2022 07:57:20 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 4308F21AE3;
        Mon, 31 Oct 2022 16:57:20 +0200 (EET)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 231DF21A72;
        Mon, 31 Oct 2022 16:57:18 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id DF3D03C0437;
        Mon, 31 Oct 2022 16:57:07 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29VEv7Rt157012;
        Mon, 31 Oct 2022 16:57:07 +0200
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 29VEv235156995;
        Mon, 31 Oct 2022 16:57:02 +0200
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv6 0/7] ipvs: Use kthreads for stats
Date:   Mon, 31 Oct 2022 16:56:40 +0200
Message-Id: <20221031145647.156930-1-ja@ssi.bg>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

	Hello,

	Posting v6 (release candidate 1). New patch
inserted at 3th position. Patch 7 just for debugging,
do not apply if not needed. 

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
such structures are attached to array. For now we limit
kthreads depending on the number of CPUs.

- even while there can be a kthread structure, its task
may not be running, eg. before first service is added or
while the sysctl var is set to an empty cpulist or
when run_estimation is 0.

- the allocated kthread context may grow from 1 to 50
allocated structures for ticks which saves memory for
setups with small number of estimators

- a task and its structure may be released if all
estimators are unlinked from its chains, leaving the
slot in the array empty

- every kthread data structure allows limited number
of estimators. Kthread 0 is also used to initially
calculate the number of estimators to allow in every
chain considering a sub-100 microsecond cond_resched
rate. This number can be from 1 to hundreds.

- kthread 0 has an additional job of optimizing the
adding of estimators: they are first added in
temp list (est_temp_list) and later kthread 0
distributes them to other kthreads. The optimization
is based on the fact that newly added estimator
should be estimated after 2 seconds, so we have the
time to offload the adding to chain from controlling
process to kthread 0.

- to add new estimators we use the last added kthread
context (est_add_ktid). The new estimators are linked to
the chains just before the estimated one, based on add_row.
This ensures their estimation will start after 2 seconds.
If estimators are added in bursts, common case if all
services and dests are initially configured, we may
spread the estimators to more chains. This will reduce
the chain imbalance.

	There are things that I don't like but for now
I don't have a better idea for them:

- calculation of chain_max can go wrong, depending
on the current load, CPU speed, memory speeds, running in
VM, whether tested estimators are in CPU cache, even if
we are doing it in SCHED_FIFO mode or with BH disabled.
I expect such noise to be insignificant but who knows.

- ip_vs_stop_estimator is not a simple unlinking of
list node, we spend cycles to account for the removed
estimator

- the relinking does not preserve the delay for all
estimators. To solve it, we would need to pre-allocate
kthread data for all threads and then to enqueue stats in
parallel.

- __ip_vs_mutex is global mutex for all netns. But it
protects hash tables that are still global ones.


Changes in v6:
Patch 4 (was 3 in v5):
* while ests are in est_temp_list use est->ktrow as delay (offset
  from est_row) to apply on enqueue, initially or later when estimators
  are relinked. By this way we try to preserve the current timer delay
  on relinking. If there is no space in the desired time slot, the
  initial delay can be reduced, while on relinking the delay can be
  increased. Still, this is far from perfect and the relinking
  continues to apply wrong delay for some of the ests while its goal
  is still to fill kthreads data one by one.
* ip_vs_est_calc_limits() now relinks the entries trying to preserve
  the delay, ests with lowest delay will get higher chance to
  preserve it
* add_row is now not updated (it is wrong on relinking) but will continue
  to be used as starting position for the bit searching, so logic is
  preserved
* while relinking try to keep tot_stats in kt0, we do not want to keep
  some kthread 1..N just for it
* ip_vs_est_calc_limits() now performs 12 tests but sleeps for 20ms
  on every 4 tests to make sure CPU speed is increased
Patch 3:
* new patch that converts per-cpu counters to u64_stats_t

Changes in v5:
Patch 4 (was 3 in v4):
* use ip_vs_est_max_threads() helper
Patch 3 (was 2 in v4):
* kthread 0 now disables BH instead of using SCHED_FIFO mode,
  this should work because now we perform less number of repeated
  test over pre-allocated kd->calc_stats structure. Use
  cache_factor = 4 to approximate the time non-cached (due to large
  number) per-cpu stats are estimated compared to the cached data
  we estimate in calc phase. This needs to be tested with
  different number of CPUs and NUMA nodes.
* limit max threads using the formula 4 * Number of CPUs, not on rlimit
* remove _len suffix from vars like chain_max_len, tick_max_len,
  est_chain_max_len
Patch 2:
* new patch that adds functions for stats allocations

Changes in v4:
Patch 2:
* kthread 0 can start with calculation phase in SCHED_FIFO mode
  to determine chain_max_len suitable for 100us cond_resched
  rate and 12% of 40ms CPU usage in a tick. Current value of
  IPVS_EST_TICK_CHAINS=48 determines tick time of 4.8ms (i.e.
  in units of 100us) which is 12% of max tick time of 40ms.
  The question is how reliable will be such calculation test.
* est_calc_phase indicates a mode where we dequeue estimators
  from kthreads, apply new chain_max_len and enqueue again
  all estimators to kthreads, done by kthread 0
* est->ktid now can be -1 to indicate est is in est_temp_list
  ready to be distributed to kthread by kt 0, done in
  ip_vs_est_drain_temp_list(). kthread 0 data is now released
  only after the data for others kthreads
* ip_vs_start_estimator was not setting ret = 0
* READ_ONCE not needed for volatile jiffies
Patch 3:
* restrict cpulist based on the cpus_allowed of
  process that assigns cpulist, not on cpu_possible_mask
* change of cpulist will trigger calc phase
Patch 5:
* print message every minute, not 2 seconds

Changes in v3:
Patch 2:
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

Julian Anastasov (7):
  ipvs: add rcu protection to stats
  ipvs: use common functions for stats allocation
  ipvs: use u64_stats_t for the per-cpu counters
  ipvs: use kthreads for stats estimation
  ipvs: add est_cpulist and est_nice sysctl vars
  ipvs: run_estimation should control the kthread tasks
  ipvs: debug the tick time

 Documentation/networking/ipvs-sysctl.rst |  24 +-
 include/net/ip_vs.h                      | 154 +++-
 net/netfilter/ipvs/ip_vs_core.c          |  40 +-
 net/netfilter/ipvs/ip_vs_ctl.c           | 448 ++++++++---
 net/netfilter/ipvs/ip_vs_est.c           | 902 +++++++++++++++++++++--
 5 files changed, 1383 insertions(+), 185 deletions(-)

-- 
2.38.1


