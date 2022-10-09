Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC45F8C0F
	for <lists+lvs-devel@lfdr.de>; Sun,  9 Oct 2022 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJIPhw (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 9 Oct 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJIPhv (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 9 Oct 2022 11:37:51 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C82023BD4
        for <lvs-devel@vger.kernel.org>; Sun,  9 Oct 2022 08:37:50 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 5C72923F71;
        Sun,  9 Oct 2022 18:37:49 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id B2B7024010;
        Sun,  9 Oct 2022 18:37:47 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id B35E63C043E;
        Sun,  9 Oct 2022 18:37:37 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 299Fbbak126039;
        Sun, 9 Oct 2022 18:37:37 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 299Fbbu8126037;
        Sun, 9 Oct 2022 18:37:37 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv5 5/6] ipvs: run_estimation should control the kthread tasks
Date:   Sun,  9 Oct 2022 18:37:09 +0300
Message-Id: <20221009153710.125919-6-ja@ssi.bg>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009153710.125919-1-ja@ssi.bg>
References: <20221009153710.125919-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Change the run_estimation flag to start/stop the kthread tasks.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 Documentation/networking/ipvs-sysctl.rst |  4 ++--
 include/net/ip_vs.h                      |  6 +++--
 net/netfilter/ipvs/ip_vs_ctl.c           | 29 +++++++++++++++++++++++-
 net/netfilter/ipvs/ip_vs_est.c           |  2 +-
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
index 1b778705d706..3fb5fa142eef 100644
--- a/Documentation/networking/ipvs-sysctl.rst
+++ b/Documentation/networking/ipvs-sysctl.rst
@@ -324,8 +324,8 @@ run_estimation - BOOLEAN
 	0 - disabled
 	not 0 - enabled (default)
 
-	If disabled, the estimation will be stop, and you can't see
-	any update on speed estimation data.
+	If disabled, the estimation will be suspended and kthread tasks
+	stopped.
 
 	You can always re-enable estimation by setting this value to 1.
 	But be careful, the first estimation after re-enable is not
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 9da45664dba8..76d4abf5a881 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1591,8 +1591,10 @@ void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd);
 static inline void ip_vs_est_stopped_recalc(struct netns_ipvs *ipvs)
 {
 #ifdef CONFIG_SYSCTL
-	ipvs->est_stopped = ipvs->est_cpulist_valid &&
-			    cpumask_empty(sysctl_est_cpulist(ipvs));
+	/* Stop tasks while cpulist is empty or if disabled with flag */
+	ipvs->est_stopped = !sysctl_run_estimation(ipvs) ||
+			    (ipvs->est_cpulist_valid &&
+			     cpumask_empty(sysctl_est_cpulist(ipvs)));
 #endif
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 56edd94d0877..aa0ac51a162c 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2056,6 +2056,32 @@ static int ipvs_proc_est_nice(struct ctl_table *table, int write,
 	return ret;
 }
 
+static int ipvs_proc_run_estimation(struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct netns_ipvs *ipvs = table->extra2;
+	int *valp = table->data;
+	int val = *valp;
+	int ret;
+
+	struct ctl_table tmp_table = {
+		.data = &val,
+		.maxlen = sizeof(int),
+		.mode = table->mode,
+	};
+
+	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
+	if (write && ret >= 0) {
+		mutex_lock(&ipvs->est_mutex);
+		if (*valp != val) {
+			*valp = val;
+			ip_vs_est_reload_start(ipvs);
+		}
+		mutex_unlock(&ipvs->est_mutex);
+	}
+	return ret;
+}
+
 /*
  *	IPVS sysctl table (under the /proc/sys/net/ipv4/vs/)
  *	Do not change order or insert new entries without
@@ -2230,7 +2256,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "run_estimation",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= ipvs_proc_run_estimation,
 	},
 	{
 		.procname	= "est_cpulist",
@@ -4322,6 +4348,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
 	ipvs->sysctl_run_estimation = 1;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
 
 	ipvs->est_cpulist_valid = 0;
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index d4d860f19cb8..d6e35f2a4c77 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -212,7 +212,7 @@ static int ip_vs_estimation_kthread(void *data)
 				kd->est_timer = now;
 		}
 
-		if (sysctl_run_estimation(ipvs) && kd->tick_len[row])
+		if (kd->tick_len[row])
 			ip_vs_tick_estimation(kd, row);
 
 		row++;
-- 
2.37.3


