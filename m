Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF75A576
	for <lists+lvs-devel@lfdr.de>; Fri, 28 Jun 2019 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfF1Twt (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 28 Jun 2019 15:52:49 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45527 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfF1Two (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 28 Jun 2019 15:52:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id m16so4618501ywh.12
        for <lvs-devel@vger.kernel.org>; Fri, 28 Jun 2019 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zbt8t4OGSrBZUltQdpu2XfV4/PLifVH/Z0A6OyR0+8=;
        b=bsREio19ZCYiktCkIASujl5tmzasz+I6GbX0QwjW1yWtrPHLtl8F72d/tP0OV718gu
         JhET9fkvZSnspuxgKrEOx/1kP1SYjQ7fj0fI/XoKoCGyk+qi6UDO6wRJo+hNRVYcyyxq
         0JSncshPTPt64doooXNY6ma4/ktV2ka0yVK/xrE/yAYCFGpIjfHmlQ4eCCCi+mJeJUsc
         8W4PI0vw66GNUmY1JGqXcSHa2CiCZHRkpxNiXv/kZ+fttkGp4qs1PP7G81iPFP6xFUG7
         n7G6MbZWqfBIpLiVXTzG3xd/E7GrLNqS/TCCUVcsr/qDjsGrDy2eGI721OOsI6wgTV9h
         S/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zbt8t4OGSrBZUltQdpu2XfV4/PLifVH/Z0A6OyR0+8=;
        b=gmIHWoV4AYdbixKmwj5F5FrQ31XNlpRHQM1Fj1X/ebzUBHZ0rA1p8PrsNlYX5vaw8L
         vxn7XcaEDWfUBnEAjCDvsVHB+zt0a+okDAbM5Z/A/STDPrK/dn9kjEJt0Tm6cZMP1ygI
         DqFXY9jFPVa9nVkYuE4ypB84QcySD2odI1ueK2oyNWMZe7AAJ/Q+a7fJMcjHI7TLlexW
         GAhkU9gYwNO9e+9TE7UcbP+PZ+Tr5PkQvsoNzMTYrFM3MbvTzTgESVRUeyiixwXzOe6+
         tgw/MzYmYpunciH3GaD/BCYzIZBX/oawpWEFXwZmu/81tuAK6Cbvu/6AvQ1RovfkYgLT
         /aXw==
X-Gm-Message-State: APjAAAVnLv2ZPf7K/7IgVp8ymaGOvsGVVfKyZDo78mGnzd1+wj3b1Vwl
        a5mHsk2zVb/klCepB8v40UV43msYncs=
X-Google-Smtp-Source: APXvYqzW7tK0LhciZuohLMjdbNbUoM3wdIlE1nV3UeYeyxDUVgCgizOg7cChTjRomnpfJGuA+xMZdA==
X-Received: by 2002:a81:3a15:: with SMTP id h21mr7637169ywa.207.1561751563871;
        Fri, 28 Jun 2019 12:52:43 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id j127sm758814ywe.32.2019.06.28.12.52.40
        for <lvs-devel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:52:41 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id u141so2079370ywe.4
        for <lvs-devel@vger.kernel.org>; Fri, 28 Jun 2019 12:52:40 -0700 (PDT)
X-Received: by 2002:a81:8357:: with SMTP id t84mr7023115ywf.109.1561751559659;
 Fri, 28 Jun 2019 12:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190628123819.2785504-1-arnd@arndb.de> <20190628123819.2785504-3-arnd@arndb.de>
In-Reply-To: <20190628123819.2785504-3-arnd@arndb.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 28 Jun 2019 15:52:03 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdL=GwjhbERsePAJfbakgEQZb7X51UHw=+4R9dJD3JD4A@mail.gmail.com>
Message-ID: <CA+FuTSdL=GwjhbERsePAJfbakgEQZb7X51UHw=+4R9dJD3JD4A@mail.gmail.com>
Subject: Re: [PATCH 3/4] staging: rtl8712: reduce stack usage, again
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        James Morris <jmorris@namei.org>, linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri, Jun 28, 2019 at 8:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> An earlier patch I sent reduced the stack usage enough to get
> below the warning limit, and I could show this was safe, but with
> GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, it gets worse again because large stack
> variables in the same function no longer overlap:
>
> drivers/staging/rtl8712/rtl871x_ioctl_linux.c: In function 'translate_scan.isra.2':
> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:322:1: error: the frame size of 1200 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>
> Split out the largest two blocks in the affected function into two
> separate functions and mark those noinline_for_stack.
>
> Fixes: 8c5af16f7953 ("staging: rtl8712: reduce stack usage")
> Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable types")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>
