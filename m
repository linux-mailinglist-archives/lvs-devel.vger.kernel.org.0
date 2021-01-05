Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DD2EB400
	for <lists+lvs-devel@lfdr.de>; Tue,  5 Jan 2021 21:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbhAEUQ7 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 5 Jan 2021 15:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbhAEUQ7 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 5 Jan 2021 15:16:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C113C061793
        for <lvs-devel@vger.kernel.org>; Tue,  5 Jan 2021 12:16:19 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id t9so929296ilf.2
        for <lvs-devel@vger.kernel.org>; Tue, 05 Jan 2021 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhPrXdkmzzVyWE9+Sa5psJNwgogOFG271jtxPu2n67k=;
        b=KmVzWOX3ue5D6sZ9RPCtHwseBUhCiojg/1NFf5kk7H2EVam2sqmtGxzqeTo1ztBK0g
         iLKHEOHd+fhyoPoBxczwe75GsV5jnbyZ5N5U/UlOjla5oVrhGkBPiKJFKJNLZ0gUFtZt
         ino59X40ai4mHy6fdsv/FAfA5tu/T7kcL/9cOAokudZ5SzDFUfBOMCNk/4vxocsS6Ywt
         JSWWoGbrdloTGfhwiCNybRncXQh1ISoEMp+KsEhi4FVboUOu5Wcp9hC8hWPQJ9y3ohd6
         5L7KOPmNkdXLsSHQ7a33j7KB5sSI2eDehfiEKiEh1AmbyU5VLImgm/yl99xb1vllmjY0
         zkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhPrXdkmzzVyWE9+Sa5psJNwgogOFG271jtxPu2n67k=;
        b=HDcwJ/kZBBF264nP+LMl5Z7EQ+qO86eoVAcRX3D9EvCioVi/NS1X/pgo7qIy+Timj6
         eamgqO3ApFhduR1wJhQE/PWTDuB9UYCqUCYkfQIzah86LaqgG8oA1bd2enwsgcm+CHt0
         tB/phTepdlNEfhxnS0VM9sulRrAXIr0bht95M9vqssYRjCsRlwCnHMFMM+S3P5/44I0F
         f1ePMc5VjSSsvAMioVBM77TYuNRq0hHrRylG2EA4S38xo4dNbIxU8ftLjCCY0o2vjdr7
         vdLFv/YW+WhLB9QF+WcNzr/qSoXLqznUIgYwyA7fFXo7c2Ulc1GtDwJYu4OZYSCtZdOH
         g7dQ==
X-Gm-Message-State: AOAM532nKpL/2Xpkc6OPoTArdgRNJDEwcc90NN6Q1xKLtf5vgB+L3wDd
        DMo11KBL1gO3v+Q91CnkCxo=
X-Google-Smtp-Source: ABdhPJypG74sbldIwQxznBB4bRlIRb9/ERNH89tkvD54i04LP/wkOatCmHvCWQo9kTbx0UYyVzzixw==
X-Received: by 2002:a92:9a58:: with SMTP id t85mr1262101ili.172.1609877778498;
        Tue, 05 Jan 2021 12:16:18 -0800 (PST)
Received: from localhost.localdomain ([2601:647:5400:13e::104a])
        by smtp.googlemail.com with ESMTPSA id 1sm194248ilv.37.2021.01.05.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 12:16:17 -0800 (PST)
From:   dpayne <darby.payne@gmail.com>
To:     ja@ssi.bg
Cc:     darby.payne@gmail.com, horms@verge.net.au,
        lvs-devel@vger.kernel.org
Subject: [PATCH v5] ipvs: add weighted random twos choice algorithm
Date:   Tue,  5 Jan 2021 12:14:58 -0800
Message-Id: <20210105201458.4082596-1-darby.payne@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <de283f1a-7adf-7633-d877-d8601dd4d7@ssi.bg>
References: <de283f1a-7adf-7633-d877-d8601dd4d7@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Adds the random twos choice load-balancing algorithm. The algorithm will
pick two random servers based on weights. Then select the server with
the least amount of connections normalized by weight. The algorithm
avoids the "herd behavior" problem. The algorithm comes from a paper
by Michael Mitzenmacher available here
http://www.eecs.harvard.edu/~michaelm/NEWWORK/postscripts/twosurvey.pdf

Signed-off-by: dpayne <darby.payne@gmail.com>
---
 net/netfilter/ipvs/Kconfig      |  11 +++
 net/netfilter/ipvs/Makefile     |   1 +
 net/netfilter/ipvs/ip_vs_twos.c | 139 ++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
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
index 000000000000..7e2706def44b
--- /dev/null
+++ b/net/netfilter/ipvs/ip_vs_twos.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* IPVS:        Power of Twos Choice Scheduling module
+ *
+ * Authors:     Darby Payne <darby.payne@applovin.com>
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

