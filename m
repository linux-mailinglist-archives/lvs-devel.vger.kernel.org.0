Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAC30C243
	for <lists+lvs-devel@lfdr.de>; Tue,  2 Feb 2021 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhBBOpf (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 2 Feb 2021 09:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhBBOgd (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 2 Feb 2021 09:36:33 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E1C06178B
        for <lvs-devel@vger.kernel.org>; Tue,  2 Feb 2021 06:34:50 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q5so19199779ilc.10
        for <lvs-devel@vger.kernel.org>; Tue, 02 Feb 2021 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxl73venaa9cWERoVp0VscHZS3/IH5lSgUJLT8Av3Oc=;
        b=d5yDUwK8kbyroVDcNrW9Bed9kahFje2ZIU0BDehuW5DzhPmTw6AKATlvIgrv3J4sup
         aIo/FiNf8JoT4Hc5Hak+mLJocFm+sU/u992MZHifR/Vk1Vy162sQeLOaHALCaNiJbGRo
         OML/GI0PIO+UdFLcZ8smRhAhPEB81uhDI1ArrGScpj4MY6sy6aHAFWoy7FYSsBM4zZ8y
         BasAXhEgwWcGYwtGMAoiGGjfmc51b8AlNJGIgeBrkF+i00WuUU55rrkEzAbaCoaooN1y
         L9wDlcTrJVC2mJ9uCebXrUMygqRdWMyoY4OOn+vTf+7KKYGSCcbjpUs1+bjIJQtN65xg
         Nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxl73venaa9cWERoVp0VscHZS3/IH5lSgUJLT8Av3Oc=;
        b=i8LxRyMDujxEXeQAl1sWmE6CKfmEhwKhNN3fEFM9i0Ij83FwC1TfMLU700MRdyvMA+
         +dwN2mpT/y+mARUrxRqcWoWQZwRWyfPCntE+Wi+RWbCWdSENGb0OBaf/lutPQp3wjxSx
         HNggT8mMt9S2o8KZ2NW6Ux+gioCINyqL0CFBmrqRjLK+PSHeSNl9rSVfkp2clI4/K3NG
         uy7POTZKV8rkDCvXwaYHU/N2FvwM+/kdd4UrTwdPqkpitv9q1xc3nEv5d2Fj+jv/of6n
         0KBS+Gxan47WPqKpj9iZTzncxLAmSWYFc6gS3LTYIGceWXTTHdlJahCTBX9O5hdtZfcy
         9xrw==
X-Gm-Message-State: AOAM530O8YOGiLgfKaWE+F7SSMK/GXhD0GeHjxAc1n7uA5u3hnFHiuiE
        rfUOpCeVdqbuBWWvLmnWT7G0yXQ619vtxFnKdJR8Vw==
X-Google-Smtp-Source: ABdhPJwdCq6fIqid1NDIwXhIUsFuZbRVI0mELuQ6Hg5XtSZnefbtVLLxDzRUbY6f1swYl+qnJ9omvJfA21H0KTmRU6M=
X-Received: by 2002:a05:6e02:1251:: with SMTP id j17mr3978433ilq.216.1612276489189;
 Tue, 02 Feb 2021 06:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20210202135544.3262383-1-leon@kernel.org>
In-Reply-To: <20210202135544.3262383-1-leon@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 2 Feb 2021 15:34:37 +0100
Message-ID: <CANn89iL4jGbr_6rr11nsHxmdh7uz=kqXuMhRb0nakWO3rBZwsQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4] Fix W=1 compilation warnings in net/* folder
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
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Feb 2, 2021 at 2:55 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Hi,
>
> This short series fixes W=1 compilation warnings which I experienced
> when tried to compile net/* folder.
>

Ok, but we never had a strong requirement about W=1, so adding Fixes:
tag is adding
unnecessary burden to stable teams all around the world.
