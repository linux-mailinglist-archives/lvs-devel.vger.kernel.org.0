Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D96279D62
	for <lists+lvs-devel@lfdr.de>; Sun, 27 Sep 2020 03:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgI0B4n (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 26 Sep 2020 21:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgI0B4n (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 26 Sep 2020 21:56:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F92C0613CE
        for <lvs-devel@vger.kernel.org>; Sat, 26 Sep 2020 18:56:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a22so5480398ljp.13
        for <lvs-devel@vger.kernel.org>; Sat, 26 Sep 2020 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RtgKOaz92FMArlu9ktFCct50Xb7g19eVCcstF2JFt2E=;
        b=GjyfJvpfymL/OOsYFWNfw6LJCkoDb2IxyKL6/sNJa6s+FetrP0/KiW/0NyM/gjeL+d
         72/YsrGgaFQaQVzQzbD6C7+Tn3hP2MCo/brvzhA+LbVnaezdJujPUGbWTCnD7xrJdjjZ
         Zwm2lCsbtkaJYTmKzOGF8vEvAbq8BxhsnYU0LRRjLWLs3WzXdAhy2STdrZa5NXFiMBxD
         QHdUyhJjTsxTMwooxzrri+X97Q1ZzMK5cEwiPWxN+5VVKXoU+isjeYLcMksDkSRGtv8K
         4cy2B+kD1VAWzVezJzqlKs33zdYQ+8twj1qHZt9oIYl9e0v6SISwArBGGYp7XjEblZVm
         U2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RtgKOaz92FMArlu9ktFCct50Xb7g19eVCcstF2JFt2E=;
        b=eX4beRx2ewgIbu3zMm3fHlfVYuKGGpKBB8TVdWe47qaW2N5l1D5nBWfut26x5IqgOw
         sRr4C0k/QXUo4whT5Zlimji7m/l2BCGwXLuYQACcgJ5aapG+3bVwVbP/dGmxBC18Z6Vb
         iZG8le5GmdADa4Mn8Cq/uWHlf3t5NrHIcHcEj/ZOaKSN8lr60rqbAjX6Rv6OddT7N+tk
         NY0gX8dMjsFLfYdKwpDOgso/V97AbaM74xgkz8MumNvPrhWELQ8wn8ACDtYkkbeHUpBJ
         BD28+lHtc2SVj149KsrvIeD+BAL5j6iee+vuVHA9fnOJz6o+Zebw99Xonql1ZKB9os1U
         +vfw==
X-Gm-Message-State: AOAM532KnyP4H9rd/qA1CxEVhKwsSJr11GUFVUbLexyw+yL9l5j0hs99
        /pk10tllQEQRMgwG3o1dT6MLVFko0ooQkfUVNr48YQ1p
X-Google-Smtp-Source: ABdhPJzJrYu0XoiOLIbpUKTZ41nkobGHlKFIQSNTaCV/lgITOB1UWcNPzRE0+g8DC5NlTzJ8a9Ixnh6yKOIK6cJLRwY=
X-Received: by 2002:a2e:6f0d:: with SMTP id k13mr3045538ljc.250.1601171800750;
 Sat, 26 Sep 2020 18:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPaK2r8cTOq5rEKZezse+wF0f9NierUabqcr31b46wJx43werQ@mail.gmail.com>
In-Reply-To: <CAPaK2r8cTOq5rEKZezse+wF0f9NierUabqcr31b46wJx43werQ@mail.gmail.com>
From:   yue longguang <yuelongguang@gmail.com>
Date:   Sun, 27 Sep 2020 09:56:29 +0800
Message-ID: <CAPaK2r9th06OeNvs-1jrOq8a_ayaNL+kNWPddUUJ2GAEEJnZ8A@mail.gmail.com>
Subject: Re: [PATCH v3] ipvs: adjust the debug info in function set_tcp_state
To:     horms@verge.net.au, Julian Anastasov <ja@ssi.bg>,
        wensong@linux-vs.org, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, David Miller <davem@davemloft.net>, kuba@kernel.org,
        lvs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi, could you all give me some feedback?
thanks

On Fri, Sep 25, 2020 at 8:09 PM yue longguang <yuelongguang@gmail.com> wrote:
>
> From: "longguang.yue" <yuelongguang@gmail.com>
>
>    outputting client,virtual,dst addresses info when tcp state changes,
>    which makes the connection debug more clear
>
> Signed-off-by: longguang.yue <yuelongguang@gmail.com>
> ---
> net/netfilter/ipvs/ip_vs_proto_tcp.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> index dc2e7da2742a..7da51390cea6 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> @@ -539,8 +539,8 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct
> ip_vs_conn *cp,
> if (new_state != cp->state) {
> struct ip_vs_dest *dest = cp->dest;
>
> - IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] %s:%d->"
> -       "%s:%d state: %s->%s conn->refcnt:%d\n",
> + IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] c:%s:%d v:%s:%d "
> +       "d:%s:%d state: %s->%s conn->refcnt:%d\n",
>       pd->pp->name,
>       ((state_off == TCP_DIR_OUTPUT) ?
>        "output " : "input "),
> @@ -548,10 +548,12 @@ set_tcp_state(struct ip_vs_proto_data *pd,
> struct ip_vs_conn *cp,
>       th->fin ? 'F' : '.',
>       th->ack ? 'A' : '.',
>       th->rst ? 'R' : '.',
> -       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
> -       ntohs(cp->dport),
>       IP_VS_DBG_ADDR(cp->af, &cp->caddr),
>       ntohs(cp->cport),
> +       IP_VS_DBG_ADDR(cp->af, &cp->vaddr),
> +       ntohs(cp->vport),
> +       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
> +       ntohs(cp->dport),
>       tcp_state_name(cp->state),
>       tcp_state_name(new_state),
>       refcount_read(&cp->refcnt));
> --
> 2.20.1 (Apple Git-117)
