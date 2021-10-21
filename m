Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15C435EC3
	for <lists+lvs-devel@lfdr.de>; Thu, 21 Oct 2021 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJUKN7 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 21 Oct 2021 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKN6 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 21 Oct 2021 06:13:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16806C06161C
        for <lvs-devel@vger.kernel.org>; Thu, 21 Oct 2021 03:11:43 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l7so11933593iln.8
        for <lvs-devel@vger.kernel.org>; Thu, 21 Oct 2021 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deezer.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qyETETH8qxe1pum9Mp4lb8a0gtzcuxcN31wfDDAog5U=;
        b=EYVf0YZVbEfaGux/nX39CFi9cFE5UZgPDbDa265uIGFoIPtNiXlen8erJq5xGEzx4+
         BpCQquAQ+RqS6HhcKIfKK6/QQ8PbjmaYR9bDEKr7Bi8aroXt4Q0qzZFq2XDeKoKSDdFI
         JVXVUGd+CwqzQY+L1Lo7BIfbE4kDyNhJipLvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=qyETETH8qxe1pum9Mp4lb8a0gtzcuxcN31wfDDAog5U=;
        b=N+aat3wfNgwF0C+yVwOIG+xy3lJAjqJBqTrddBBBAd2/fI58hgiStyjHGOgu2xzo9I
         aEUZYwwTd2M8lPc8kMXZZ5Unf7qpFWrKUprBwtXX+myaCSGiaGfvziqTWmBabw1kM6sK
         u2uMYbbHGPM4Lnkpo9gkbclB68QtEV5ElExUJWjVZOO8L70yIsDavHBLPvFPywDMGjtN
         vtsZoSMIqz0U6van2UTDv6GkcBr8xSZrQ2Z3BPG/ioFEo1f2BBIOIEc98DRC20nTOKM7
         KIkFgWu1xlSCrsOQADYI8i8rNjwRyz34Tyl2AE1gGVGsH4kGRvjgGHLbFfw1XRS4g1Ch
         NIJQ==
X-Gm-Message-State: AOAM5302la3kbWcqxLaoyZkbzS/1HA0eZQiv/uCrTAHgNj4ULXgHNyPC
        wmypwBbmao9LcoB6dS2sLws1Rz1YiKWH0wCuHee7oFInM4Oc2Q==
X-Google-Smtp-Source: ABdhPJxnGx+Y52ya4+M+roteudW819h+YbwFmVc26o5Ixkpys7qlm5+F5xEW6YIyTz4IAe7HSUlWgjTb5DJmJ2mQqwo=
X-Received: by 2002:a05:6e02:1a85:: with SMTP id k5mr2952980ilv.39.1634811102126;
 Thu, 21 Oct 2021 03:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAP962rShHbVtXNONwRWda6xAZ_L8kVWTSNZc_bC=gCetUMpNHw@mail.gmail.com>
In-Reply-To: <CAP962rShHbVtXNONwRWda6xAZ_L8kVWTSNZc_bC=gCetUMpNHw@mail.gmail.com>
From:   Alexis Vachette <avachette@deezer.com>
Date:   Thu, 21 Oct 2021 12:11:06 +0200
Message-ID: <CAP962rQ6f_ni_rqO08uQu8M-fvquXAhxgWUUbco8M0F3NYp62Q@mail.gmail.com>
Subject: Re: netfilter: ipvs: using maglev scheduler algorithm
To:     lvs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Some mistake are printed on the working example, here is the fixed one:

root@dev-lvstest-01 ~ =E2=9D=B1 tail -f /var/log/kern.20211021 | grep "172.=
16.42.170"
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322832] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322834] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322836] IPVS: lookup
service: fwm 0 TCP 172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322851] IPVS: Bind-dest
TCP c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.16.42.168:2222 fwd:R
s:53052 conn->flags:183 conn->refcnt:1 dest->refcnt:2048
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322855] IPVS: Schedule
fwd:R c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.16.42.168:2222
conn->flags:1C3 conn->refcnt:2
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322858] IPVS: TCP input
[S...] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.16.42.168:2222
state: NONE->SYN_RECV conn->refcnt:2
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324470] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324473] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324475] IPVS: TCP input
[..A.] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.16.42.168:2222
state: SYN_RECV->ESTABLISHED conn->refcnt:2
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324998] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.325002] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.334977] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.334979] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.336872] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.336875] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.342537] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.342539] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.345179] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.345181] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.350319] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.350322] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.374611] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.374614] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.419041] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.419045] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421754] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421756] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421763] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421764] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432266] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432268] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432289] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432291] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.434754] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.434757] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.041063] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.041065] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053383] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053385] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053398] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053400] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.706476] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.706479] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708135] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708137] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708208] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708210] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711111] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711115] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711130] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711133] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711155] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711156] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711183] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711184] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711192] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711194] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711202] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711203] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711219] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711220] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711228] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711230] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711237] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711239] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711255] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711256] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712512] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712515] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712526] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712528] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 136.098170] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:34 dev-lvstest-01 kernel: [ 136.098173] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.563477] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.563482] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566119] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566123] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566150] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566152] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566215] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566218] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566238] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566240] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566252] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566254] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566255] IPVS: TCP input
[.FA.] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.16.42.168:2222
state: ESTABLISHED->FIN_WAIT conn->refcnt:2
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.570330] IPVS: lookup/out
TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.570335] IPVS: lookup/in
TCP 10.0.0.6:49677->172.16.42.170:2222 hit

Regards,
Alexis Vachette.

On Thu, 21 Oct 2021 at 11:54, Alexis Vachette <avachette@deezer.com> wrote:
>
> Hello everyone,
>
> If this is not the correct list to address my issue feel free to tell me.
>
> We are heavily using Netfilter/IPVS with maglev scheduler algorithm
> and it's working great on most use case.
>
> The only case when we face issue is when inhibit_on_failure option is ena=
bled.
>
> Here is our setup:
>
> - 2 LVS director in active/passive mode
> - 2 backend node
>
> Exposed service is SSH using port 2222.
>
> You can find below the LVS state when issue is occurring:
>
> root@dev-lvstest-01 ~ =E2=9D=B1 ipvsadm -L -n
> IP Virtual Server version 1.2.1 (size=3D1048576)
> Prot LocalAddress:Port Scheduler Flags
>   -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
> TCP  172.16.42.170:2222 mh (mh-port)
>   -> 172.16.42.168:2222            Route   100    0          0
>   -> 172.16.42.169:2222            Route   0      0          0
>
> Here is a working example output:
>
> root@dev-lvstest-01 ~ =E2=9D=B1 tail -f /var/log/kern.20211021 | grep "17=
2.16.42.170"
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322832] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322834] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322836] IPVS: lookup
> service: fwm 0 TCP 172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322851] IPVS: Bind-dest
> TCP c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.31.0.168:2222 fwd:R
> s:53052 conn->flags:183 conn->refcnt:1 dest->refcnt:2048
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322855] IPVS: Schedule
> fwd:R c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.31.0.168:2222
> conn->flags:1C3 conn->refcnt:2
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.322858] IPVS: TCP input
> [S...] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.31.0.168:2222
> state: NONE->SYN_RECV conn->refcnt:2
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324470] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324473] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324475] IPVS: TCP input
> [..A.] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.31.0.168:2222
> state: SYN_RECV->ESTABLISHED conn->refcnt:2
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.324998] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.325002] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.334977] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.334979] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.336872] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.336875] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.342537] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.342539] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.345179] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.345181] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.350319] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.350322] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.374611] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.374614] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.419041] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.419045] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421754] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421756] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421763] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.421764] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432266] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432268] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432289] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.432291] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.434754] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:32 dev-lvstest-01 kernel: [ 134.434757] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.041063] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.041065] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053383] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053385] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053398] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:33 dev-lvstest-01 kernel: [ 135.053400] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.706476] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.706479] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708135] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708137] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708208] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.708210] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711111] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711115] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711130] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711133] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711155] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711156] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711183] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711184] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711192] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711194] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711202] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711203] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711219] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711220] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711228] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711230] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711237] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711239] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711255] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.711256] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712512] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712515] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712526] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 135.712528] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 136.098170] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:34 dev-lvstest-01 kernel: [ 136.098173] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.563477] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.563482] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566119] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566123] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566150] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566152] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566215] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566218] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566238] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566240] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566252] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566254] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.566255] IPVS: TCP input
> [.FA.] c:10.0.0.6:49677 v:172.16.42.170:2222 d:172.31.0.168:2222
> state: ESTABLISHED->FIN_WAIT conn->refcnt:2
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.570330] IPVS: lookup/out
> TCP 10.0.0.6:49677->172.16.42.170:2222 not hit
> Oct 21 09:18:38 dev-lvstest-01 kernel: [ 139.570335] IPVS: lookup/in
> TCP 10.0.0.6:49677->172.16.42.170:2222 hit
>
> Here is the output when we face the issue described above:
>
> root@dev-lvstest-01 ~ =E2=98=A0 =E2=9D=B1 tail -f /var/log/kern.20211021 =
| grep "172.16.42.170"
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590627] IPVS: lookup/out
> TCP 10.0.0.6:49673->172.16.42.170:2222 not hit
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590630] IPVS: lookup/in
> TCP 10.0.0.6:49673->172.16.42.170:2222 not hit
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590633] IPVS: lookup
> service: fwm 0 TCP 172.16.42.170:2222 hit
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590637] IPVS: mh: TCP
> 172.16.42.170:2222 - no destination available
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.593020] IPVS: lookup/out
> TCP 172.16.42.170:2222->10.0.0.6:49673 not hit
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.593022] IPVS: lookup/in
> TCP 172.16.42.170:2222->10.0.0.6:49673 not hit
>
> I'm wondering if in some case the IPVS stack is using the node with
> inhibit_on_failure aka weight 0.
>
> I'm available to do more testing or anything else that can help
> troubleshoot this specific issue.
>
> Regards,
> Alexis Vachette.
