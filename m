Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09222A7D0
	for <lists+lvs-devel@lfdr.de>; Thu, 23 Jul 2020 08:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgGWGLg (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 23 Jul 2020 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgGWGJv (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 23 Jul 2020 02:09:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA999C0619DC;
        Wed, 22 Jul 2020 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mHiWtESnfpmKOGnGR9J/VvKy447qDpvbyAZDADMp9hY=; b=Gi7Go2u+fkcKAHjWWVRHPnv63N
        Y5wm/NGJ3YEIP3H54J9Y/ypxMj150A7NMUhmNveZRtZJ2pYVYRsZcmgKhuKhxVxC7Redsbb+O/81i
        fGIlQ9tNAWdl1Hkfeec2Meb64han1DNgmxuwAULfzNG3E1PnD5gz87po+HuwjTdg6MQ4V5S64kIX1
        XjSOF9i0AgfaeyNKUKwaUo7i9Of3zyl20novryBp7FE/7CQWJUWOhkuRXXwHIX/ieM/X8HDOQJicd
        xfvPqnpZUvvRe7IhEIkxmwLayvXHLpSIjLSDPErKJIV6SzuPGnPxa5f+mzZafn/nkGGcW4k3MkZvM
        w6+b9nNQ==;
Received: from [2001:4bb8:18c:2acc:91df:aae8:fa3b:de9c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyUQD-0003np-OJ; Thu, 23 Jul 2020 06:09:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
        mptcp@lists.01.org, lvs-devel@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org
Subject: [PATCH 20/26] net/ipv6: factor out a ipv6_set_opt_hdr helper
Date:   Thu, 23 Jul 2020 08:09:02 +0200
Message-Id: <20200723060908.50081-21-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723060908.50081-1-hch@lst.de>
References: <20200723060908.50081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Factour out a helper to set the IPv6 option headers from
do_ipv6_setsockopt.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/ipv6/ipv6_sockglue.c | 150 +++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 3897fb55372d38..90442c8366dff2 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -315,6 +315,80 @@ static int compat_ipv6_mcast_join_leave(struct sock *sk, int optname,
 	return ipv6_sock_mc_drop(sk, gr32.gr_interface, &psin6->sin6_addr);
 }
 
+static int ipv6_set_opt_hdr(struct sock *sk, int optname, void __user *optval,
+		int optlen)
+{
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_opt_hdr *new = NULL;
+	struct net *net = sock_net(sk);
+	struct ipv6_txoptions *opt;
+	int err;
+
+	/* hop-by-hop / destination options are privileged option */
+	if (optname != IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
+		return -EPERM;
+
+	/* remove any sticky options header with a zero option
+	 * length, per RFC3542.
+	 */
+	if (optlen > 0) {
+		if (!optval)
+			return -EINVAL;
+		if (optlen < sizeof(struct ipv6_opt_hdr) ||
+		    optlen & 0x7 ||
+		    optlen > 8 * 255)
+			return -EINVAL;
+
+		new = memdup_user(optval, optlen);
+		if (IS_ERR(new))
+			return PTR_ERR(new);
+		if (unlikely(ipv6_optlen(new) > optlen)) {
+			kfree(new);
+			return -EINVAL;
+		}
+	}
+
+	opt = rcu_dereference_protected(np->opt, lockdep_sock_is_held(sk));
+	opt = ipv6_renew_options(sk, opt, optname, new);
+	kfree(new);
+	if (IS_ERR(opt))
+		return PTR_ERR(opt);
+
+	/* routing header option needs extra check */
+	err = -EINVAL;
+	if (optname == IPV6_RTHDR && opt && opt->srcrt) {
+		struct ipv6_rt_hdr *rthdr = opt->srcrt;
+		switch (rthdr->type) {
+#if IS_ENABLED(CONFIG_IPV6_MIP6)
+		case IPV6_SRCRT_TYPE_2:
+			if (rthdr->hdrlen != 2 || rthdr->segments_left != 1)
+				goto sticky_done;
+			break;
+#endif
+		case IPV6_SRCRT_TYPE_4:
+		{
+			struct ipv6_sr_hdr *srh =
+				(struct ipv6_sr_hdr *)opt->srcrt;
+
+			if (!seg6_validate_srh(srh, optlen, false))
+				goto sticky_done;
+			break;
+		}
+		default:
+			goto sticky_done;
+		}
+	}
+
+	err = 0;
+	opt = ipv6_update_options(sk, opt);
+sticky_done:
+	if (opt) {
+		atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
+		txopt_put(opt);
+	}
+	return err;
+}
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -580,82 +654,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	case IPV6_RTHDRDSTOPTS:
 	case IPV6_RTHDR:
 	case IPV6_DSTOPTS:
-	{
-		struct ipv6_txoptions *opt;
-		struct ipv6_opt_hdr *new = NULL;
-
-		/* hop-by-hop / destination options are privileged option */
-		retv = -EPERM;
-		if (optname != IPV6_RTHDR && !ns_capable(net->user_ns, CAP_NET_RAW))
-			break;
-
-		/* remove any sticky options header with a zero option
-		 * length, per RFC3542.
-		 */
-		if (optlen == 0)
-			optval = NULL;
-		else if (!optval)
-			goto e_inval;
-		else if (optlen < sizeof(struct ipv6_opt_hdr) ||
-			 optlen & 0x7 || optlen > 8 * 255)
-			goto e_inval;
-		else {
-			new = memdup_user(optval, optlen);
-			if (IS_ERR(new)) {
-				retv = PTR_ERR(new);
-				break;
-			}
-			if (unlikely(ipv6_optlen(new) > optlen)) {
-				kfree(new);
-				goto e_inval;
-			}
-		}
-
-		opt = rcu_dereference_protected(np->opt,
-						lockdep_sock_is_held(sk));
-		opt = ipv6_renew_options(sk, opt, optname, new);
-		kfree(new);
-		if (IS_ERR(opt)) {
-			retv = PTR_ERR(opt);
-			break;
-		}
-
-		/* routing header option needs extra check */
-		retv = -EINVAL;
-		if (optname == IPV6_RTHDR && opt && opt->srcrt) {
-			struct ipv6_rt_hdr *rthdr = opt->srcrt;
-			switch (rthdr->type) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-			case IPV6_SRCRT_TYPE_2:
-				if (rthdr->hdrlen != 2 ||
-				    rthdr->segments_left != 1)
-					goto sticky_done;
-
-				break;
-#endif
-			case IPV6_SRCRT_TYPE_4:
-			{
-				struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)
-							  opt->srcrt;
-
-				if (!seg6_validate_srh(srh, optlen, false))
-					goto sticky_done;
-				break;
-			}
-			default:
-				goto sticky_done;
-			}
-		}
-
-		retv = 0;
-		opt = ipv6_update_options(sk, opt);
-sticky_done:
-		if (opt) {
-			atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
-			txopt_put(opt);
-		}
+		retv = ipv6_set_opt_hdr(sk, optname, optval, optlen);
 		break;
-	}
 
 	case IPV6_PKTINFO:
 	{
-- 
2.27.0

