Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666A29974D
	for <lists+lvs-devel@lfdr.de>; Mon, 26 Oct 2020 20:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgJZTsA (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 26 Oct 2020 15:48:00 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43600 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJZTr7 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 26 Oct 2020 15:47:59 -0400
Received: by mail-oi1-f177.google.com with SMTP id x203so6326854oia.10
        for <lvs-devel@vger.kernel.org>; Mon, 26 Oct 2020 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aUpIXWcge6Idt1Hrp2edKf6Gjxz9A/R87xsxAYGR+Ak=;
        b=P6VU55N5NHv1m2n3oDJ7t92/Gd0ZtnmXN4G11B+ta/a5ZDrV6WXW1SFIU5CTaIVBGL
         Uw9leeIdpOczYJsm7RMFdgWQKxwXhFrsc5RyxDTqm6FB2ZL5WESckT3LBBqlOLd8Mb4S
         EaNC1uBAhEYrWsg0Uv9C9ai2WZlof0MBIGbBF9Zot+YBaA84NenWFrFhCRZ9AV+8rXO2
         NZuLCCPzMo9gZYUasHJldc5RvpuwS5bV9N3a8zrAt4uH4RzdaxhtjshONcUCCUn3r55O
         LosWjIFhU21vocXyfRebEhMyxN4zeCurDFK3p6tU9GfSLEMPwpAYezmMsfQfglnkVel1
         zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aUpIXWcge6Idt1Hrp2edKf6Gjxz9A/R87xsxAYGR+Ak=;
        b=f4hNHIPZ3W4O3Me4ZUobG0sjpo85NYCy/MzxR+fGeYJSP0H1ahrwIw7H6pjPLWmhQP
         ukt8nQdmwTU6oYlL3GFKneo5+d7yznV3VHV7rhj5wqZoRABi2JUnASVOrw2X9Wd1D+CC
         I1+jVc5g52Tk3GJchUVI6rLedMqMczqJcWAec0dDz+PleIDHrnFubIgnYuJ9foaeLch0
         f7F9Uq61x7T/8Om2VWFTUpXpb3bCr65Bj5rnUvqRO6mEU/YC8wKtLEBY1Mhe8/8XqCMI
         Bjm4S0x9Sagdw8rg92iiOj+ZFb30K35QAvhgF5nmpGOENeNzLEelvmqxdb0vA/8yevbX
         TVng==
X-Gm-Message-State: AOAM531Ik4EifjbsbmPn7yUnzHwUHgQmwUFTCX+82zvG+kxn6NzZJ8gD
        H/6XqRxTX7X1zbBMNLNEB7E66FZ3kfTPFqUegS2U2iPP9O0=
X-Google-Smtp-Source: ABdhPJzqO6Wqa5DSTBx+uZGlOf/09w/ti6WDdrPVCne0ZMBQMIQ4uanD2vQiPpyt5YhUWAjrb5RrnwX28dmB7PXy4go=
X-Received: by 2002:aca:ac8f:: with SMTP id v137mr11489399oie.134.1603741677706;
 Mon, 26 Oct 2020 12:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA++F93g_WfKbVHLMUFYgQbR63o2-s8Ky_W9Z85qsFM77OaweEQ@mail.gmail.com>
 <68d574-d213-50-7617-f1d917625362@ssi.bg>
In-Reply-To: <68d574-d213-50-7617-f1d917625362@ssi.bg>
From:   =?UTF-8?Q?Cezar_S=C3=A1_Espinola?= <cezarsa@gmail.com>
Date:   Mon, 26 Oct 2020 16:47:46 -0300
Message-ID: <CA++F93huu-Q_J2X89ndYwCGWwETmOPsDDdgVdVeDHUMU5qRg6g@mail.gmail.com>
Subject: Re: Possibility of adding a new netlink command to dump everything
To:     Julian Anastasov <ja@ssi.bg>
Cc:     lvs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

> > 1. First of all is such a patch adding a new command something desirabl=
e and
> > could it possibly be merged or should I just drop it?
>
>         It depends on its complexity, are you changing
> the ipvsadm -S code or just the kernel part?

Thank you for the fast reply! Just the kernel part for now and some
crude standalone benchmarking code, although I intend to also change
the ipvsadm -S code to use this new cmd if available.

> > 2. I can see that besides the generic netlink interface there's also an=
other
> > interface based on getsockopt options, should the patch also add a new =
socket
> > option or is it okay for this new functionality to be exclusive to gene=
ric
> > netlink?
>
>         No, sockopt is old interface and it is not changed,
> it lacks IPv6 support, etc.

Great.

> > 3. Should this go forward, any advice on my next steps? Should I simply=
 send the
> > patch here?
>
>         You can post it with [PATCH RFC] tag, so that we
> can see how do you mix services and destinations in same
> packet. You can also add speed comparison after the --- line
> for more information.

I'll do that and we can discuss further then. Thanks a lot for your time!

Regards
--
Cezar S=C3=A1 Espinola
