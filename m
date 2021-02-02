Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D459530C2B9
	for <lists+lvs-devel@lfdr.de>; Tue,  2 Feb 2021 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhBBO6Y (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 2 Feb 2021 09:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhBBO6A (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 2 Feb 2021 09:58:00 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59CC061573
        for <lvs-devel@vger.kernel.org>; Tue,  2 Feb 2021 06:57:20 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p15so18596223ilq.8
        for <lvs-devel@vger.kernel.org>; Tue, 02 Feb 2021 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pSWchO0DJsey7S4ccftOYU9IqSpIddUZ0NEQ4JfYbkI=;
        b=nJ1ShaVKCsHxZx01uF61qyG31gHmhGVjrrV6uP9bW+zJwowf6M4VHULyDy30dKA08J
         aTkufV+ts5lwAcQRHmJgBnCq+ne0+hrtvzuGSRmqgsqTsXfDPKwzF8yaoGoZhIbSBB3u
         PWu7BGXMf53G/Ssf6fy7z0haENutZ28wzhnfjEpFxNnG2heAuYiDAhHtsOAGyYbEpKKg
         6dYIR+en+rIwTGktb+NjPqBkoBMlqF837SkbFlfUDWXX8VghYkyPCDc/wgOXTAU0WzLI
         19JF9T0gb+88iFQJaX3a1RAErxvaZPMmXK1y5mGrtDsmb4XTo/Tq2vLJNkQjoaU/w1YC
         jxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pSWchO0DJsey7S4ccftOYU9IqSpIddUZ0NEQ4JfYbkI=;
        b=uAYqhcexGJPJcxb18Or5fAzPJgelPINMa8J/tHCN958hp9/yLOx4G1ZJaSITcgDCaq
         Zzjd8GqeGDk5Xn8LgrG99OsuVzi7au+XKyDGo8ZOUoDqiNXgXVfybiA3UWzG07wSc972
         LO6rS3bVlhZdTHTMijI642+Phqm8eKyfDtljgS6w1Toaw5wFc2Hv6vzvXwmUSVBZ2qKw
         F9gP61oow2hXb64VACv1Fh4C5GpOdY813XaMP8C1IAiBdrz40+y0npFJ4rl7MskSO/yZ
         cK2u37U5YMeV35frs9/XjzH+BcO8dbhIctHYp6RPuZgOI6XsuBSnmP5LpohUfJZ2dM9R
         75DA==
X-Gm-Message-State: AOAM5316uzG94Owbmn5w4KKS34ncAHDKKFxXKZ8A0031lOrQr+idjAF7
        Y4xGcYm39nRX5ctKkJE/SPrb09ZD/UGUaSAFTmS/qQ==
X-Google-Smtp-Source: ABdhPJyXuydOC2WSUTfYLBzJUg4fP8lVe9sZD7IomEQVb9j/He2UeZGUy39u121q1slOGD9FH7dIQqTqslU9rFwDJxU=
X-Received: by 2002:a05:6e02:1251:: with SMTP id j17mr4153271ilq.216.1612277839358;
 Tue, 02 Feb 2021 06:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20210202135544.3262383-1-leon@kernel.org> <20210202135544.3262383-4-leon@kernel.org>
In-Reply-To: <20210202135544.3262383-4-leon@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Feb 2021 15:57:07 +0100
Message-ID: <CANn89iLeC8YLt2Spq4P+JA+XBf=GDjF4UT5N68-E08JdS5iPJA@mail.gmail.com>
Subject: Re: [PATCH net 3/4] net/core: move ipv6 gro function declarations to net/ipv6
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Leon Romanovsky <leonro@nvidia.com>, coreteam@netfilter.org,
        Florian Westphal <fw@strlen.de>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
        LKML <linux-kernel@vger.kernel.org>, lvs-devel@vger.kernel.org,
        Matteo Croce <mcroce@redhat.com>,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Feb 2, 2021 at 2:56 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Fir the following compilation warnings:
>  1031 | INDIRECT_CALLABLE_SCOPE void udp_v6_early_demux(struct sk_buff *s=
kb)
>
> net/ipv6/ip6_offload.c:182:41: warning: no previous prototype for =E2=80=
=98ipv6_gro_receive=E2=80=99 [-Wmissing-prototypes]
>   182 | INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct l=
ist_head *head,
>       |                                         ^~~~~~~~~~~~~~~~
> net/ipv6/ip6_offload.c:320:29: warning: no previous prototype for =E2=80=
=98ipv6_gro_complete=E2=80=99 [-Wmissing-prototypes]
>   320 | INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb=
, int nhoff)
>       |                             ^~~~~~~~~~~~~~~~~
> net/ipv6/ip6_offload.c:182:41: warning: no previous prototype for =E2=80=
=98ipv6_gro_receive=E2=80=99 [-Wmissing-prototypes]
>   182 | INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct l=
ist_head *head,
>       |                                         ^~~~~~~~~~~~~~~~
> net/ipv6/ip6_offload.c:320:29: warning: no previous prototype for =E2=80=
=98ipv6_gro_complete=E2=80=99 [-Wmissing-prototypes]
>   320 | INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb=
, int nhoff)
>
> Fixes: aaa5d90b395a ("net: use indirect call wrappers at GRO network laye=
r")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/net/ipv6.h | 3 +++
>  net/core/dev.c     | 4 +---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index bd1f396cc9c7..68676e6bd4b1 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1265,4 +1265,7 @@ static inline void ip6_sock_set_recvpktinfo(struct =
sock *sk)
>         release_sock(sk);
>  }
>
> +INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_h=
ead *,
> +                                                          struct sk_buff=
 *));
> +INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int));


I think we should move this to a new include file.

These declarations were static, and had to be made public only because
of DIRECT call stuff,
which is an implementation detail.

Polluting include/net/ipv6.h seems not appropriate.


>  #endif /* _NET_IPV6_H */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c360bb5367e2..9a3d8768524b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -101,6 +101,7 @@
>  #include <net/dsa.h>
>  #include <net/dst.h>
>  #include <net/dst_metadata.h>
> +#include <net/ipv6.h>
>  #include <net/pkt_sched.h>
>  #include <net/pkt_cls.h>
>  #include <net/checksum.h>
> @@ -5743,7 +5744,6 @@ static void gro_normal_one(struct napi_struct *napi=
, struct sk_buff *skb)
>  }
>
>  INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int));

This is odd.

You move ipv6_gro_complete() but not inet_gro_complete()

I think we should be consistent.

> -INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int));
>  static int napi_gro_complete(struct napi_struct *napi, struct sk_buff *s=
kb)
>  {
>         struct packet_offload *ptype;
> @@ -5914,8 +5914,6 @@ static void gro_flush_oldest(struct napi_struct *na=
pi, struct list_head *head)
>
>  INDIRECT_CALLABLE_DECLARE(struct sk_buff *inet_gro_receive(struct list_h=
ead *,
>                                                            struct sk_buff=
 *));
> -INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_h=
ead *,
> -                                                          struct sk_buff=
 *));
>  static enum gro_result dev_gro_receive(struct napi_struct *napi, struct =
sk_buff *skb)
>  {
>         u32 hash =3D skb_get_hash_raw(skb) & (GRO_HASH_BUCKETS - 1);
> --
> 2.29.2
>
