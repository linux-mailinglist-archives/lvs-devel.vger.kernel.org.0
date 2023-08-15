Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E777D7FE
	for <lists+lvs-devel@lfdr.de>; Wed, 16 Aug 2023 03:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbjHPB6Q (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbjHPB54 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 15 Aug 2023 21:57:56 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F6D2109;
        Tue, 15 Aug 2023 18:57:40 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id F3519122C4;
        Wed, 16 Aug 2023 04:57:38 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id DB189122C0;
        Wed, 16 Aug 2023 04:57:38 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 38EE93C07D6;
        Wed, 16 Aug 2023 04:57:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1692151029; bh=xXLEv/HsXnbgZTYog1dH+potknOROFFm6oB3xsRaj+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rV+XkFtIvc4llHUQrpP0cskVxbaEiUyZORcqKgd722q4h2Vu6zWKGjWMeQzFr72Ys
         Wuq+2MFeLBYqfcCBCM6uNqHh40PitGZCHDpzoyxXC/738WXahhSmYW0m7eEAXOhsqq
         hN3AjpEPkg6lLzfEp+rgJzTGBTwRM3qLMrRj+1R8=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37FHWInH168661;
        Tue, 15 Aug 2023 20:32:18 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 37FHWHUA168660;
        Tue, 15 Aug 2023 20:32:17 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH RFC net-next 12/14] ipvs: use more keys for connection hashing
Date:   Tue, 15 Aug 2023 20:30:29 +0300
Message-ID: <20230815173031.168344-13-ja@ssi.bg>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815173031.168344-1-ja@ssi.bg>
References: <20230815173031.168344-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Simon Kirby reported long time ago that IPVS connection hashing
based only on the client address/port (caddr, cport) as hash keys
is not suitable for setups that accept traffic on multiple virtual
IPs and ports. It can happen for multiple VIP:VPORT services, for
single or many fwmark service(s) that match multiple virtual IPs
and ports or even for passive FTP with peristence in DR/TUN mode
where we expect traffic on multiple ports for the virtual IP.

Fix it by adding virtual addresses and ports to the hash function.
This causes the traffic from NAT real servers to clients to use
second hashing for the in->out direction.

As result:

- the IN direction from client will use hash node hn0 where
the source/dest addresses and ports used by client will be used
as hash keys

- the OUT direction from NAT real servers will use hash node hn1
for the traffic from real server to client

- the persistence templates are hashed only with parameters based on
the IN direction, so they now will also use the virtual address,
port and fwmark from the service.

OLD:
- all methods: c_list node: proto, caddr:cport
- persistence templates: c_list node: proto, caddr_net:0
- persistence engine templates: c_list node: per-PE, PE-SIP uses jhash

NEW:
- all methods: hn0 node (dir 0): proto, caddr:cport -> vaddr:vport
- MASQ method: hn1 node (dir 1): proto, daddr:dport -> caddr:cport
- persistence templates: hn0 node (dir 0):
  proto, caddr_net:0 -> vaddr:vport_or_0
  proto, caddr_net:0 -> fwmark:0
- persistence engine templates: hn0 node (dir 0): as before

Also reorder the ip_vs_conn fields, so that hash nodes are on same
read-mostly cache line while write-mostly fields are on separate
cache line.

Reported-by: Simon Kirby <sim@hostway.ca>
Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h             | 104 ++++++++----
 net/netfilter/ipvs/ip_vs_conn.c | 279 ++++++++++++++++++++++++--------
 2 files changed, 279 insertions(+), 104 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index ed74e4e36f21..5eb11ef9601a 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -785,51 +785,48 @@ struct ip_vs_conn_param {
 	__u8				pe_data_len;
 };
 
+/* Hash node in conn_tab */
+struct ip_vs_conn_hnode {
+	struct hlist_bl_node	node;		/* node in conn_tab */
+	u32			hash_key;	/* Key for the hash table */
+	u8			dir;		/* 0=out->in, 1=in->out */
+} __packed;
+
 /* IP_VS structure allocated for each dynamically scheduled connection */
 struct ip_vs_conn {
-	struct hlist_bl_node	c_list;         /* node in conn_tab */
-	__u32			hash_key;	/* Key for the hash table */
-	/* Protocol, addresses and port numbers */
+	/* Cacheline for hash table nodes - rarely modified */
+
+	struct ip_vs_conn_hnode	hn0;		/* Original direction */
+	u8			af;		/* address family */
 	__be16                  cport;
+	struct ip_vs_conn_hnode	hn1;		/* Reply direction */
+	u8			daf;		/* Address family of the dest */
 	__be16                  dport;
-	__be16                  vport;
-	u16			af;		/* address family */
-	__u16                   protocol;       /* Which protocol (TCP/UDP) */
-	__u16			daf;		/* Address family of the dest */
-	union nf_inet_addr      caddr;          /* client address */
-	union nf_inet_addr      vaddr;          /* virtual address */
-	union nf_inet_addr      daddr;          /* destination address */
+	struct ip_vs_dest       *dest;          /* real server */
+	atomic_t                n_control;      /* Number of controlled ones */
 	volatile __u32          flags;          /* status flags */
-	struct netns_ipvs	*ipvs;
-
-	/* counter and timer */
-	refcount_t		refcnt;		/* reference count */
-	struct timer_list	timer;		/* Expiration timer */
-	volatile unsigned long	timeout;	/* timeout */
+	/* 44/64 */
 
-	/* Flags and state transition */
-	spinlock_t              lock;           /* lock for state transition */
+	struct ip_vs_conn       *control;       /* Master control connection */
+	const struct ip_vs_pe	*pe;
+	char			*pe_data;
+	__u8			pe_data_len;
 	volatile __u16          state;          /* state info */
 	volatile __u16          old_state;      /* old state, to be used for
 						 * state transition triggered
 						 * synchronization
 						 */
-	__u32			fwmark;		/* Fire wall mark from skb */
-	unsigned long		sync_endtime;	/* jiffies + sent_retries */
+	/* 2-byte hole */
+	/* 64/96 */
 
-	/* Control members */
-	struct ip_vs_conn       *control;       /* Master control connection */
-	atomic_t                n_control;      /* Number of controlled ones */
-	struct ip_vs_dest       *dest;          /* real server */
-	atomic_t                in_pkts;        /* incoming packet counter */
+	union nf_inet_addr      caddr;          /* client address */
+	union nf_inet_addr      vaddr;          /* virtual address */
+	/* 96/128 */
 
-	/* Packet transmitter for different forwarding methods.  If it
-	 * mangles the packet, it must return NF_DROP or better NF_STOLEN,
-	 * otherwise this must be changed to a sk_buff **.
-	 * NF_ACCEPT can be returned when destination is local.
-	 */
-	int (*packet_xmit)(struct sk_buff *skb, struct ip_vs_conn *cp,
-			   struct ip_vs_protocol *pp, struct ip_vs_iphdr *iph);
+	union nf_inet_addr      daddr;          /* destination address */
+	__u32			fwmark;		/* Fire wall mark from skb */
+	__be16                  vport;
+	__u16                   protocol;       /* Which protocol (TCP/UDP) */
 
 	/* Note: we can group the following members into a structure,
 	 * in order to save more space, and the following members are
@@ -837,14 +834,31 @@ struct ip_vs_conn {
 	 */
 	struct ip_vs_app        *app;           /* bound ip_vs_app object */
 	void                    *app_data;      /* Application private data */
+	/* 128/168 */
 	struct_group(sync_conn_opt,
 		struct ip_vs_seq  in_seq;       /* incoming seq. struct */
 		struct ip_vs_seq  out_seq;      /* outgoing seq. struct */
 	);
+	/* 152/192 */
 
-	const struct ip_vs_pe	*pe;
-	char			*pe_data;
-	__u8			pe_data_len;
+	struct timer_list	timer;		/* Expiration timer */
+	volatile unsigned long	timeout;	/* timeout */
+	spinlock_t              lock;           /* lock for state transition */
+	refcount_t		refcnt;		/* reference count */
+	atomic_t                in_pkts;        /* incoming packet counter */
+	/* 64-bit: 4-byte gap */
+
+	/* 188/256 */
+	unsigned long		sync_endtime;	/* jiffies + sent_retries */
+	struct netns_ipvs	*ipvs;
+
+	/* Packet transmitter for different forwarding methods.  If it
+	 * mangles the packet, it must return NF_DROP or better NF_STOLEN,
+	 * otherwise this must be changed to a sk_buff **.
+	 * NF_ACCEPT can be returned when destination is local.
+	 */
+	int (*packet_xmit)(struct sk_buff *skb, struct ip_vs_conn *cp,
+			   struct ip_vs_protocol *pp, struct ip_vs_iphdr *iph);
 
 	struct rcu_head		rcu_head;
 };
@@ -1614,6 +1628,19 @@ int ip_vs_conn_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t,
 struct ip_vs_rht *ip_vs_conn_tab_alloc(struct netns_ipvs *ipvs, int buckets,
 				       int lfactor);
 
+static inline struct ip_vs_conn *
+ip_vs_hn0_to_conn(struct ip_vs_conn_hnode *hn)
+{
+	return container_of(hn, struct ip_vs_conn, hn0);
+}
+
+static inline struct ip_vs_conn *
+ip_vs_hn_to_conn(struct ip_vs_conn_hnode *hn)
+{
+	return hn->dir ? container_of(hn, struct ip_vs_conn, hn1) :
+			 container_of(hn, struct ip_vs_conn, hn0);
+}
+
 struct ip_vs_conn *ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 				  const union nf_inet_addr *daddr,
 				  __be16 dport, unsigned int flags,
@@ -1966,6 +1993,13 @@ static inline char ip_vs_fwd_tag(struct ip_vs_conn *cp)
 	return fwd;
 }
 
+/* Check if connection uses double hashing */
+static inline bool ip_vs_conn_use_hash2(struct ip_vs_conn *cp)
+{
+	return IP_VS_FWD_METHOD(cp) == IP_VS_CONN_F_MASQ &&
+	       !(cp->flags & IP_VS_CONN_F_TEMPLATE);
+}
+
 void ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		    struct ip_vs_conn *cp, int dir);
 
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 80858d9c69ac..25b3378664ca 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -76,11 +76,19 @@ static struct kmem_cache *ip_vs_conn_cachep __read_mostly;
 /* Lock conn_tab bucket for conn hash/unhash, not for rehash */
 static __always_inline void
 conn_tab_lock(struct ip_vs_rht *t, struct ip_vs_conn *cp, u32 hash_key,
-	      bool new_hash, struct hlist_bl_head **head_ret)
+	      u32 hash_key2, bool use2, bool new_hash,
+	      struct hlist_bl_head **head_ret, struct hlist_bl_head **head2_ret)
 {
-	struct hlist_bl_head *head;
-	u32 hash_key_new;
+	struct hlist_bl_head *head, *head2;
+	u32 hash_key_new, hash_key_new2;
+	struct ip_vs_rht *t2 = t;
+	u32 idx, idx2;
 
+	idx = hash_key & t->mask;
+	if (use2)
+		idx2 = hash_key2 & t->mask;
+	else
+		idx2 = idx;
 	if (!new_hash) {
 		/* We need to lock the bucket in the right table */
 
@@ -88,31 +96,64 @@ conn_tab_lock(struct ip_vs_rht *t, struct ip_vs_conn *cp, u32 hash_key,
 		if (!ip_vs_rht_same_table(t, hash_key)) {
 			/* It is already moved to new table */
 			t = rcu_dereference(t->new_tbl);
+			/* Rehashing works in two steps and we may detect
+			 * both nodes in different tables, use idx/idx2
+			 * for proper lock ordering for heads.
+			 */
+			idx = hash_key & t->mask;
+			idx |= IP_VS_RHT_TABLE_ID_MASK;
+		}
+		if (use2) {
+			if (!ip_vs_rht_same_table(t2, hash_key2)) {
+				/* It is already moved to new table */
+				t2 = rcu_dereference(t2->new_tbl);
+				idx2 = hash_key2 & t2->mask;
+				idx2 |= IP_VS_RHT_TABLE_ID_MASK;
+			}
+		} else {
+			idx2 = idx;
 		}
 	}
 
 	head = t->buckets + (hash_key & t->mask);
+	head2 = use2 ? t2->buckets + (hash_key2 & t2->mask) : head;
 
 	local_bh_disable();
 	/* Do not touch seqcount, this is a safe operation */
 
-	hlist_bl_lock(head);
+	if (idx <= idx2) {
+		hlist_bl_lock(head);
+		if (head != head2)
+			hlist_bl_lock(head2);
+	} else {
+		hlist_bl_lock(head2);
+		hlist_bl_lock(head);
+	}
 	if (!new_hash) {
 		/* Ensure hash_key is read under lock */
-		hash_key_new = READ_ONCE(cp->hash_key);
+		hash_key_new = READ_ONCE(cp->hn0.hash_key);
+		hash_key_new2 = READ_ONCE(cp->hn1.hash_key);
 		/* Hash changed ? */
-		if (hash_key != hash_key_new) {
+		if (hash_key != hash_key_new ||
+		    (hash_key2 != hash_key_new2 && use2)) {
+			if (head != head2)
+				hlist_bl_unlock(head2);
 			hlist_bl_unlock(head);
 			local_bh_enable();
 			hash_key = hash_key_new;
+			hash_key2 = hash_key_new2;
 			goto retry;
 		}
 	}
 	*head_ret = head;
+	*head2_ret = head2;
 }
 
-static inline void conn_tab_unlock(struct hlist_bl_head *head)
+static inline void conn_tab_unlock(struct hlist_bl_head *head,
+				   struct hlist_bl_head *head2)
 {
+	if (head != head2)
+		hlist_bl_unlock(head2);
 	hlist_bl_unlock(head);
 	local_bh_enable();
 }
@@ -123,26 +164,34 @@ static void ip_vs_conn_expire(struct timer_list *t);
  *	Returns hash value for IPVS connection entry
  */
 static u32 ip_vs_conn_hashkey(struct ip_vs_rht *t, int af, unsigned int proto,
-			      const union nf_inet_addr *addr, __be16 port)
+			      const union nf_inet_addr *addr, __be16 port,
+			      const union nf_inet_addr *laddr, __be16 lport)
 {
 	u64 a = (u32)proto << 16 | (__force u32)port;
+	u64 d;
 
 #ifdef CONFIG_IP_VS_IPV6
 	if (af == AF_INET6) {
 		u64 b = (u64)addr->all[0] << 32 | addr->all[1];
 		u64 c = (u64)addr->all[2] << 32 | addr->all[3];
 
-		return (u32)siphash_3u64(a, b, c, &t->hash_key);
+		a |= (u64)laddr->all[2] << 32 ^ (__force u32)lport;
+		c ^= laddr->all[1];
+		d = (u64)laddr->all[0] << 32 | laddr->all[3];
+		return (u32)siphash_4u64(a, b, c, d, &t->hash_key);
 	}
 #endif
 	a |= (u64)addr->all[0] << 32;
-	return (u32)siphash_1u64(a, &t->hash_key);
+	d = (u64)laddr->all[0] << 32 | (__force u32)lport;
+	return (u32)siphash_2u64(a, d, &t->hash_key);
 }
 
 static unsigned int ip_vs_conn_hashkey_param(const struct ip_vs_conn_param *p,
 					     struct ip_vs_rht *t, bool inverse)
 {
+	const union nf_inet_addr *laddr;
 	const union nf_inet_addr *addr;
+	__be16 lport;
 	__be16 port;
 
 	if (p->pe_data && p->pe->hashkey_raw)
@@ -151,21 +200,33 @@ static unsigned int ip_vs_conn_hashkey_param(const struct ip_vs_conn_param *p,
 	if (likely(!inverse)) {
 		addr = p->caddr;
 		port = p->cport;
+		laddr = p->vaddr;
+		lport = p->vport;
 	} else {
 		addr = p->vaddr;
 		port = p->vport;
+		laddr = p->caddr;
+		lport = p->cport;
 	}
 
-	return ip_vs_conn_hashkey(t, p->af, p->protocol, addr, port);
+	return ip_vs_conn_hashkey(t, p->af, p->protocol, addr, port, laddr,
+				  lport);
 }
 
 static unsigned int ip_vs_conn_hashkey_conn(struct ip_vs_rht *t,
-					    const struct ip_vs_conn *cp)
+					    const struct ip_vs_conn *cp,
+					    bool out)
 {
 	struct ip_vs_conn_param p;
 
-	ip_vs_conn_fill_param(cp->ipvs, cp->af, cp->protocol,
-			      &cp->caddr, cp->cport, NULL, 0, &p);
+	if (!out)
+		ip_vs_conn_fill_param(cp->ipvs, cp->af, cp->protocol,
+				      &cp->caddr, cp->cport, &cp->vaddr,
+				      cp->vport, &p);
+	else
+		ip_vs_conn_fill_param(cp->ipvs, cp->af, cp->protocol,
+				      &cp->daddr, cp->dport, &cp->caddr,
+				      cp->cport, &p);
 
 	if (cp->pe) {
 		p.pe = cp->pe;
@@ -173,7 +234,7 @@ static unsigned int ip_vs_conn_hashkey_conn(struct ip_vs_rht *t,
 		p.pe_data_len = cp->pe_data_len;
 	}
 
-	return ip_vs_conn_hashkey_param(&p, t, false);
+	return ip_vs_conn_hashkey_param(&p, t, out);
 }
 
 /*	Hashes ip_vs_conn in conn_tab
@@ -182,9 +243,11 @@ static unsigned int ip_vs_conn_hashkey_conn(struct ip_vs_rht *t,
 static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 {
 	struct netns_ipvs *ipvs = cp->ipvs;
-	struct hlist_bl_head *head;
+	struct hlist_bl_head *head, *head2;
+	u32 hash_key, hash_key2;
 	struct ip_vs_rht *t;
-	u32 hash_key;
+	u32 hash, hash2;
+	bool use2;
 	int ret;
 
 	if (cp->flags & IP_VS_CONN_F_ONE_PACKET)
@@ -194,15 +257,28 @@ static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 	t = rcu_dereference(ipvs->conn_tab);
 	t = rcu_dereference(t->new_tbl);
 
-	hash_key = ip_vs_rht_build_hash_key(t, ip_vs_conn_hashkey_conn(t, cp));
-	conn_tab_lock(t, cp, hash_key, true /* new_hash */, &head);
+	hash = ip_vs_conn_hashkey_conn(t, cp, false);
+	hash_key = ip_vs_rht_build_hash_key(t, hash);
+	if (ip_vs_conn_use_hash2(cp)) {
+		hash2 = ip_vs_conn_hashkey_conn(t, cp, true);
+		hash_key2 = ip_vs_rht_build_hash_key(t, hash2);
+		use2 = true;
+	} else {
+		hash_key2 = hash_key;
+		use2 = false;
+	}
+	conn_tab_lock(t, cp, hash_key, hash_key2, use2, true /* new_hash */,
+		      &head, &head2);
 	spin_lock(&cp->lock);
 
 	if (!(cp->flags & IP_VS_CONN_F_HASHED)) {
 		cp->flags |= IP_VS_CONN_F_HASHED;
-		WRITE_ONCE(cp->hash_key, hash_key);
+		WRITE_ONCE(cp->hn0.hash_key, hash_key);
+		WRITE_ONCE(cp->hn1.hash_key, hash_key2);
 		refcount_inc(&cp->refcnt);
-		hlist_bl_add_head_rcu(&cp->c_list, head);
+		hlist_bl_add_head_rcu(&cp->hn0.node, head);
+		if (use2)
+			hlist_bl_add_head_rcu(&cp->hn1.node, head2);
 		ret = 1;
 	} else {
 		pr_err("%s(): request for already hashed, called from %pS\n",
@@ -211,7 +287,7 @@ static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 	}
 
 	spin_unlock(&cp->lock);
-	conn_tab_unlock(head);
+	conn_tab_unlock(head, head2);
 
 	/* Schedule resizing if load increases */
 	if (atomic_read(&ipvs->conn_count) > t->u_thresh &&
@@ -227,10 +303,11 @@ static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 static inline bool ip_vs_conn_unlink(struct ip_vs_conn *cp)
 {
 	struct netns_ipvs *ipvs = cp->ipvs;
-	struct hlist_bl_head *head;
+	struct hlist_bl_head *head, *head2;
+	u32 hash_key, hash_key2;
 	struct ip_vs_rht *t;
 	bool ret = false;
-	u32 hash_key;
+	bool use2;
 
 	if (cp->flags & IP_VS_CONN_F_ONE_PACKET)
 		return refcount_dec_if_one(&cp->refcnt);
@@ -238,22 +315,27 @@ static inline bool ip_vs_conn_unlink(struct ip_vs_conn *cp)
 	rcu_read_lock();
 
 	t = rcu_dereference(ipvs->conn_tab);
-	hash_key = READ_ONCE(cp->hash_key);
+	hash_key = READ_ONCE(cp->hn0.hash_key);
+	hash_key2 = READ_ONCE(cp->hn1.hash_key);
+	use2 = ip_vs_conn_use_hash2(cp);
 
-	conn_tab_lock(t, cp, hash_key, false /* new_hash */, &head);
+	conn_tab_lock(t, cp, hash_key, hash_key2, use2, false /* new_hash */,
+		      &head, &head2);
 	spin_lock(&cp->lock);
 
 	if (cp->flags & IP_VS_CONN_F_HASHED) {
 		/* Decrease refcnt and unlink conn only if we are last user */
 		if (refcount_dec_if_one(&cp->refcnt)) {
-			hlist_bl_del_rcu(&cp->c_list);
+			hlist_bl_del_rcu(&cp->hn0.node);
+			if (use2)
+				hlist_bl_del_rcu(&cp->hn1.node);
 			cp->flags &= ~IP_VS_CONN_F_HASHED;
 			ret = true;
 		}
 	}
 
 	spin_unlock(&cp->lock);
-	conn_tab_unlock(head);
+	conn_tab_unlock(head, head2);
 
 	rcu_read_unlock();
 
@@ -272,6 +354,7 @@ __ip_vs_conn_in_get(const struct ip_vs_conn_param *p)
 {
 	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
 	struct netns_ipvs *ipvs = p->ipvs;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_head *head;
 	struct ip_vs_rht *t, *pt;
 	struct hlist_bl_node *e;
@@ -284,9 +367,12 @@ __ip_vs_conn_in_get(const struct ip_vs_conn_param *p)
 		hash = ip_vs_conn_hashkey_param(p, t, false);
 		hash_key = ip_vs_rht_build_hash_key(t, hash);
 		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
-			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
-				if (READ_ONCE(cp->hash_key) == hash_key &&
-				    p->cport == cp->cport &&
+			hlist_bl_for_each_entry_rcu(hn, e, head, node) {
+				if (READ_ONCE(hn->hash_key) != hash_key ||
+				    hn->dir != 0)
+					continue;
+				cp = ip_vs_hn0_to_conn(hn);
+				if (p->cport == cp->cport &&
 				    p->vport == cp->vport && cp->af == p->af &&
 				    ip_vs_addr_equal(p->af, p->caddr,
 						     &cp->caddr) &&
@@ -376,6 +462,7 @@ struct ip_vs_conn *ip_vs_ct_in_get(const struct ip_vs_conn_param *p)
 {
 	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
 	struct netns_ipvs *ipvs = p->ipvs;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_head *head;
 	struct ip_vs_rht *t, *pt;
 	struct hlist_bl_node *e;
@@ -388,9 +475,11 @@ struct ip_vs_conn *ip_vs_ct_in_get(const struct ip_vs_conn_param *p)
 		hash = ip_vs_conn_hashkey_param(p, t, false);
 		hash_key = ip_vs_rht_build_hash_key(t, hash);
 		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
-			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
-				if (READ_ONCE(cp->hash_key) != hash_key)
+			hlist_bl_for_each_entry_rcu(hn, e, head, node) {
+				if (READ_ONCE(hn->hash_key) != hash_key ||
+				    hn->dir != 0)
 					continue;
+				cp = ip_vs_hn0_to_conn(hn);
 				if (unlikely(p->pe_data && p->pe->ct_match)) {
 					if (p->pe == cp->pe &&
 					    p->pe->ct_match(p, cp) &&
@@ -442,6 +531,7 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
 	struct netns_ipvs *ipvs = p->ipvs;
 	const union nf_inet_addr *saddr;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_head *head;
 	struct ip_vs_rht *t, *pt;
 	struct hlist_bl_node *e;
@@ -455,9 +545,12 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 		hash = ip_vs_conn_hashkey_param(p, t, true);
 		hash_key = ip_vs_rht_build_hash_key(t, hash);
 		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
-			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
-				if (READ_ONCE(cp->hash_key) != hash_key ||
-				    p->vport != cp->cport)
+			hlist_bl_for_each_entry_rcu(hn, e, head, node) {
+				/* dir can be 0 for DR/TUN */
+				if (READ_ONCE(hn->hash_key) != hash_key)
+					continue;
+				cp = ip_vs_hn_to_conn(hn);
+				if (p->vport != cp->cport)
 					continue;
 
 				if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ) {
@@ -536,21 +629,33 @@ void ip_vs_conn_put(struct ip_vs_conn *cp)
 void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 {
 	struct hlist_bl_head *head, *head2, *head_new;
+	bool use2 = ip_vs_conn_use_hash2(cp);
 	struct netns_ipvs *ipvs = cp->ipvs;
 	int af_id = ip_vs_af_index(cp->af);
 	u32 hash_r = 0, hash_key_r = 0;
 	struct ip_vs_rht *t, *tp, *t2;
+	struct ip_vs_conn_hnode *hn;
 	u32 hash_key, hash_key_new;
 	struct ip_vs_conn_param p;
 	int ntbl;
+	int dir;
 
-	ip_vs_conn_fill_param(ipvs, cp->af, cp->protocol, &cp->caddr,
-			      cport, &cp->vaddr, cp->vport, &p);
+	/* No packets from inside, so we can do it in 2 steps. */
+	dir = use2 ? 1 : 0;
+
+next_dir:
+	if (dir)
+		ip_vs_conn_fill_param(ipvs, cp->af, cp->protocol, &cp->daddr,
+				      cp->dport, &cp->caddr, cport, &p);
+	else
+		ip_vs_conn_fill_param(ipvs, cp->af, cp->protocol, &cp->caddr,
+				      cport, &cp->vaddr, cp->vport, &p);
+	hn = dir ? &cp->hn1 : &cp->hn0;
 	ntbl = 0;
 
 	/* Attempt to rehash cp safely, by informing seqcount readers */
 	t = rcu_dereference(ipvs->conn_tab);
-	hash_key = READ_ONCE(cp->hash_key);
+	hash_key = READ_ONCE(hn->hash_key);
 	tp = NULL;
 
 retry:
@@ -567,7 +672,7 @@ void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 	t2 = rcu_dereference(t->new_tbl);
 	/* Calc new hash once per table */
 	if (tp != t2) {
-		hash_r = ip_vs_conn_hashkey_param(&p, t2, false);
+		hash_r = ip_vs_conn_hashkey_param(&p, t2, dir);
 		hash_key_r = ip_vs_rht_build_hash_key(t2, hash_r);
 		tp = t2;
 	}
@@ -591,7 +696,7 @@ void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 		hlist_bl_lock(head2);
 
 	/* Ensure hash_key is read under lock */
-	hash_key_new = READ_ONCE(cp->hash_key);
+	hash_key_new = READ_ONCE(hn->hash_key);
 	/* Racing with another rehashing ? */
 	if (unlikely(hash_key != hash_key_new)) {
 		if (head != head2)
@@ -611,14 +716,21 @@ void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 		 * parameters in cp do not change, i.e. cport is
 		 * the only possible change.
 		 */
-		WRITE_ONCE(cp->hash_key, hash_key_r);
+		WRITE_ONCE(hn->hash_key, hash_key_r);
+		if (!use2)
+			WRITE_ONCE(cp->hn1.hash_key, hash_key_r);
+		/* For dir=1 we do not check in flags if hn is already
+		 * rehashed but this check will do it.
+		 */
 		if (head != head2) {
-			hlist_bl_del_rcu(&cp->c_list);
-			hlist_bl_add_head_rcu(&cp->c_list, head_new);
+			hlist_bl_del_rcu(&hn->node);
+			hlist_bl_add_head_rcu(&hn->node, head_new);
+		}
+		if (!dir) {
+			atomic_dec(&ipvs->no_cport_conns[af_id]);
+			cp->flags &= ~IP_VS_CONN_F_NO_CPORT;
+			cp->cport = cport;
 		}
-		atomic_dec(&ipvs->no_cport_conns[af_id]);
-		cp->flags &= ~IP_VS_CONN_F_NO_CPORT;
-		cp->cport = cport;
 	}
 	spin_unlock(&cp->lock);
 
@@ -628,6 +740,8 @@ void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 	write_seqcount_end(&t->seqc[hash_key & t->seqc_mask]);
 	preempt_enable_nested();
 	spin_unlock_bh(&t->lock[hash_key & t->lock_mask].l);
+	if (dir--)
+		goto next_dir;
 }
 
 /* Get default load factor to map conn_count/u_thresh to t->size */
@@ -639,6 +753,8 @@ static int ip_vs_conn_default_load_factor(struct netns_ipvs *ipvs)
 		factor = 3;
 	else
 		factor = 1;
+	/* Double hashing adds twice more nodes for NAT */
+	factor++;
 	return factor;
 }
 
@@ -679,6 +795,7 @@ static void conn_resize_work_handler(struct work_struct *work)
 	unsigned int resched_score = 0;
 	struct hlist_bl_node *cn, *nn;
 	struct ip_vs_rht *t, *t_new;
+	struct ip_vs_conn_hnode *hn;
 	struct netns_ipvs *ipvs;
 	struct ip_vs_conn *cp;
 	bool more_work = false;
@@ -751,8 +868,9 @@ static void conn_resize_work_handler(struct work_struct *work)
 		write_seqcount_begin(&t->seqc[bucket & t->seqc_mask]);
 		hlist_bl_lock(head);
 
-		hlist_bl_for_each_entry_safe(cp, cn, nn, head, c_list) {
-			hash = ip_vs_conn_hashkey_conn(t_new, cp);
+		hlist_bl_for_each_entry_safe(hn, cn, nn, head, node) {
+			cp = ip_vs_hn_to_conn(hn);
+			hash = ip_vs_conn_hashkey_conn(t_new, cp, hn->dir);
 			hash_key = ip_vs_rht_build_hash_key(t_new, hash);
 
 			head2 = t_new->buckets + (hash & t_new->mask);
@@ -760,9 +878,12 @@ static void conn_resize_work_handler(struct work_struct *work)
 			/* t_new->seqc are not used at this stage, we race
 			 * only with add/del, so only lock the bucket.
 			 */
-			hlist_bl_del_rcu(&cp->c_list);
-			WRITE_ONCE(cp->hash_key, hash_key);
-			hlist_bl_add_head_rcu(&cp->c_list, head2);
+			hlist_bl_del_rcu(&hn->node);
+			WRITE_ONCE(hn->hash_key, hash_key);
+			/* Keep both hash keys in sync if no double hashing */
+			if (!ip_vs_conn_use_hash2(cp))
+				WRITE_ONCE(cp->hn1.hash_key, hash_key);
+			hlist_bl_add_head_rcu(&hn->node, head2);
 			hlist_bl_unlock(head2);
 			/* Too long chain? Do it in steps */
 			if (++limit >= 64)
@@ -1245,10 +1366,13 @@ ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 		return NULL;
 	}
 
-	INIT_HLIST_BL_NODE(&cp->c_list);
+	INIT_HLIST_BL_NODE(&cp->hn0.node);
+	INIT_HLIST_BL_NODE(&cp->hn1.node);
 	timer_setup(&cp->timer, ip_vs_conn_expire, 0);
 	cp->ipvs	   = ipvs;
+	cp->hn0.dir	   = 0;
 	cp->af		   = p->af;
+	cp->hn1.dir	   = 1;
 	cp->daf		   = dest_af;
 	cp->protocol	   = p->protocol;
 	ip_vs_addr_set(p->af, &cp->caddr, p->caddr);
@@ -1352,22 +1476,24 @@ static void *ip_vs_conn_array(struct seq_file *seq, loff_t pos)
 	struct net *net = seq_file_net(seq);
 	struct netns_ipvs *ipvs = net_ipvs(net);
 	struct ip_vs_rht *t = iter->t;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_node *e;
-	struct ip_vs_conn *cp;
 	int idx;
 
 	if (!t)
 		return NULL;
 	for (idx = 0; idx < t->size; idx++) {
-		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[idx], c_list) {
+		hlist_bl_for_each_entry_rcu(hn, e, &t->buckets[idx], node) {
 			/* __ip_vs_conn_get() is not needed by
 			 * ip_vs_conn_seq_show and ip_vs_conn_sync_seq_show
 			 */
-			if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+			if (!ip_vs_rht_same_table(t, READ_ONCE(hn->hash_key)))
 				break;
+			if (hn->dir != 0)
+				continue;
 			if (pos-- == 0) {
 				iter->bucket = idx;
-				return cp;
+				return hn;
 			}
 		}
 		if (!(idx & 31)) {
@@ -1400,7 +1526,7 @@ static void *ip_vs_conn_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	struct ip_vs_iter_state *iter = seq->private;
 	struct net *net = seq_file_net(seq);
 	struct netns_ipvs *ipvs = net_ipvs(net);
-	struct ip_vs_conn *cp = v;
+	struct ip_vs_conn_hnode *hn = v;
 	struct hlist_bl_node *e;
 	struct ip_vs_rht *t;
 
@@ -1413,19 +1539,21 @@ static void *ip_vs_conn_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return NULL;
 
 	/* more on same hash chain? */
-	hlist_bl_for_each_entry_continue_rcu(cp, e, c_list) {
+	hlist_bl_for_each_entry_continue_rcu(hn, e, node) {
 		/* Our cursor was moved to new table ? */
-		if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+		if (!ip_vs_rht_same_table(t, READ_ONCE(hn->hash_key)))
 			break;
-		return cp;
+		if (!hn->dir)
+			return hn;
 	}
 
 	while (++iter->bucket < t->size) {
-		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[iter->bucket],
-					    c_list) {
-			if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+		hlist_bl_for_each_entry_rcu(hn, e, &t->buckets[iter->bucket],
+					    node) {
+			if (!ip_vs_rht_same_table(t, READ_ONCE(hn->hash_key)))
 				break;
-			return cp;
+			if (!hn->dir)
+				return hn;
 		}
 		if (!(iter->bucket & 31)) {
 			cond_resched_rcu();
@@ -1450,7 +1578,8 @@ static int ip_vs_conn_seq_show(struct seq_file *seq, void *v)
 		seq_puts(seq,
    "Pro FromIP   FPrt ToIP     TPrt DestIP   DPrt State       Expires PEName PEData\n");
 	else {
-		const struct ip_vs_conn *cp = v;
+		struct ip_vs_conn_hnode *hn = v;
+		const struct ip_vs_conn *cp = ip_vs_hn0_to_conn(hn);
 		char pe_data[IP_VS_PENAME_MAXLEN + IP_VS_PEDATA_MAXLEN + 3];
 		size_t len = 0;
 		char dbuf[IP_VS_ADDRSTRLEN];
@@ -1616,6 +1745,7 @@ static inline bool ip_vs_conn_ops_mode(struct ip_vs_conn *cp)
 
 void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 {
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_node *e;
 	struct ip_vs_conn *cp;
 	struct ip_vs_rht *t;
@@ -1638,7 +1768,10 @@ void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 		/* Don't care if due to moved entry we jump to another bucket
 		 * and even to new table
 		 */
-		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[hash], c_list) {
+		hlist_bl_for_each_entry_rcu(hn, e, &t->buckets[hash], node) {
+			if (hn->dir != 0)
+				continue;
+			cp = ip_vs_hn0_to_conn(hn);
 			if (atomic_read(&cp->n_control))
 				continue;
 			if (cp->flags & IP_VS_CONN_F_TEMPLATE) {
@@ -1703,6 +1836,7 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
 {
 	DECLARE_IP_VS_RHT_WALK_BUCKETS_SAFE_RCU();
 	struct ip_vs_conn *cp, *cp_c;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_head *head;
 	struct ip_vs_rht *t, *p;
 	struct hlist_bl_node *e;
@@ -1718,7 +1852,10 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
 	/* Rely on RCU grace period while accessing cp after ip_vs_conn_del */
 	rcu_read_lock();
 	ip_vs_rht_walk_buckets_safe_rcu(ipvs->conn_tab, head) {
-		hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+		hlist_bl_for_each_entry_rcu(hn, e, head, node) {
+			if (hn->dir != 0)
+				continue;
+			cp = ip_vs_hn0_to_conn(hn);
 			if (atomic_read(&cp->n_control))
 				continue;
 			cp_c = cp->control;
@@ -1761,6 +1898,7 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 	DECLARE_IP_VS_RHT_WALK_BUCKETS_RCU();
 	unsigned int resched_score = 0;
 	struct ip_vs_conn *cp, *cp_c;
+	struct ip_vs_conn_hnode *hn;
 	struct hlist_bl_head *head;
 	struct ip_vs_dest *dest;
 	struct hlist_bl_node *e;
@@ -1774,7 +1912,10 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 repeat:
 	smp_rmb(); /* ipvs->conn_tab and conn_tab_changes */
 	ip_vs_rht_walk_buckets_rcu(ipvs->conn_tab, head) {
-		hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+		hlist_bl_for_each_entry_rcu(hn, e, head, node) {
+			if (hn->dir != 0)
+				continue;
+			cp = ip_vs_hn0_to_conn(hn);
 			resched_score++;
 			dest = cp->dest;
 			if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
-- 
2.41.0


