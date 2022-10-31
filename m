Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E9613979
	for <lists+lvs-devel@lfdr.de>; Mon, 31 Oct 2022 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiJaO53 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 31 Oct 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiJaO5U (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 31 Oct 2022 10:57:20 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA2BA1007E
        for <lvs-devel@vger.kernel.org>; Mon, 31 Oct 2022 07:57:18 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 44C7D21AE1;
        Mon, 31 Oct 2022 16:57:18 +0200 (EET)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 2148C219CD;
        Mon, 31 Oct 2022 16:57:16 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id DF4923C0505;
        Mon, 31 Oct 2022 16:57:08 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29VEv8so157043;
        Mon, 31 Oct 2022 16:57:08 +0200
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 29VEv8f1157042;
        Mon, 31 Oct 2022 16:57:08 +0200
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv6 7/7] ipvs: debug the tick time
Date:   Mon, 31 Oct 2022 16:56:47 +0200
Message-Id: <20221031145647.156930-8-ja@ssi.bg>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031145647.156930-1-ja@ssi.bg>
References: <20221031145647.156930-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Just for testing print the tick time every minute

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_est.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index 526100976d59..4489a3dbad1e 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -147,7 +147,14 @@ static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
 {
 	struct ip_vs_est_tick_data *td;
 	int cid;
-
+	u64 ns = 0;
+	static int used_row = -1;
+	static int pass;
+
+	if (used_row < 0)
+		used_row = row;
+	if (row == used_row && !kd->id && !(pass & 31))
+		ns = ktime_get_ns();
 	rcu_read_lock();
 	td = rcu_dereference(kd->ticks[row]);
 	if (!td)
@@ -164,6 +171,16 @@ static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
 
 out:
 	rcu_read_unlock();
+	if (row == used_row && !kd->id && !(pass++ & 31)) {
+		static int ncpu;
+
+		ns = ktime_get_ns() - ns;
+		if (!ncpu)
+			ncpu = num_possible_cpus();
+		pr_info("tick time: %lluns for %d CPUs, %d ests, %d chains, chain_max=%d\n",
+			(unsigned long long)ns, ncpu, kd->tick_len[row],
+			IPVS_EST_TICK_CHAINS, kd->chain_max);
+	}
 }
 
 static int ip_vs_estimation_kthread(void *data)
@@ -637,7 +654,7 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
 	int i, loops, ntest;
 	s32 min_est = 0;
 	ktime_t t1, t2;
-	s64 diff, val;
+	s64 diff = 0, val;
 	int max = 8;
 	int ret = 1;
 
@@ -702,6 +719,8 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
 	}
 
 out:
+	pr_info("calc: chain_max=%d, single est=%dns, diff=%d, loops=%d, ntest=%d\n",
+		max, min_est, (int)diff, loops, ntest);
 	if (s)
 		hlist_del_init(&s->est.list);
 	*chain_max = max;
@@ -737,6 +756,7 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	int id, row, cid, delay;
 	bool last, last_td;
 	int chain_max;
+	u64 ns = 0;
 	int step;
 
 	if (!ip_vs_est_calc_limits(ipvs, &chain_max))
@@ -770,6 +790,8 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	 */
 	delay = IPVS_EST_NTICKS;
 
+	ns = ktime_get_ns();
+
 next_delay:
 	delay--;
 	if (delay < 0)
@@ -856,6 +878,8 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	goto walk_chain;
 
 end_dequeue:
+	ns = ktime_get_ns() - ns;
+	pr_info("dequeue: %lluns\n", (unsigned long long)ns);
 	/* All estimators removed while calculating ? */
 	if (!ipvs->est_kt_count)
 		goto unlock;
-- 
2.38.1


