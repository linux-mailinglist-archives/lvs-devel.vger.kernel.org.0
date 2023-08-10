Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F04777B9B
	for <lists+lvs-devel@lfdr.de>; Thu, 10 Aug 2023 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjHJPGM (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 10 Aug 2023 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjHJPGI (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 10 Aug 2023 11:06:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B12698;
        Thu, 10 Aug 2023 08:06:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76754b9eac0so73074585a.0;
        Thu, 10 Aug 2023 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691679964; x=1692284764;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcINWyJSy8FttTW3PogPL++09l+HfsTCOWsOuolO/bE=;
        b=KyIlz0OeO6bMm1ooGIrzCXWAgefelU5mc6aRrLiEWtXG1HD2SvOhso0K0vqfzIAkJ4
         mSgx4E7yHLk9vJkGD+opdVHi5uksB8nWwBYacPtUTK7uGWp0OBnc1SrPtceSQCC+LqyH
         ZG2ACq3+klOjJZNzun7K3inI6PlIPhrYj46tcUGwcBGhYqi3xMgrzOOHLtOkpWN985rv
         IglUYR/JZ5MNf4zOIk83SldvSBJeUW/UWYON0mP6W4GK0BfpyR4tRlcC/jMb6L5Vslzy
         sXKsnxzWAVsKbYd6Iv1rp3x/VBS+S3nMDSi3Ev2os3OOqec5vdBDu6RX9Gw2IRvJ9yAz
         imhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691679964; x=1692284764;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcINWyJSy8FttTW3PogPL++09l+HfsTCOWsOuolO/bE=;
        b=IfSumbRYslWpeuqWCmymc8P9C5qGym3vN11Ls1q9+QArgsYFcu1ib3Om4aHn9b2F0o
         v5BgNgGEW5wVptC4NOgqUvFtdIy66QvX8gdl7xoJ+HB9c0kwKZPm0CB/LqWcsadFIO3q
         jnPvTqo0dZH1tpXoACDbN7eCFc7mt9Up7OB1XLpQDRETMlFixXmMw5Eewurc84vjUpD7
         KEqWUm2yCTxKXPbPpiscXmiWzNahGCehclov3BPuosICOmyER4tJqpKCDjJukG2R0LUg
         OhvJNzq27J6xmARGz8H3FLjgLfYMsiiiNOUS/ccx1kYjwfquiJa4HANFPHk63sbFoPhf
         7udg==
X-Gm-Message-State: AOJu0YylsgvUWwP0oX9o68ACE0HQeL9YpxkZIh+umjw4YeNqL0DwjMaP
        Y91EosORXCwsD76i8O+e1RcN/ZR7PHapc7uI
X-Google-Smtp-Source: AGHT+IGbjOCWB+JOQozPXLQT3oo9A25bfdng+7udbcmtxZuyegLFzAjZAJnPYoK9r5nGUjxwTaPWLw==
X-Received: by 2002:a05:620a:1707:b0:76d:1373:5942 with SMTP id az7-20020a05620a170700b0076d13735942mr3147276qkb.0.1691679963670;
        Thu, 10 Aug 2023 08:06:03 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id i10-20020a37c20a000000b0076768dfe53esm536804qkm.105.2023.08.10.08.06.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2023 08:06:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Race over table->data in proc_do_sync_threshold()
From:   Sishuai Gong <sishuai.system@gmail.com>
In-Reply-To: <b4854287-cb97-27fb-053f-e52179c05e97@ssi.bg>
Date:   Thu, 10 Aug 2023 11:05:52 -0400
Cc:     horms@verge.net.au,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D17F8D2-BF68-4BA4-8590-7DE1E71872A6@gmail.com>
References: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
 <b4854287-cb97-27fb-053f-e52179c05e97@ssi.bg>
To:     Julian Anastasov <ja@ssi.bg>
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

Hello,

I am not familiar with the code but I would like to give it a try :).

It seems to me that replacing the second memcpy with WRITE_ONCE()=20
is not necessary as long as we still hold the lock. Otherwise is this =
close
to what you suggest?

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c =
b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..b4e22e30b896 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1876,6 +1876,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
                       void *buffer, size_t *lenp, loff_t *ppos)
 {
+      struct netns_ipvs *ipvs =3D table->extra2;
        int *valp =3D table->data;
        int val[2];
        int rc;
@@ -1885,6 +1886,7 @@ proc_do_sync_threshold(struct ctl_table *table, =
int write,
                .mode =3D table->mode,
        };

+      mutex_lock(&ipvs->sync_mutex);
        memcpy(val, valp, sizeof(val));
        rc =3D proc_dointvec(&tmp, write, buffer, lenp, ppos);
        if (write) {
@@ -1894,6 +1896,7 @@ proc_do_sync_threshold(struct ctl_table *table, =
int write,
                else
                        memcpy(valp, val, sizeof(val));
        }
+      mutex_unlock(&ipvs->sync_mutex);
        return rc;
 }

@@ -4321,6 +4324,7 @@ static int __net_init =
ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
        ipvs->sysctl_sync_threshold[0] =3D DEFAULT_SYNC_THRESHOLD;
        ipvs->sysctl_sync_threshold[1] =3D DEFAULT_SYNC_PERIOD;
        tbl[idx].data =3D &ipvs->sysctl_sync_threshold;
+      tbl[idx].extra2 =3D ipvs;
        tbl[idx++].maxlen =3D sizeof(ipvs->sysctl_sync_threshold);
        ipvs->sysctl_sync_refresh_period =3D =
DEFAULT_SYNC_REFRESH_PERIOD;
        tbl[idx++].data =3D &ipvs->sysctl_sync_refresh_period;

> On Aug 10, 2023, at 2:20 AM, Julian Anastasov <ja@ssi.bg> wrote:
>=20
>=20
> Hello,
>=20
> On Wed, 9 Aug 2023, Sishuai Gong wrote:
>=20
>> Hi,
>>=20
>> We observed races over (struct ctl_table *) table->data when two =
threads
>> are running proc_do_sync_threshold() in parallel, as shown below:
>>=20
>> Thread-1 Thread-2
>> memcpy(val, valp, sizeof(val)); memcpy(valp, val, sizeof(val));
>>=20
>> This race probably would mess up table->data. Is it better to add a =
lock?
>=20
> We can put mutex_lock(&ipvs->sync_mutex) before the first
> memcpy and to use two WRITE_ONCE instead of the second memcpy. But
> this requires extra2 =3D ipvs in ip_vs_control_net_init_sysctl():
>=20
> tbl[idx].data =3D &ipvs->sysctl_sync_threshold;
> + tbl[idx].extra2 =3D ipvs;
>=20
> Will you provide patch?
>=20
> Regards
>=20
> --
> Julian Anastasov <ja@ssi.bg>


