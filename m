Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED820231A
	for <lists+lvs-devel@lfdr.de>; Sat, 20 Jun 2020 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFTKEi (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 20 Jun 2020 06:04:38 -0400
Received: from ja.ssi.bg ([178.16.129.10]:54292 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbgFTKEi (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Sat, 20 Jun 2020 06:04:38 -0400
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 05KA4O1x004411;
        Sat, 20 Jun 2020 13:04:24 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.15.2/8.15.2/Submit) id 05KA4MaY004410;
        Sat, 20 Jun 2020 13:04:22 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Andrew Sy Kim <kim.andrewsy@gmail.com>
Subject: [PATCH net-next] ipvs: avoid expiring many connections from timer
Date:   Sat, 20 Jun 2020 13:03:55 +0300
Message-Id: <20200620100355.4364-1-ja@ssi.bg>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Add new functions ip_vs_conn_del() and ip_vs_conn_del_put()
to release many IPVS connections in process context.
They are suitable for connections found in table
when we do not want to overload the timers.

Currently, the change is useful for the dropentry delayed
work but it will be used also in following patch
when flushing connections to failed destinations.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_conn.c | 53 +++++++++++++++++++++++----------
 net/netfilter/ipvs/ip_vs_ctl.c  |  6 ++--
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 02f2f636798d..b3921ae92740 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -807,6 +807,31 @@ static void ip_vs_conn_rcu_free(struct rcu_head *head)
 	kmem_cache_free(ip_vs_conn_cachep, cp);
 }
 
+/* Try to delete connection while not holding reference */
+static void ip_vs_conn_del(struct ip_vs_conn *cp)
+{
+	if (del_timer(&cp->timer)) {
+		/* Drop cp->control chain too */
+		if (cp->control)
+			cp->timeout = 0;
+		ip_vs_conn_expire(&cp->timer);
+	}
+}
+
+/* Try to delete connection while holding reference */
+static void ip_vs_conn_del_put(struct ip_vs_conn *cp)
+{
+	if (del_timer(&cp->timer)) {
+		/* Drop cp->control chain too */
+		if (cp->control)
+			cp->timeout = 0;
+		__ip_vs_conn_put(cp);
+		ip_vs_conn_expire(&cp->timer);
+	} else {
+		__ip_vs_conn_put(cp);
+	}
+}
+
 static void ip_vs_conn_expire(struct timer_list *t)
 {
 	struct ip_vs_conn *cp = from_timer(cp, t, timer);
@@ -827,14 +852,17 @@ static void ip_vs_conn_expire(struct timer_list *t)
 
 		/* does anybody control me? */
 		if (ct) {
+			bool has_ref = !cp->timeout && __ip_vs_conn_get(ct);
+
 			ip_vs_control_del(cp);
 			/* Drop CTL or non-assured TPL if not used anymore */
-			if (!cp->timeout && !atomic_read(&ct->n_control) &&
+			if (has_ref && !atomic_read(&ct->n_control) &&
 			    (!(ct->flags & IP_VS_CONN_F_TEMPLATE) ||
 			     !(ct->state & IP_VS_CTPL_S_ASSURED))) {
 				IP_VS_DBG(4, "drop controlling connection\n");
-				ct->timeout = 0;
-				ip_vs_conn_expire_now(ct);
+				ip_vs_conn_del_put(ct);
+			} else if (has_ref) {
+				__ip_vs_conn_put(ct);
 			}
 		}
 
@@ -1317,8 +1345,7 @@ void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 
 drop:
 			IP_VS_DBG(4, "drop connection\n");
-			cp->timeout = 0;
-			ip_vs_conn_expire_now(cp);
+			ip_vs_conn_del(cp);
 		}
 		cond_resched_rcu();
 	}
@@ -1341,19 +1368,15 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
 		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
 			if (cp->ipvs != ipvs)
 				continue;
-			/* As timers are expired in LIFO order, restart
-			 * the timer of controlling connection first, so
-			 * that it is expired after us.
-			 */
+			if (atomic_read(&cp->n_control))
+				continue;
 			cp_c = cp->control;
-			/* cp->control is valid only with reference to cp */
-			if (cp_c && __ip_vs_conn_get(cp)) {
+			IP_VS_DBG(4, "del connection\n");
+			ip_vs_conn_del(cp);
+			if (cp_c && !atomic_read(&cp_c->n_control)) {
 				IP_VS_DBG(4, "del controlling connection\n");
-				ip_vs_conn_expire_now(cp_c);
-				__ip_vs_conn_put(cp);
+				ip_vs_conn_del(cp_c);
 			}
-			IP_VS_DBG(4, "del connection\n");
-			ip_vs_conn_expire_now(cp);
 		}
 		cond_resched_rcu();
 	}
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 412656c34f20..1a231f518e3f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -224,7 +224,8 @@ static void defense_work_handler(struct work_struct *work)
 	update_defense_level(ipvs);
 	if (atomic_read(&ipvs->dropentry))
 		ip_vs_random_dropentry(ipvs);
-	schedule_delayed_work(&ipvs->defense_work, DEFENSE_TIMER_PERIOD);
+	queue_delayed_work(system_long_wq, &ipvs->defense_work,
+			   DEFENSE_TIMER_PERIOD);
 }
 #endif
 
@@ -4063,7 +4064,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_tbl = tbl;
 	/* Schedule defense work */
 	INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
-	schedule_delayed_work(&ipvs->defense_work, DEFENSE_TIMER_PERIOD);
+	queue_delayed_work(system_long_wq, &ipvs->defense_work,
+			   DEFENSE_TIMER_PERIOD);
 
 	return 0;
 }
-- 
2.26.2

