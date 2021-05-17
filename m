Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E03382931
	for <lists+lvs-devel@lfdr.de>; Mon, 17 May 2021 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhEQKA4 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 17 May 2021 06:00:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhEQKAL (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 17 May 2021 06:00:11 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1V-0002Vf-W1
        for lvs-devel@vger.kernel.org; Mon, 17 May 2021 09:58:54 +0000
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso3592462edz.6
        for <lvs-devel@vger.kernel.org>; Mon, 17 May 2021 02:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oRK7fdxqXtvCqQanUPHi5PLCsvN+FRR/HxPoeVMmEY=;
        b=C/jzVTsnOm/aU/0eJTzgFkHpsTKLoTMVf5pXTayV6bxYGB9WfYHue4qdPU2kzeyxPC
         kgtrUd9ipMQLIRNGvzceRIyvPlkED0sxBazAaCCyx897DIMXbVn2sJMFlYzuvRvNMInu
         QART83HH1ffS3FrdamO6Pm24skJ31lUBIQDUTydSfB0b4MfWlrbiSnoIHtCVluP+kI18
         l+al6b9R+6Vf4zFrG5+kIYI7DcydvoGjUznjdednRuU8g29IP/4roe4m2u8MQDReZ3zb
         DgebVJFTuoBwKSZNUMce0o8QyAb9vrM7gplmblJJNdLt5Q2IyFjexn166aUjU/QM/XiQ
         Z63A==
X-Gm-Message-State: AOAM5338OqsQ2WwQxwCMq9cCrbOvzwmmMrItV9VU8NDrVtlauwf1uru/
        VeimqVC5Vd23p3kpE5/T9Vv1bLgKDG0UCx1kZ8nTKLALT3jqBhKZPs70P6OluEQfytcA8+46VWH
        TiS2NmyU7ga6vVcKR5Qnv5iBW9FE0dpaQBqPNSg==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr61739765ejg.110.1621245533767;
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCJLusPZINe2qdUxpYMFxA8UX6eqbTRbrwv6wXahFNW7BPlHqeGrQshe9NXPBEj1GGA8wlPA==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr61739755ejg.110.1621245533621;
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q26sm8475329ejc.3.2021.05.17.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] netfilter: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:50 +0200
Message-Id: <20210517095850.82083-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find net/netfilter -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 net/netfilter/Kconfig      | 2 +-
 net/netfilter/ipvs/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 56a2531a3402..172d74560632 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -816,7 +816,7 @@ config NETFILTER_XT_TARGET_CLASSIFY
 	  the priority of a packet. Some qdiscs can use this value for
 	  classification, among these are:
 
-  	  atm, cbq, dsmark, pfifo_fast, htb, prio
+	  atm, cbq, dsmark, pfifo_fast, htb, prio
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index d61886874940..271da8447b29 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -318,7 +318,7 @@ config IP_VS_MH_TAB_INDEX
 comment 'IPVS application helper'
 
 config	IP_VS_FTP
-  	tristate "FTP protocol helper"
+	tristate "FTP protocol helper"
 	depends on IP_VS_PROTO_TCP && NF_CONNTRACK && NF_NAT && \
 		NF_CONNTRACK_FTP
 	select IP_VS_NFCT
-- 
2.27.0

