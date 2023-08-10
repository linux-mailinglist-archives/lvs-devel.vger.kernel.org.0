Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3745778110
	for <lists+lvs-devel@lfdr.de>; Thu, 10 Aug 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHJTM6 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 10 Aug 2023 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjHJTM5 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 10 Aug 2023 15:12:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C662212B;
        Thu, 10 Aug 2023 12:12:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-790b080f2a0so41764739f.3;
        Thu, 10 Aug 2023 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691694774; x=1692299574;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWkaYMWSb/KD5Br6avTVtAWU2rBiWnpQY//6EhOGYR0=;
        b=OmdzBnQds3G8UGSSvoHalQ1f326gF+qt2Z6Pe5mPG84d8YX+Z0SddxrpQzjpCKh3OR
         nn9Cf+CRLj625gI9Ny8NQKE/giIety39NbdXCK12NcdVnbbyMAgLrJa3+9VSI7uZFL3g
         DXu+wUZneLWlF3NnAxZSQIA5ryhPowjGiFKE0khyrf9tP8uNaE1GdiRXXO8FdQGlZ2d5
         ObNKa+VN+R1yhUrkh8A1fJ8I67tCmRMxwcTQ5mrMP9WVKT8qijt/PDi1EUs5UeFbjI09
         t4s+nRToXnOWxUE8HkCTyuwLBVKylRtzJPzVWtP2a4nDaa1cdhPLzTbFdnBptiz6zat5
         pU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694774; x=1692299574;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWkaYMWSb/KD5Br6avTVtAWU2rBiWnpQY//6EhOGYR0=;
        b=jSi6xBxK/CHFFI5tDzKIaOavl3PuPEk1C1wTCrubdfRbCpvlv0hheVmd9PMDXQxRxp
         /kfaPd/OisR54ilkm0y1DDtFMNleE4gG7KTnf5cU/A8aFtuYZxh6srrKD2Od5Sg9CkVF
         8G2BPF7NdQF8rAT1z0QlZNz2TXvfJ2UTv6x7w8BnZxg3SNpmmPiEFqgZyVtIat9g+zqe
         QPbRQzZi0ADT9drIzxagdOqGC5ZubV8JjspSt93BMpmy7hZCnE1IsrN78Sns8HMrt1YO
         IvUlLCaqQMzhYSqGuJ/GpqHENu5Z5zzM4AGUfBZIskFHni+6k0Nlbv/XLaZJ1rLEQsPA
         6vRw==
X-Gm-Message-State: AOJu0YxqaXjGHTXOkwrEqC/bwzW54zEJtQqlA57Ss8+ygRN6QTcLVdWv
        5ATFHPnt2VWsslDcl4/iglh9SUgCbgS01AoU
X-Google-Smtp-Source: AGHT+IEVdnWlZR/UWEDU4/EnOE+PmrgVxuS8X0ZvKk8aYT56pDdvfBZGRyHq8yJ5LJxykv0QarItBw==
X-Received: by 2002:a05:6602:3348:b0:783:4bc6:636e with SMTP id c8-20020a056602334800b007834bc6636emr4143866ioz.21.1691694774603;
        Thu, 10 Aug 2023 12:12:54 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id h18-20020a0566380f1200b0042b3f0c94d9sm593579jas.107.2023.08.10.12.12.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2023 12:12:54 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold
Message-Id: <B556FD7B-3190-4C8F-BA83-FC5C147FEAE1@gmail.com>
Date:   Thu, 10 Aug 2023 15:12:42 -0400
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org
To:     ja@ssi.bg, horms@verge.net.au
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

When two threads run proc_do_sync_threshold() in parallel,
data races could happen between the two memcpy():

Thread-1			Thread-2
memcpy(val, valp, sizeof(val));
				memcpy(valp, val, sizeof(val));

This race might mess up the (struct ctl_table *) table->data,
so we add a mutex lock to serilize them, as discussed in [1].

[1] =
https://archive.linuxvirtualserver.org/html/lvs-devel/2023-08/msg00031.htm=
l

Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c =
b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..4bb0d90eca1c 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1876,6 +1876,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs =3D table->extra2;
 	int *valp =3D table->data;
 	int val[2];
 	int rc;
@@ -1885,6 +1886,7 @@ proc_do_sync_threshold(struct ctl_table *table, =
int write,
 		.mode =3D table->mode,
 	};
=20
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc =3D proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1894,6 +1896,7 @@ proc_do_sync_threshold(struct ctl_table *table, =
int write,
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
=20
@@ -4321,6 +4324,7 @@ static int __net_init =
ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] =3D DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] =3D DEFAULT_SYNC_PERIOD;
 	tbl[idx].data =3D &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 =3D ipvs;
 	tbl[idx++].maxlen =3D sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period =3D =
DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data =3D &ipvs->sysctl_sync_refresh_period;
--=20
2.39.2 (Apple Git-143)

