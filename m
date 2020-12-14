Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06E32D9B6D
	for <lists+lvs-devel@lfdr.de>; Mon, 14 Dec 2020 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439331AbgLNPtV (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 14 Dec 2020 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439147AbgLNPtL (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 14 Dec 2020 10:49:11 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56EC0613D3
        for <lvs-devel@vger.kernel.org>; Mon, 14 Dec 2020 07:48:30 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 2so16209684ilg.9
        for <lvs-devel@vger.kernel.org>; Mon, 14 Dec 2020 07:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBjESqAXIJOT18BD70Opt98NRa0MpVDCB0yG/m6J1IY=;
        b=GXZ+NBTG8hR/VJeZoOh9pNgWRrcvfXs7UC2gKvnc+zaH6sH/rWamEglCVUNLV0O1gp
         LdDkwvRHVZL9qP4vRz/NBdJv6+wZKSybn7jjP4YblfpOTdK7MBhE5kcuH2TBgI1ryKWm
         8pxF/315OGdsUHIapqZaR6h75Y5MrkYCJ8zb0K/OcQ367GLuvap971XmwFWox3Hgy2G7
         vb8uEXXevBiNIlFwRJi78kQlhkcJgFkPEGQDdZqQA2hxCKwi5CLQ4nI/FStCXe5hVj6k
         N1exjB5bomwwoOIrrj/i50ZqqiLShyF8MPnoy9UjEERAYhN5iB6AhpcUMuzqTf/yM8qO
         OCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBjESqAXIJOT18BD70Opt98NRa0MpVDCB0yG/m6J1IY=;
        b=tSC33qZ5LRrvTOCHW+Uqs6eQnERyl5XY6tm8zgJYJ4a0Wy5qemor5NGMH3mkE6Zs+A
         5KcSBU6EK2zhfq/TpLw/GE2DWE7ZdDZJPyRQe/yI0ki8sdNSzhXqwdqfocJfIz6rSfit
         yhI02lhstxn/lbWzUskzdNWi8+4+qjR3c0q5xSzP9iEBIa6pfNwctl/AmoKA+790vXgE
         mMJzEdL5DmlxQ8N4rwXQ/VXAKoG3YvHOAEpeSZTemIL8vgihtY/0Dhbr5XSOQPvLS1zO
         wF2Zz6HLJ6HDGy46TwyGmnH3BRJpZIyishZjDLbYB9CCuM/bUnuZWQTNy2JKs7+XkLcu
         pnow==
X-Gm-Message-State: AOAM5324e+ouzPl0AdaSJO0WawJHSVpR+VAyduVlEB9OWbaQ0tYG4kel
        NG9vAi28bfUePzkmcB3x1YCbvheS0rtMZA==
X-Google-Smtp-Source: ABdhPJzpjF7vtL/e4vjnWnfejOG3upfz4YoK+d2Fw/gZ3+SK0obEHgL+gTlNZIJ0g4JTmyeGQady+Q==
X-Received: by 2002:a92:ca91:: with SMTP id t17mr35123811ilo.67.1607960910074;
        Mon, 14 Dec 2020 07:48:30 -0800 (PST)
Received: from localhost.localdomain ([2601:647:5400:13e::1012])
        by smtp.googlemail.com with ESMTPSA id n10sm34807ila.69.2020.12.14.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:48:29 -0800 (PST)
From:   dpayne <darby.payne@gmail.com>
To:     ja@ssi.bg
Cc:     darby.payne@gmail.com, horms@verge.net.au,
        lvs-devel@vger.kernel.org
Subject: [PATCH v3] ipvs: add weighted random twos choice algorithm
Date:   Mon, 14 Dec 2020 07:48:05 -0800
Message-Id: <20201214154805.1680225-1-darby.payne@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <178332e-87a4-9aa3-5e4d-cc5af8ea227@ssi.bg>
References: <178332e-87a4-9aa3-5e4d-cc5af8ea227@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

I tried to address all issues. For the checkpatch script the only
warning left is about the maintainers file.

Signed-off-by: dpayne <darby.payne@gmail.com>
---
Changes in v3
 - start every line with a type
 - Make comments one line when possible
 - Fixed the comment when choosing servers
---
 net/netfilter/ipvs/Kconfig      |  11 +++
 net/netfilter/ipvs/Makefile     |   1 +
 net/netfilter/ipvs/ip_vs_twos.c | 146 ++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 net/netfilter/ipvs/ip_vs_twos.c

diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index eb0e329f9b8d..8ca542a759d4 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -271,6 +271,17 @@ config	IP_VS_NQ
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
+config	IP_VS_TWOS
+	tristate "weighted random twos choice least-connection scheduling"
+	help
+	  The weighted random twos choice least-connection scheduling
+	  algorithm picks two random real servers and directs network
+	  connections to the server with the least active connections
+	  normalized by the server weight.
+
+	  If you want to compile it in kernel, say Y. To compile it as a
+	  module, choose M here. If unsure, say N.
+
 comment 'IPVS SH scheduler'
 
 config IP_VS_SH_TAB_BITS
diff --git a/net/netfilter/ipvs/Makefile b/net/netfilter/ipvs/Makefile
index bfce2677fda2..bb5d8125c82a 100644
--- a/net/netfilter/ipvs/Makefile
+++ b/net/netfilter/ipvs/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_IP_VS_SH) += ip_vs_sh.o
 obj-$(CONFIG_IP_VS_MH) += ip_vs_mh.o
 obj-$(CONFIG_IP_VS_SED) += ip_vs_sed.o
 obj-$(CONFIG_IP_VS_NQ) += ip_vs_nq.o
+obj-$(CONFIG_IP_VS_TWOS) += ip_vs_twos.o
 
 # IPVS application helpers
 obj-$(CONFIG_IP_VS_FTP) += ip_vs_ftp.o
diff --git a/net/netfilter/ipvs/ip_vs_twos.c b/net/netfilter/ipvs/ip_vs_twos.c
new file mode 100644
index 000000000000..38bdfe47cfc3
--- /dev/null
+++ b/net/netfilter/ipvs/ip_vs_twos.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * IPVS:        Power of Twos Choice Scheduling module
+ *
+ * Authors:     Darby Payne <darby.payne@applovin.com>
+ *
+ *              This program is free software; you can redistribute it and/or
+ *              modify it under the terms of the GNU General Public License
+ *              as published by the Free Software Foundation; either version
+ *              2 of the License, or (at your option) any later version.
+ *
+ */
+
+#define KMSG_COMPONENT "IPVS"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/random.h>
+
+#include <net/ip_vs.h>
+
+/*    Power of Twos Choice scheduling, algorithm originally described by
+ *    Michael Mitzenmacher.
+ *
+ *    Randomly picks two destinations and picks the one with the least
+ *    amount of connections
+ *
+ *    The algorithm calculates a few variables
+ *    - total_weight = sum of all weights
+ *    - rweight1 = random number between [0,total_weight]
+ *    - rweight2 = random number between [0,total_weight]
+ *
+ *    For each destination
+ *      decrement rweight1 and rweight2 by the destination weight
+ *      pick choice1 when rweight1 is <= 0
+ *      pick choice2 when rweight2 is <= 0
+ *
+ *    Return choice2 if choice2 has less connections than choice 1 normalized
+ *    by weight
+ *
+ * References
+ * ----------
+ *
+ * [Mitzenmacher 2016]
+ *    The Power of Two Random Choices: A Survey of Techniques and Results
+ *    Michael Mitzenmacher, Andrea W. Richa y, Ramesh Sitaraman
+ *    http://www.eecs.harvard.edu/~michaelm/NEWWORK/postscripts/twosurvey.pdf
+ *
+ */
+static struct ip_vs_dest *ip_vs_twos_schedule(struct ip_vs_service *svc,
+					      const struct sk_buff *skb,
+					      struct ip_vs_iphdr *iph)
+{
+	struct ip_vs_dest *dest, *choice1 = NULL, *choice2 = NULL;
+	int rweight1, rweight2, weight1 = -1, weight2 = -1, overhead1 = 0,
+	int overhead2, total_weight = 0, weight;
+
+	IP_VS_DBG(6, "%s(): Scheduling...\n", __func__);
+
+	/* Generate a random weight between [0,sum of all weights) */
+	list_for_each_entry_rcu(dest, &svc->destinations, n_list) {
+		if (!(dest->flags & IP_VS_DEST_F_OVERLOAD)) {
+			weight = atomic_read(&dest->weight);
+			if (weight > 0) {
+				total_weight += weight;
+				choice1 = dest;
+			}
+		}
+	}
+
+	if (!choice1) {
+		ip_vs_scheduler_err(svc, "no destination available");
+		return NULL;
+	}
+
+	/* Add 1 to total_weight so that the random weights are inclusive
+	 * from 0 to total_weight
+	 */
+	total_weight += 1;
+	rweight1 = prandom_u32() % total_weight;
+	rweight2 = prandom_u32() % total_weight;
+
+	/* Pick two weighted servers */
+	list_for_each_entry_rcu(dest, &svc->destinations, n_list) {
+		if (dest->flags & IP_VS_DEST_F_OVERLOAD)
+			continue;
+
+		weight = atomic_read(&dest->weight);
+		if (weight <= 0)
+			continue;
+
+		rweight1 -= weight;
+		rweight2 -= weight;
+
+		if (rweight1 <= 0 && weight1 == -1) {
+			choice1 = dest;
+			weight1 = weight;
+			overhead1 = ip_vs_dest_conn_overhead(dest);
+		}
+
+		if (rweight2 <= 0 && weight2 == -1) {
+			choice2 = dest;
+			weight2 = weight;
+			overhead2 = ip_vs_dest_conn_overhead(dest);
+		}
+
+		if (weight1 != -1 && weight2 != -1)
+			goto nextstage;
+	}
+
+nextstage:
+	if (choice2 && (weight2 * overhead1) > (weight1 * overhead2))
+		choice1 = choice2;
+
+	IP_VS_DBG_BUF(6, "twos: server %s:%u conns %d refcnt %d weight %d\n",
+		      IP_VS_DBG_ADDR(choice1->af, &choice1->addr),
+		      ntohs(choice1->port), atomic_read(&choice1->activeconns),
+		      refcount_read(&choice1->refcnt),
+		      atomic_read(&choice1->weight));
+
+	return choice1;
+}
+
+static struct ip_vs_scheduler ip_vs_twos_scheduler = {
+	.name = "twos",
+	.refcnt = ATOMIC_INIT(0),
+	.module = THIS_MODULE,
+	.n_list = LIST_HEAD_INIT(ip_vs_twos_scheduler.n_list),
+	.schedule = ip_vs_twos_schedule,
+};
+
+static int __init ip_vs_twos_init(void)
+{
+	return register_ip_vs_scheduler(&ip_vs_twos_scheduler);
+}
+
+static void __exit ip_vs_twos_cleanup(void)
+{
+	unregister_ip_vs_scheduler(&ip_vs_twos_scheduler);
+	synchronize_rcu();
+}
+
+module_init(ip_vs_twos_init);
+module_exit(ip_vs_twos_cleanup);
+MODULE_LICENSE("GPL");
-- 
2.29.2

