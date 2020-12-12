Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD62D894A
	for <lists+lvs-devel@lfdr.de>; Sat, 12 Dec 2020 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407730AbgLLScG (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 12 Dec 2020 13:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407729AbgLLScE (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 12 Dec 2020 13:32:04 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1AC0613CF
        for <lvs-devel@vger.kernel.org>; Sat, 12 Dec 2020 10:31:23 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i18so12923357ioa.1
        for <lvs-devel@vger.kernel.org>; Sat, 12 Dec 2020 10:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftSM76pRDWLN6c2IFLiqQDMlSodGyATHB1NltkZbt84=;
        b=QO/geT7diYlU28coTC7EFRabjkhOMzYuswJ6CVLN8Sjt5szlAJTcMdXM3iGW6rnxzz
         q61hl6o3VdmNUmfwVEpbiWfBKYY0Vv7iObnL+8gEhfF5VvzsuSV1Ee2unEInHSUahSy5
         pn0DeLzzH9oOy8q/cMQKIF+1ORHf9/eKz5fgWyzq26MUA4yGJMxvfTb0DNgvhkFyYsZD
         7TlQaLXkf1XiYPra29kRo4ngNDQgBITtAocPTqW1lCerolJbRRonclVxKUPPAUII+HMy
         ItyO4j3aGMUOSt3Q7LC1BhuKvZfzouFIkNdn2s60MotZTH+jG7u6KpeKFSWETg/hj5P9
         FDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftSM76pRDWLN6c2IFLiqQDMlSodGyATHB1NltkZbt84=;
        b=oSi3hMyDqo0XFS0hbCKFfYO19mOBoEDA3xw0n7OodvRLR4YzwZkWwyoEG7lkvgeZ4z
         Lc7MiAmf2yIKYbgi6ANwRpo9PgnvSfX4B5Lxht6Pm07iqQw7zFbtBou9f1TNYAfE+SyC
         n5B+4SSVKu9Vxnd+aIPaAdsckD7lksWmz15actOoTEFVx6BEaHtRBOnrxN9efOVoboDt
         yxfPWRWlTr5F9MkXg0BPR9mw0m3l8KrlqTHPdy3if0qsBwkW6K6qivyWdZMHfNScF7yn
         RUKgg2xFEctsMj9wjBpfbQeurrN3crzn3apMkEFnsie1DMvzU7THLrkfZ6L2dt2UfBxs
         o0bA==
X-Gm-Message-State: AOAM531yYYDY89JnOd5ahTmjPJvRwLqkA1bqy2qYFLtsUx8yOflvqqEr
        QWBybvtN3/UYpuuEd5aG5plI5itwTBtf6Q4M
X-Google-Smtp-Source: ABdhPJy9zgVnkgxH0gjkQBj/9kuO118jpfvMxKYkdr20AHiVlAg9eDID9+FcCwo/tNGTK6xyjrD/yA==
X-Received: by 2002:a5e:820c:: with SMTP id l12mr18349787iom.50.1607797883052;
        Sat, 12 Dec 2020 10:31:23 -0800 (PST)
Received: from localhost.localdomain ([2601:647:5400:13e::1010])
        by smtp.googlemail.com with ESMTPSA id y21sm6500250iot.12.2020.12.12.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 10:31:22 -0800 (PST)
From:   dpayne <darby.payne@gmail.com>
To:     ja@ssi.bg
Cc:     darby.payne@gmail.com, horms@verge.net.au, wensong@linux-vs.org,
        lvs-devel@vger.kernel.org
Subject: [PATCH v2] ipvs: add weighted random twos choice algorithm
Date:   Sat, 12 Dec 2020 10:27:53 -0800
Message-Id: <20201212182753.565438-1-darby.payne@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <6f8810b9-e7a-9fd-d324-5d1c28ac2529@ssi.bg>
References: <6f8810b9-e7a-9fd-d324-5d1c28ac2529@ssi.bg>
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
Changes in v2:
 - Added references
 - Fixed uninitialized value
 - Fixed grammar mistake in Kconfig description
 - Fixed not needing to initialize weight
 - Fixed long indentation. I broke the suggested change into two
   continues to avoid the atomic_read call when not needed
---
 net/netfilter/ipvs/Kconfig      |  11 +++
 net/netfilter/ipvs/Makefile     |   1 +
 net/netfilter/ipvs/ip_vs_twos.c | 148 ++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
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
index 000000000000..5b729a51412b
--- /dev/null
+++ b/net/netfilter/ipvs/ip_vs_twos.c
@@ -0,0 +1,148 @@
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
+				overhead2, total_weight = 0, weight;
+
+	IP_VS_DBG(6, "%s(): Scheduling...\n", __func__);
+
+	/* Generate a random weight between [0,sum of all weights)
+	 */
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
+	/* Find the first weighted dest
+	 */
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

