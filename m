Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6E30C2D7
	for <lists+lvs-devel@lfdr.de>; Tue,  2 Feb 2021 16:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhBBPBO (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 2 Feb 2021 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhBBPAb (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 2 Feb 2021 10:00:31 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7FFC06174A
        for <lvs-devel@vger.kernel.org>; Tue,  2 Feb 2021 06:59:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y17so19311391ili.12
        for <lvs-devel@vger.kernel.org>; Tue, 02 Feb 2021 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKDGkdAH6hnP9LDv3OSd/rUwsKO2Hnsk5XLdUyUcTiA=;
        b=ZTxCza8R+qKMO5AULHOV6aqYudyKoCq1ldvPSstkJUe++vlUm6kwA0NSIjetUWvwOr
         hIFujVH9L2DNpz8drDLj/rv4R4u7/hc79IUf6YfKXT6oZXygc3b2U9r28iB6aIcPKEjU
         PILiKxbjOVyXEJwzZKbfzJfSBRqk0rHMk6V4WuCLHeuzEPuLwDeEHN/zVlefRb0vETXR
         hW8Uu2zuCqz/lC+Q8toxwcmf3CL8x+lwD9JbTbxDiMoadqfik9UFDkpZy21GupRbKIe+
         iNCoDj7W3qVQOFdsx9vI9u+OjevzmoDAl7NZHeeCimBgM3KOBcgEhJEXekuXfSA5WJvC
         EY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKDGkdAH6hnP9LDv3OSd/rUwsKO2Hnsk5XLdUyUcTiA=;
        b=Eb1x6i4r2fEPY8j/cjlDlTxIGkd7KDJ4R+HQ/b9T9BMt0vWGv6rgrH9QFvlZqzVyjR
         J0Rt9/spRQrTuyCRSL+3SWgEDSxuhzgdQFIQqFmRu3tUram3o4Ryh4S1g4bVKjJySoLa
         3uTlaWy0blBcy42M0HXh6bOX0Agl+ZnvBZp+UjBttckVRP0Q64VZldTtyAn9EBU47LjE
         NmgQd58D2pIYzLm5So74ZAl0XsLRYoyPTQVF8GKJ3cDzA9brpMMTvPOfoIXFQ4sPRxmP
         Zho2i2d/x7ewL1o7AxHCZBYRcTrHJxyQ4ZW2m1t/0VsSmwUi3QfSc+PeGE4iFximsq3E
         zu2g==
X-Gm-Message-State: AOAM5312gdTNtjSoknZ6qx4wbobPQIlJta4o1a3fH4nmsMkoOdy7mlLf
        xS6pIoIeLGridqGNlaqUmgv98OCnJX6ctpYHwVjk6w==
X-Google-Smtp-Source: ABdhPJwlgQNiDbpOt8/s7/PtFHiU3OsbyGtG9ixXUuXmc8Hbf0GbL6accU63MRrf6/lEOgiXrCFgbvKRS3t/0TSABik=
X-Received: by 2002:a05:6e02:1a89:: with SMTP id k9mr17243624ilv.68.1612277990062;
 Tue, 02 Feb 2021 06:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20210202135544.3262383-1-leon@kernel.org> <CANn89iL4jGbr_6rr11nsHxmdh7uz=kqXuMhRb0nakWO3rBZwsQ@mail.gmail.com>
 <20210202145724.GA3264866@unreal>
In-Reply-To: <20210202145724.GA3264866@unreal>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Feb 2021 15:59:38 +0100
Message-ID: <CANn89iJ1WYEfS-Pgzvec+54+3JQHCPSNdCfYaFkGYAEk3sGwmA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] Fix W=1 compilation warnings in net/* folder
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        coreteam@netfilter.org, Florian Westphal <fw@strlen.de>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
        LKML <linux-kernel@vger.kernel.org>, lvs-devel@vger.kernel.org,
        Matteo Croce <mcroce@redhat.com>,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Feb 2, 2021 at 3:57 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Feb 02, 2021 at 03:34:37PM +0100, Eric Dumazet wrote:
> > On Tue, Feb 2, 2021 at 2:55 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > Hi,
> > >
> > > This short series fixes W=1 compilation warnings which I experienced
> > > when tried to compile net/* folder.
> > >
> >
> > Ok, but we never had a strong requirement about W=1, so adding Fixes:
> > tag is adding
>
> I added because Jakub has checker that looks for Fixes lines in "net"
> patches.

Send this to net-next

As I stated, we never enforce W=1 compilation rule.

I understand we might want that for _future_ kernels.

>
> > unnecessary burden to stable teams all around the world.
>
> It is automatic.

I do receive a copy of all backports in my mailbox, whenever I am tagged.

I can tell you there is a lot of pollution.

>
> Thanks
