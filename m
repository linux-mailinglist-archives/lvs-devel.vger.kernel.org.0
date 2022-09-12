Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D75B5812
	for <lists+lvs-devel@lfdr.de>; Mon, 12 Sep 2022 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiILKTQ (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 12 Sep 2022 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiILKTP (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 12 Sep 2022 06:19:15 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9F3D2316A
        for <lvs-devel@vger.kernel.org>; Mon, 12 Sep 2022 03:19:13 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 36F75117DE;
        Mon, 12 Sep 2022 13:19:13 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 05D67119CE;
        Mon, 12 Sep 2022 13:19:12 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 1FE0F3C07D1;
        Mon, 12 Sep 2022 13:19:01 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 28CAJ0Lf012603;
        Mon, 12 Sep 2022 13:19:00 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 28CAJ02X012601;
        Mon, 12 Sep 2022 13:19:00 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv3 5/5] ipvs: debug the tick time
Date:   Mon, 12 Sep 2022 13:18:38 +0300
Message-Id: <20220912101838.12522-6-ja@ssi.bg>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220912101838.12522-1-ja@ssi.bg>
References: <20220912101838.12522-1-ja@ssi.bg>
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

Just for testing print the tick time every 2 seconds

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_est.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index 5f5ee29fdcb5..a765ec2b0594 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -141,7 +141,13 @@ static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
 {
 	struct ip_vs_est_tick_data *td;
 	int cid;
+	u64 ns = 0;
+	static int used_row = -1;
 
+	if (used_row < 0)
+		used_row = row;
+	if (row == used_row && !kd->id)
+		ns = ktime_get_ns();
 	rcu_read_lock();
 	td = rcu_dereference(kd->ticks[row]);
 	if (!td)
@@ -158,6 +164,16 @@ static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
 
 out:
 	rcu_read_unlock();
+	if (row == used_row && !kd->id) {
+		static int ncpu;
+
+		ns = ktime_sub(ktime_get_ns(), ns);
+		if (!ncpu)
+			ncpu = num_possible_cpus();
+		pr_info("tick time: %lluns for %d CPUs, %d ests, %d chains, max depth %d\n",
+			(unsigned long long) ns, ncpu, kd->tick_len[row],
+			IPVS_EST_TICK_CHAINS, kd->chain_max_len);
+	}
 }
 
 static int ip_vs_estimation_kthread(void *data)
-- 
2.37.3


