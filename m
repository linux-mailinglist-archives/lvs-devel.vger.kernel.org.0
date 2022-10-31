Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C5613978
	for <lists+lvs-devel@lfdr.de>; Mon, 31 Oct 2022 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJaO52 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 31 Oct 2022 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJaO5U (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 31 Oct 2022 10:57:20 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3BF111179
        for <lvs-devel@vger.kernel.org>; Mon, 31 Oct 2022 07:57:17 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 17D74219CE;
        Mon, 31 Oct 2022 16:57:17 +0200 (EET)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 1FB9C219CC;
        Mon, 31 Oct 2022 16:57:14 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 9D8A93C0442;
        Mon, 31 Oct 2022 16:57:08 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29VEv8qv157034;
        Mon, 31 Oct 2022 16:57:08 +0200
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 29VEv81u157033;
        Mon, 31 Oct 2022 16:57:08 +0200
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [RFC PATCHv6 5/7] ipvs: add est_cpulist and est_nice sysctl vars
Date:   Mon, 31 Oct 2022 16:56:45 +0200
Message-Id: <20221031145647.156930-6-ja@ssi.bg>
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

Allow the kthreads for stats to be configured for
specific cpulist (isolation) and niceness (scheduling
priority).

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 Documentation/networking/ipvs-sysctl.rst |  20 ++++
 include/net/ip_vs.h                      |  55 +++++++++
 net/netfilter/ipvs/ip_vs_ctl.c           | 143 ++++++++++++++++++++++-
 net/netfilter/ipvs/ip_vs_est.c           |  11 +-
 4 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
index 387fda80f05f..1b778705d706 100644
--- a/Documentation/networking/ipvs-sysctl.rst
+++ b/Documentation/networking/ipvs-sysctl.rst
@@ -129,6 +129,26 @@ drop_packet - INTEGER
 	threshold. When the mode 3 is set, the always mode drop rate
 	is controlled by the /proc/sys/net/ipv4/vs/am_droprate.
 
+est_cpulist - CPULIST
+	Allowed	CPUs for estimation kthreads
+
+	Syntax: standard cpulist format
+	empty list - stop kthread tasks and estimation
+	default - the system's housekeeping CPUs for kthreads
+
+	Example:
+	"all": all possible CPUs
+	"0-N": all possible CPUs, N denotes last CPU number
+	"0,1-N:1/2": first and all CPUs with odd number
+	"": empty list
+
+est_nice - INTEGER
+	default 0
+	Valid range: -20 (more favorable) .. 19 (less favorable)
+
+	Niceness value to use for the estimation kthreads (scheduling
+	priority)
+
 expire_nodest_conn - BOOLEAN
 	- 0 - disabled (default)
 	- not 0 - enabled
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 9c02840bc7c9..0a745b626cc8 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -29,6 +29,7 @@
 #include <net/netfilter/nf_conntrack.h>
 #endif
 #include <net/net_namespace.h>		/* Netw namespace */
+#include <linux/sched/isolation.h>
 
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
@@ -365,6 +366,9 @@ struct ip_vs_cpu_stats {
 	struct u64_stats_sync   syncp;
 };
 
+/* Default nice for estimator kthreads */
+#define IPVS_EST_NICE		0
+
 /* IPVS statistics objects */
 struct ip_vs_estimator {
 	struct hlist_node	list;
@@ -995,6 +999,12 @@ struct netns_ipvs {
 	int			sysctl_schedule_icmp;
 	int			sysctl_ignore_tunneled;
 	int			sysctl_run_estimation;
+#ifdef CONFIG_SYSCTL
+	cpumask_var_t		sysctl_est_cpulist;	/* kthread cpumask */
+	int			est_cpulist_valid;	/* cpulist set */
+	int			sysctl_est_nice;	/* kthread nice */
+	int			est_stopped;		/* stop tasks */
+#endif
 
 	/* ip_vs_lblc */
 	int			sysctl_lblc_expiration;
@@ -1148,6 +1158,19 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return ipvs->sysctl_run_estimation;
 }
 
+static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
+{
+	if (ipvs->est_cpulist_valid)
+		return ipvs->sysctl_est_cpulist;
+	else
+		return housekeeping_cpumask(HK_TYPE_KTHREAD);
+}
+
+static inline int sysctl_est_nice(struct netns_ipvs *ipvs)
+{
+	return ipvs->sysctl_est_nice;
+}
+
 #else
 
 static inline int sysctl_sync_threshold(struct netns_ipvs *ipvs)
@@ -1245,6 +1268,16 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return 1;
 }
 
+static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
+{
+	return housekeeping_cpumask(HK_TYPE_KTHREAD);
+}
+
+static inline int sysctl_est_nice(struct netns_ipvs *ipvs)
+{
+	return IPVS_EST_NICE;
+}
+
 #endif
 
 /* IPVS core functions
@@ -1555,6 +1588,28 @@ int ip_vs_est_kthread_start(struct netns_ipvs *ipvs,
 			    struct ip_vs_est_kt_data *kd);
 void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd);
 
+static inline void ip_vs_est_stopped_recalc(struct netns_ipvs *ipvs)
+{
+#ifdef CONFIG_SYSCTL
+	ipvs->est_stopped = ipvs->est_cpulist_valid &&
+			    cpumask_empty(sysctl_est_cpulist(ipvs));
+#endif
+}
+
+static inline bool ip_vs_est_stopped(struct netns_ipvs *ipvs)
+{
+#ifdef CONFIG_SYSCTL
+	return ipvs->est_stopped;
+#else
+	return false;
+#endif
+}
+
+static inline int ip_vs_est_max_threads(struct netns_ipvs *ipvs)
+{
+	return max(1U, 4 * cpumask_weight(sysctl_est_cpulist(ipvs)));
+}
+
 /* Various IPVS packet transmitters (from ip_vs_xmit.c) */
 int ip_vs_null_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		    struct ip_vs_protocol *pp, struct ip_vs_iphdr *iph);
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index c41a5392edc9..38df3ee655ed 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -263,7 +263,7 @@ static void est_reload_work_handler(struct work_struct *work)
 		/* New config ? Stop kthread tasks */
 		if (genid != genid_done)
 			ip_vs_est_kthread_stop(kd);
-		if (!kd->task) {
+		if (!kd->task && !ip_vs_est_stopped(ipvs)) {
 			/* Do not start kthreads above 0 in calc phase */
 			if ((!id || !ipvs->est_calc_phase) &&
 			    ip_vs_est_kthread_start(ipvs, kd) < 0)
@@ -1940,6 +1940,122 @@ proc_do_sync_ports(struct ctl_table *table, int write,
 	return rc;
 }
 
+static int ipvs_proc_est_cpumask_set(struct ctl_table *table, void *buffer)
+{
+	struct netns_ipvs *ipvs = table->extra2;
+	cpumask_var_t *valp = table->data;
+	cpumask_var_t newmask;
+	int ret;
+
+	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = cpulist_parse(buffer, newmask);
+	if (ret)
+		goto out;
+
+	mutex_lock(&ipvs->est_mutex);
+
+	if (!ipvs->est_cpulist_valid) {
+		if (!zalloc_cpumask_var(valp, GFP_KERNEL)) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		ipvs->est_cpulist_valid = 1;
+	}
+	cpumask_and(newmask, newmask, &current->cpus_mask);
+	cpumask_copy(*valp, newmask);
+	/* est_max_threads may depend on cpulist size */
+	ipvs->est_max_threads = ip_vs_est_max_threads(ipvs);
+	ipvs->est_calc_phase = 1;
+	ip_vs_est_reload_start(ipvs);
+
+unlock:
+	mutex_unlock(&ipvs->est_mutex);
+
+out:
+	free_cpumask_var(newmask);
+	return ret;
+}
+
+static int ipvs_proc_est_cpumask_get(struct ctl_table *table, void *buffer,
+				     size_t size)
+{
+	struct netns_ipvs *ipvs = table->extra2;
+	cpumask_var_t *valp = table->data;
+	struct cpumask *mask;
+	int ret;
+
+	mutex_lock(&ipvs->est_mutex);
+
+	if (ipvs->est_cpulist_valid)
+		mask = *valp;
+	else
+		mask = (struct cpumask *)housekeeping_cpumask(HK_TYPE_KTHREAD);
+	ret = scnprintf(buffer, size, "%*pbl\n", cpumask_pr_args(mask));
+
+	mutex_unlock(&ipvs->est_mutex);
+
+	return ret;
+}
+
+static int ipvs_proc_est_cpulist(struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	/* Ignore both read and write(append) if *ppos not 0 */
+	if (*ppos || !*lenp) {
+		*lenp = 0;
+		return 0;
+	}
+	if (write) {
+		/* proc_sys_call_handler() appends terminator */
+		ret = ipvs_proc_est_cpumask_set(table, buffer);
+		if (ret >= 0)
+			*ppos += *lenp;
+	} else {
+		/* proc_sys_call_handler() allocates 1 byte for terminator */
+		ret = ipvs_proc_est_cpumask_get(table, buffer, *lenp + 1);
+		if (ret >= 0) {
+			*lenp = ret;
+			*ppos += *lenp;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+static int ipvs_proc_est_nice(struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
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
+		if (val < MIN_NICE || val > MAX_NICE) {
+			ret = -EINVAL;
+		} else {
+			mutex_lock(&ipvs->est_mutex);
+			if (*valp != val) {
+				*valp = val;
+				ip_vs_est_reload_start(ipvs);
+			}
+			mutex_unlock(&ipvs->est_mutex);
+		}
+	}
+	return ret;
+}
+
 /*
  *	IPVS sysctl table (under the /proc/sys/net/ipv4/vs/)
  *	Do not change order or insert new entries without
@@ -2116,6 +2232,18 @@ static struct ctl_table vs_vars[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "est_cpulist",
+		.maxlen		= NR_CPUS,	/* unused */
+		.mode		= 0644,
+		.proc_handler	= ipvs_proc_est_cpulist,
+	},
+	{
+		.procname	= "est_nice",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= ipvs_proc_est_nice,
+	},
 #ifdef CONFIG_IP_VS_DEBUG
 	{
 		.procname	= "debug_level",
@@ -4134,6 +4262,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
 	INIT_DELAYED_WORK(&ipvs->expire_nodest_conn_work,
 			  expire_nodest_conn_handler);
+	ipvs->est_stopped = 0;
 
 	if (!net_eq(net, &init_net)) {
 		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
@@ -4195,6 +4324,15 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
 	ipvs->sysctl_run_estimation = 1;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
+
+	ipvs->est_cpulist_valid = 0;
+	tbl[idx].extra2 = ipvs;
+	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
+
+	ipvs->sysctl_est_nice = IPVS_EST_NICE;
+	tbl[idx].extra2 = ipvs;
+	tbl[idx++].data = &ipvs->sysctl_est_nice;
+
 #ifdef CONFIG_IP_VS_DEBUG
 	/* Global sysctls must be ro in non-init netns */
 	if (!net_eq(net, &init_net))
@@ -4234,6 +4372,9 @@ static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
 	unregister_net_sysctl_table(ipvs->sysctl_hdr);
 	ip_vs_stop_estimator(ipvs, &ipvs->tot_stats->s);
 
+	if (ipvs->est_cpulist_valid)
+		free_cpumask_var(ipvs->sysctl_est_cpulist);
+
 	if (!net_eq(net, &init_net))
 		kfree(ipvs->sysctl_tbl);
 }
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index c134f9466dc6..91eb0f1f8a00 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -57,6 +57,9 @@
   - kthread contexts are created and attached to array
   - the kthread tasks are started when first service is added, before that
     the total stats are not estimated
+  - when configuration (cpulist/nice) is changed, the tasks are restarted
+    by work (est_reload_work)
+  - kthread tasks are stopped while the cpulist is empty
   - the kthread context holds lists with estimators (chains) which are
     processed every 2 seconds
   - as estimators can be added dynamically and in bursts, we try to spread
@@ -229,6 +232,7 @@ void ip_vs_est_reload_start(struct netns_ipvs *ipvs)
 	/* Ignore reloads before first service is added */
 	if (!ipvs->enable)
 		return;
+	ip_vs_est_stopped_recalc(ipvs);
 	/* Bump the kthread configuration genid */
 	atomic_inc(&ipvs->est_genid);
 	queue_delayed_work(system_long_wq, &ipvs->est_reload_work, 0);
@@ -259,6 +263,9 @@ int ip_vs_est_kthread_start(struct netns_ipvs *ipvs,
 		goto out;
 	}
 
+	set_user_nice(kd->task, sysctl_est_nice(ipvs));
+	set_cpus_allowed_ptr(kd->task, sysctl_est_cpulist(ipvs));
+
 	pr_info("starting estimator thread %d...\n", kd->id);
 	wake_up_process(kd->task);
 
@@ -334,7 +341,7 @@ static int ip_vs_est_add_kthread(struct netns_ipvs *ipvs)
 	}
 
 	/* Start kthread tasks only when services are present */
-	if (ipvs->enable) {
+	if (ipvs->enable && !ip_vs_est_stopped(ipvs)) {
 		ret = ip_vs_est_kthread_start(ipvs, kd);
 		if (ret < 0)
 			goto out;
@@ -475,7 +482,7 @@ int ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
 	int ret;
 
 	if (!ipvs->est_max_threads && ipvs->enable)
-		ipvs->est_max_threads = 4 * num_possible_cpus();
+		ipvs->est_max_threads = ip_vs_est_max_threads(ipvs);
 
 	est->ktid = -1;
 	est->ktrow = IPVS_EST_NTICKS - 1;	/* Initial delay */
-- 
2.38.1


