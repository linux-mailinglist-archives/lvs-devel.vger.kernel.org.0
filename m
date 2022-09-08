Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A525B2932
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Sep 2022 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIHWWE (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 8 Sep 2022 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIHWV6 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 8 Sep 2022 18:21:58 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96481F2D6B
        for <lvs-devel@vger.kernel.org>; Thu,  8 Sep 2022 15:21:57 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id DB2A22BE16;
        Fri,  9 Sep 2022 01:21:56 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 3D9962BD65;
        Fri,  9 Sep 2022 01:21:55 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id D66423C0799;
        Fri,  9 Sep 2022 01:21:52 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 288MLqGZ147619;
        Fri, 9 Sep 2022 01:21:52 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 288MLqaA147617;
        Fri, 9 Sep 2022 01:21:52 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv2 4/4] ipvs: run_estimation should control the kthread tasks
Date:   Fri,  9 Sep 2022 01:21:09 +0300
Message-Id: <20220908222109.147452-5-ja@ssi.bg>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908222109.147452-1-ja@ssi.bg>
References: <20220908222109.147452-1-ja@ssi.bg>
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

Change the run_estimation flag to start/stop the kthread tasks.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 Documentation/networking/ipvs-sysctl.rst |  4 ++--
 include/net/ip_vs.h                      |  6 +++--
 net/netfilter/ipvs/ip_vs_ctl.c           | 29 +++++++++++++++++++++++-
 net/netfilter/ipvs/ip_vs_est.c           |  3 +--
 4 files changed, 35 insertions(+), 7 deletions(-)

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
index 4486324afc84..8bc1160ce574 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1574,8 +1574,10 @@ void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd);
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
index 5c3bd701cb19..ea4df891145f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2036,6 +2036,32 @@ static int ipvs_proc_est_nice(struct ctl_table *table, int write,
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
@@ -2210,7 +2236,7 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "run_estimation",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= ipvs_proc_run_estimation,
 	},
 	{
 		.procname	= "est_cpulist",
@@ -4302,6 +4328,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
 	ipvs->sysctl_run_estimation = 1;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
 
 	ipvs->est_cpulist_valid = 0;
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index 6024ea8075e4..a6a40fc4b14a 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -163,7 +163,6 @@ static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
 static int ip_vs_estimation_kthread(void *data)
 {
 	struct ip_vs_est_kt_data *kd = data;
-	struct netns_ipvs *ipvs = kd->ipvs;
 	int row = kd->est_row;
 	unsigned long now;
 	long gap;
@@ -188,7 +187,7 @@ static int ip_vs_estimation_kthread(void *data)
 				kd->est_timer = now;
 		}
 
-		if (sysctl_run_estimation(ipvs) && kd->tick_len[row])
+		if (kd->tick_len[row])
 			ip_vs_tick_estimation(kd, row);
 
 		row++;
-- 
2.37.3


