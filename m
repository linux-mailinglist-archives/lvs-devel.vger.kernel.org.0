Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF985BE7B5
	for <lists+lvs-devel@lfdr.de>; Tue, 20 Sep 2022 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiITNzU (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 20 Sep 2022 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiITNzF (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 20 Sep 2022 09:55:05 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235095A2D6
        for <lvs-devel@vger.kernel.org>; Tue, 20 Sep 2022 06:54:07 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 04CB824EE7;
        Tue, 20 Sep 2022 16:54:05 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 95C3525111;
        Tue, 20 Sep 2022 16:54:03 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 289143C07CE;
        Tue, 20 Sep 2022 16:54:01 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 28KDs0lR153854;
        Tue, 20 Sep 2022 16:54:00 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 28KDs0uI153853;
        Tue, 20 Sep 2022 16:54:00 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv4 5/5] ipvs: debug the tick time
Date:   Tue, 20 Sep 2022 16:53:32 +0300
Message-Id: <20220920135332.153732-6-ja@ssi.bg>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920135332.153732-1-ja@ssi.bg>
References: <20220920135332.153732-1-ja@ssi.bg>
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
index 38a6c8ab308b..e214aa0b3abe 100644
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
+		pr_info("tick time: %lluns for %d CPUs, %d ests, %d chains, chain_max_len=%d\n",
+			(unsigned long long)ns, ncpu, kd->tick_len[row],
+			IPVS_EST_TICK_CHAINS, kd->chain_max_len);
+	}
 }
 
 static int ip_vs_estimation_kthread(void *data)
@@ -617,7 +634,7 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max_len)
 	bool is_fifo = false;
 	s32 min_est = 0;
 	ktime_t t1, t2;
-	s64 diff, val;
+	s64 diff = 0, val;
 	int retry = 0;
 	int max = 2;
 	int ret = 1;
@@ -707,6 +724,8 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max_len)
 out:
 	if (is_fifo)
 		sched_set_normal(current, sysctl_est_nice(ipvs));
+	pr_info("calc: chain_max_len=%d, single est=%dns, diff=%d, retry=%d, ntest=%d\n",
+		max, min_est, (int)diff, retry, ntest);
 	for (;;) {
 		est = hlist_entry_safe(chain.first, struct ip_vs_estimator,
 				       list);
@@ -752,6 +771,7 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	int chain_max_len;
 	int id, row, cid;
 	bool last, last_td;
+	u64 ns = 0;
 	int step;
 
 	if (!ip_vs_est_calc_limits(ipvs, &chain_max_len))
@@ -780,6 +800,8 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	 */
 	step = 0;
 
+	ns = ktime_get_ns();
+
 next_kt:
 	/* Destroy contexts backwards */
 	id = ipvs->est_kt_count - 1;
@@ -858,6 +880,8 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	goto walk_chain;
 
 end_dequeue:
+	ns = ktime_get_ns() - ns;
+	pr_info("dequeue: %lluns\n", (unsigned long long)ns);
 	/* All estimators removed while calculating ? */
 	if (!ipvs->est_kt_count)
 		goto unlock;
-- 
2.37.3


