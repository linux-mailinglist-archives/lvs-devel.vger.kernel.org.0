Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7A2D612A
	for <lists+lvs-devel@lfdr.de>; Thu, 10 Dec 2020 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392297AbgLJQGj (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 10 Dec 2020 11:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392298AbgLJQGa (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 10 Dec 2020 11:06:30 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF465C0611C5
        for <lvs-devel@vger.kernel.org>; Thu, 10 Dec 2020 08:05:55 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id p5so5757252ilm.12
        for <lvs-devel@vger.kernel.org>; Thu, 10 Dec 2020 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIlOhgg2+I1MetM1aGXMTnNlRLku7w1b5CCzv/1/Rs4=;
        b=S2XfpFezu8DQVDoAYqaGA/b0ADJpxh1BVQyViqDSEVEEqbRVFZMeItk+iNjpJI3tsp
         jXLUBW5umqwuYPiiLc02nZWgDBObf4Gfs6ECaVxvXSVgED42aAft0ziEV5O6aqWBz07w
         Yc2ne6HzVMX39s2GFu4PJpQTN+zQryMKGbsvB9eBtCZ8fhM9hjJ2vWZ/F8KjL80nLpGB
         MRF9vN8jdr7q9196mneiyXymb3ZL/R1Hf7cPu1W2R06L/EXCAlrr814c5UHkZik2GC6Z
         IDgxd8X/+9lWONL1sc7ouHtZdbyP6wVLgjktAy5Fh7FinlXtDFCrW2fIZVakMuBiJVd1
         6c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIlOhgg2+I1MetM1aGXMTnNlRLku7w1b5CCzv/1/Rs4=;
        b=I6ZF5csDoCeQlkriq4y9JtjOoYJscaH3p7oFGbq63x0rDTTibQSnYlu7gbXzCuDe8h
         CiWldBYDgZjSDjZun9DWIOJeediPznBNgILOVMHnLEqTGf58dY3uEOHbwFVtNnpYmdRB
         vusXDudOGBqWTsoORBs9eYCW4AI3OJB0cV7r/o89wcdSjpBe6DJ3sWspVCYSX8sb9HXE
         aT0Q+DsmtEvnZ49fZpRx5H71lZmf9S80WcKFZx3KtnzUf0xQvF7qySOTbAuRvLNBEMJd
         t+4zfFo1ZVyfbxNK62WZSFh7ck5aq0DYwLG9QCNV1MNu6h96sdiJw/zvpDgrcVGBg0nL
         S4pA==
X-Gm-Message-State: AOAM532CjndYn3V2Y3orD2CWYfY4UhnADntbTuBHMd40DeA28kW6VG/m
        Mx9eozCVQNtErZuZULKUZcY=
X-Google-Smtp-Source: ABdhPJyjsAmJQJPuCRQLO0Ebl0PYcsHJQK+C4E+kSEn5D0g4i7psNtKrxzQKKaE/k74ub8WdWiqhaw==
X-Received: by 2002:a92:d03:: with SMTP id 3mr10087342iln.197.1607616355002;
        Thu, 10 Dec 2020 08:05:55 -0800 (PST)
Received: from localhost.localdomain ([2601:647:5400:13e::100a])
        by smtp.googlemail.com with ESMTPSA id 1sm3682610ilv.37.2020.12.10.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:05:54 -0800 (PST)
From:   dpayne <darby.payne@gmail.com>
To:     wensong@linux-vs.org
Cc:     darby.payne@gmail.com, horms@verge.net.au,
        lvs-devel@vger.kernel.org
Subject: [PATCH] ipvs: add weighted random twos choice algorithm
Date:   Thu, 10 Dec 2020 08:05:06 -0800
Message-Id: <20201210160506.4010615-1-darby.payne@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Adds the random twos choice load-balancing algorithm. The algorithm will
pick two random servers based on weights. Then select the server with
the least amount of connections normalized by weight. The algorithm
avoids the "herd behavior" problem.

Signed-off-by: dpayne <darby.payne@gmail.com>
---
 net/netfilter/ipvs/Kconfig      |  11 +++
 net/netfilter/ipvs/Makefile     |   1 +
 net/netfilter/ipvs/ip_vs_twos.c | 140 ++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 net/netfilter/ipvs/ip_vs_twos.c

diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index eb0e329f9b8d..e7c4e85d1725 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -271,6 +271,17 @@ config	IP_VS_NQ
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
+config	IP_VS_TWOS
+	tristate "weighted random twos choice least-connection scheduling"
+	help
+	  The weighted random twos choice least-connection scheduling
+	  algorithm picks two random real servers directs network
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
index 000000000000..cbb05032bba7
--- /dev/null
+++ b/net/netfilter/ipvs/ip_vs_twos.c
@@ -0,0 +1,140 @@
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
+ *    Michael Mitzenmacher
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
+ */
+static struct ip_vs_dest *ip_vs_twos_schedule(struct ip_vs_service *svc,
+					      const struct sk_buff *skb,
+					      struct ip_vs_iphdr *iph)
+{
+	struct ip_vs_dest *dest, *choice1 = NULL, *choice2 = NULL;
+	int rweight1, rweight2, weight1 = -1, weight2 = -1, overhead1,
+				overhead2, total_weight = 0, weight = 0;
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
+		if (!(dest->flags & IP_VS_DEST_F_OVERLOAD)) {
+			weight = atomic_read(&dest->weight);
+			if (weight > 0) {
+				rweight1 -= weight;
+				rweight2 -= weight;
+
+				if (rweight1 <= 0 && weight1 == -1) {
+					choice1 = dest;
+					weight1 = weight;
+					overhead1 =
+						ip_vs_dest_conn_overhead(dest);
+				}
+
+				if (rweight2 <= 0 && weight2 == -1) {
+					choice2 = dest;
+					weight2 = weight;
+					overhead2 =
+						ip_vs_dest_conn_overhead(dest);
+				}
+
+				if (weight1 != -1 && weight2 != -1)
+					goto nextstage;
+			}
+		}
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

