Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29851283095
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Oct 2020 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJEHFh (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Oct 2020 03:05:37 -0400
Received: from m12-11.163.com ([220.181.12.11]:53412 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHFh (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:05:37 -0400
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 03:05:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H0tWR
        pBAA5d93HrwxDKL06PP9iV+NJqmz9VsKJN9YgI=; b=CvvX49Tk1/s18quyVYKss
        CSXu80lzUtRzETfZPYHF2sEOPO1+cYaRRAHxagAOuPiOSvAQMtbtjfR6qyioeTj+
        +em2XAJOZjDUEMdEpnuvvo6r9NIdhhud7gW0zO3QOsLTcF4/ExAumsJ8l4KYQwMr
        SHoOkHxuZB3oXx4ATFGj1I=
Received: from localhost.localdomain (unknown [114.247.184.147])
        by smtp7 (Coremail) with SMTP id C8CowADHg5kOwnpfrdHpBA--.11273S2;
        Mon, 05 Oct 2020 14:49:50 +0800 (CST)
From:   "longguang.yue" <bigclouds@163.com>
Cc:     ja@ssi.bg, lvs-devel@vger.kernel.org, yuelongguang@gmail.com,
        "longguang.yue" <bigclouds@163.com>
Subject: [PATCH v7] ipvs: inspect reply packets from DR/TUN real servers
Date:   Mon,  5 Oct 2020 14:49:43 +0800
Message-Id: <20201005064943.88541-1-bigclouds@163.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <alpine.LFD.2.23.451.2010041409460.5398@ja.home.ssi.bg>
References: <alpine.LFD.2.23.451.2010041409460.5398@ja.home.ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADHg5kOwnpfrdHpBA--.11273S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4UJF4rtFyDKF1xJFW5ZFb_yoWrAF4rp3
        WUKay3ZrWkGFy5J3WxArnrur13Aw1kJ3W7ur45Ka4fC3Z8JF15ZFsY9FyFyFW5CrZYva4a
        qw4Fqw45Cwn8JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jN8n5UUUUU=
X-Originating-IP: [114.247.184.147]
X-CM-SenderInfo: peljuzprxg2qqrwthudrp/1tbiNgG0Q1WBkltjNAABsL
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Just like for MASQ, inspect the reply packets coming from DR/TUN
real servers and alter the connection's state and timeout
according to the protocol.

It's ipvs's duty to do traffic statistic if packets get hit,
no matter what mode it is.

Signed-off-by: longguang.yue <bigclouds@163.com>

---
v1: support DR/TUN mode statistic
v2: ip_vs_conn_out_get handles DR/TUN mode's conn
v3: fix checkpatch
v4, v5: restructure and optimise this feature
v6: rewrite subject and patch description
v7: adjust changelogs and order of some local vars

Signed-off-by: longguang.yue <bigclouds@163.com>
---
 net/netfilter/ipvs/ip_vs_conn.c | 18 +++++++++++++++---
 net/netfilter/ipvs/ip_vs_core.c | 17 ++++++-----------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index a90b8eac16ac..c100c6b112c8 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -402,6 +402,8 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 {
 	unsigned int hash;
 	struct ip_vs_conn *cp, *ret=NULL;
+	const union nf_inet_addr *saddr;
+	__be16 sport;
 
 	/*
 	 *	Check for "full" addressed entries
@@ -411,10 +413,20 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
-		if (p->vport == cp->cport && p->cport == cp->dport &&
-		    cp->af == p->af &&
+		if (p->vport != cp->cport)
+			continue;
+
+		if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ) {
+			sport = cp->vport;
+			saddr = &cp->vaddr;
+		} else {
+			sport = cp->dport;
+			saddr = &cp->daddr;
+		}
+
+		if (p->cport == sport && cp->af == p->af &&
 		    ip_vs_addr_equal(p->af, p->vaddr, &cp->caddr) &&
-		    ip_vs_addr_equal(p->af, p->caddr, &cp->daddr) &&
+		    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
 		    p->protocol == cp->protocol &&
 		    cp->ipvs == p->ipvs) {
 			if (!__ip_vs_conn_get(cp))
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index e3668a6e54e4..494ea1fcf4d8 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -875,7 +875,7 @@ static int handle_response_icmp(int af, struct sk_buff *skb,
 	unsigned int verdict = NF_DROP;
 
 	if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ)
-		goto ignore_cp;
+		goto after_nat;
 
 	/* Ensure the checksum is correct */
 	if (!skb_csum_unnecessary(skb) && ip_vs_checksum_complete(skb, ihl)) {
@@ -900,7 +900,7 @@ static int handle_response_icmp(int af, struct sk_buff *skb,
 
 	if (ip_vs_route_me_harder(cp->ipvs, af, skb, hooknum))
 		goto out;
-
+after_nat:
 	/* do the statistics and put it back */
 	ip_vs_out_stats(cp, skb);
 
@@ -909,8 +909,6 @@ static int handle_response_icmp(int af, struct sk_buff *skb,
 		ip_vs_notrack(skb);
 	else
 		ip_vs_update_conntrack(skb, cp, 0);
-
-ignore_cp:
 	verdict = NF_ACCEPT;
 
 out:
@@ -1276,6 +1274,9 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
 {
 	struct ip_vs_protocol *pp = pd->pp;
 
+	if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ)
+		goto after_nat;
+
 	IP_VS_DBG_PKT(11, af, pp, skb, iph->off, "Outgoing packet");
 
 	if (skb_ensure_writable(skb, iph->len))
@@ -1316,6 +1317,7 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
 
 	IP_VS_DBG_PKT(10, af, pp, skb, iph->off, "After SNAT");
 
+after_nat:
 	ip_vs_out_stats(cp, skb);
 	ip_vs_set_state(cp, IP_VS_DIR_OUTPUT, skb, pd);
 	skb->ipvs_property = 1;
@@ -1413,8 +1415,6 @@ ip_vs_out(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, in
 			     ipvs, af, skb, &iph);
 
 	if (likely(cp)) {
-		if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ)
-			goto ignore_cp;
 		return handle_response(af, skb, pd, cp, &iph, hooknum);
 	}
 
@@ -1475,14 +1475,9 @@ ip_vs_out(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, in
 		}
 	}
 
-out:
 	IP_VS_DBG_PKT(12, af, pp, skb, iph.off,
 		      "ip_vs_out: packet continues traversal as normal");
 	return NF_ACCEPT;
-
-ignore_cp:
-	__ip_vs_conn_put(cp);
-	goto out;
 }
 
 /*
-- 
2.20.1 (Apple Git-117)


