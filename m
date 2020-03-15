Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB306185C9D
	for <lists+lvs-devel@lfdr.de>; Sun, 15 Mar 2020 14:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgCON0n (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 15 Mar 2020 09:26:43 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3133 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgCON0n (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 15 Mar 2020 09:26:43 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45e6e2ce49da-ca768; Sun, 15 Mar 2020 21:25:56 +0800 (CST)
X-RM-TRANSID: 2ee45e6e2ce49da-ca768
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e6e2ce2b3f-13bc7;
        Sun, 15 Mar 2020 21:25:55 +0800 (CST)
X-RM-TRANSID: 2ee15e6e2ce2b3f-13bc7
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v2] ipvs: optimize tunnel dumps for icmp errors
Date:   Sun, 15 Mar 2020 21:25:41 +0800
Message-Id: <1584278741-13944-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

After strip GRE/UDP tunnel header for icmp errors, it's better to show
"GRE/UDP" instead of "IPIP" in debug message.

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
v2: Fix wrong proto message
---
 net/netfilter/ipvs/ip_vs_core.c | 46 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 512259f..d2ac530 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1661,8 +1661,9 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	struct ip_vs_protocol *pp;
 	struct ip_vs_proto_data *pd;
 	unsigned int offset, offset2, ihl, verdict;
-	bool ipip, new_cp = false;
+	bool tunnel, new_cp = false;
 	union nf_inet_addr *raddr;
+	char *outer_proto;
 
 	*related = 1;
 
@@ -1703,8 +1704,8 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		return NF_ACCEPT; /* The packet looks wrong, ignore */
 	raddr = (union nf_inet_addr *)&cih->daddr;
 
-	/* Special case for errors for IPIP packets */
-	ipip = false;
+	/* Special case for errors for IPIP/UDP/GRE tunnel packets */
+	tunnel = false;
 	if (cih->protocol == IPPROTO_IPIP) {
 		struct ip_vs_dest *dest;
 
@@ -1721,7 +1722,8 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		cih = skb_header_pointer(skb, offset, sizeof(_ciph), &_ciph);
 		if (cih == NULL)
 			return NF_ACCEPT; /* The packet looks wrong, ignore */
-		ipip = true;
+		tunnel = true;
+		outer_proto = "IPIP";
 	} else if ((cih->protocol == IPPROTO_UDP ||	/* Can be UDP encap */
 		    cih->protocol == IPPROTO_GRE) &&	/* Can be GRE encap */
 		   /* Error for our tunnel must arrive at LOCAL_IN */
@@ -1729,16 +1731,19 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		__u8 iproto;
 		int ulen;
 
-		/* Non-first fragment has no UDP header */
+		/* Non-first fragment has no UDP/GRE header */
 		if (unlikely(cih->frag_off & htons(IP_OFFSET)))
 			return NF_ACCEPT;
 		offset2 = offset + cih->ihl * 4;
-		if (cih->protocol == IPPROTO_UDP)
+		if (cih->protocol == IPPROTO_UDP) {
 			ulen = ipvs_udp_decap(ipvs, skb, offset2, AF_INET,
 					      raddr, &iproto);
-		else
+			outer_proto = "UDP";
+		} else {
 			ulen = ipvs_gre_decap(ipvs, skb, offset2, AF_INET,
 					      raddr, &iproto);
+			outer_proto = "GRE";
+		}
 		if (ulen > 0) {
 			/* Skip IP and UDP/GRE tunnel headers */
 			offset = offset2 + ulen;
@@ -1747,7 +1752,7 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 						 &_ciph);
 			if (cih && cih->version == 4 && cih->ihl >= 5 &&
 			    iproto == IPPROTO_IPIP)
-				ipip = true;
+				tunnel = true;
 			else
 				return NF_ACCEPT;
 		}
@@ -1767,11 +1772,11 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		      "Checking incoming ICMP for");
 
 	offset2 = offset;
-	ip_vs_fill_iph_skb_icmp(AF_INET, skb, offset, !ipip, &ciph);
+	ip_vs_fill_iph_skb_icmp(AF_INET, skb, offset, !tunnel, &ciph);
 	offset = ciph.len;
 
 	/* The embedded headers contain source and dest in reverse order.
-	 * For IPIP this is error for request, not for reply.
+	 * For IPIP/UDP/GRE tunnel this is error for request, not for reply.
 	 */
 	cp = INDIRECT_CALL_1(pp->conn_in_get, ip_vs_conn_in_get_proto,
 			     ipvs, AF_INET, skb, &ciph);
@@ -1779,7 +1784,7 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	if (!cp) {
 		int v;
 
-		if (ipip || !sysctl_schedule_icmp(ipvs))
+		if (tunnel || !sysctl_schedule_icmp(ipvs))
 			return NF_ACCEPT;
 
 		if (!ip_vs_try_to_schedule(ipvs, AF_INET, skb, pd, &v, &cp, &ciph))
@@ -1797,7 +1802,7 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		goto out;
 	}
 
-	if (ipip) {
+	if (tunnel) {
 		__be32 info = ic->un.gateway;
 		__u8 type = ic->type;
 		__u8 code = ic->code;
@@ -1809,17 +1814,18 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 			u32 mtu = ntohs(ic->un.frag.mtu);
 			__be16 frag_off = cih->frag_off;
 
-			/* Strip outer IP and ICMP, go to IPIP header */
+			/* Strip outer IP and ICMP, go to IPIP/UDP/GRE header */
 			if (pskb_pull(skb, ihl + sizeof(_icmph)) == NULL)
-				goto ignore_ipip;
+				goto ignore_tunnel;
 			offset2 -= ihl + sizeof(_icmph);
 			skb_reset_network_header(skb);
-			IP_VS_DBG(12, "ICMP for IPIP %pI4->%pI4: mtu=%u\n",
-				&ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr, mtu);
+			IP_VS_DBG(12, "ICMP for %s %pI4->%pI4: mtu=%u\n",
+				  outer_proto, &ip_hdr(skb)->saddr,
+				  &ip_hdr(skb)->daddr, mtu);
 			ipv4_update_pmtu(skb, ipvs->net, mtu, 0, 0);
 			/* Client uses PMTUD? */
 			if (!(frag_off & htons(IP_DF)))
-				goto ignore_ipip;
+				goto ignore_tunnel;
 			/* Prefer the resulting PMTU */
 			if (dest) {
 				struct ip_vs_dest_dst *dest_dst;
@@ -1832,11 +1838,11 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 				mtu -= sizeof(struct iphdr);
 			info = htonl(mtu);
 		}
-		/* Strip outer IP, ICMP and IPIP, go to IP header of
+		/* Strip outer IP, ICMP and IPIP/UDP/GRE, go to IP header of
 		 * original request.
 		 */
 		if (pskb_pull(skb, offset2) == NULL)
-			goto ignore_ipip;
+			goto ignore_tunnel;
 		skb_reset_network_header(skb);
 		IP_VS_DBG(12, "Sending ICMP for %pI4->%pI4: t=%u, c=%u, i=%u\n",
 			&ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr,
@@ -1845,7 +1851,7 @@ static int ipvs_gre_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
 		/* ICMP can be shorter but anyways, account it */
 		ip_vs_out_stats(cp, skb);
 
-ignore_ipip:
+ignore_tunnel:
 		consume_skb(skb);
 		verdict = NF_STOLEN;
 		goto out;
-- 
1.8.3.1



