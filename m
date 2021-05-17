Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3093A382707
	for <lists+lvs-devel@lfdr.de>; Mon, 17 May 2021 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhEQIap (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 17 May 2021 04:30:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhEQIap (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 17 May 2021 04:30:45 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1liYcy-0004SJ-J8
        for lvs-devel@vger.kernel.org; Mon, 17 May 2021 08:29:28 +0000
Received: by mail-wm1-f72.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so1146014wmq.5
        for <lvs-devel@vger.kernel.org>; Mon, 17 May 2021 01:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=T/k1Hfbl0QWX7BgUNKlB2kMgvZHjTQfbPANeoy85SUc=;
        b=bW5xSaNZjTLKWBfgYwxZbDqLWtX3SZanj/fVUesvHcpREuhtDQiQDWslfl5RwhaYY3
         VQXRlB75lL5u25uW7QoJzeyDzvmkIMUgv5IBgz15GMaNLEQMXYDsrkdc6lEgJ5h2/3Gi
         pHgZA5/UEUOe3ghny3MYz+A11i4dgo4OktnaWG5OuG/9tn8K3a/zSUYG3rnhpxR+7eUC
         Gh2lqy3f2msupGIrfVZvMC0QIwJPCzHLu20FK3y5AlkycQpKFvOQTgD9yJR15kyo4/Rr
         pJ1oF9uoV7H3lUyzvaBzjXdjXxxwkPDlWfVt0k9MWeeL7z89upgOnq47JdRLgNmesr/q
         9j9A==
X-Gm-Message-State: AOAM532DlvVO/DgmFc9b0H2QfQs92FfUtYIHwD1gYMNUapQ3vcuG7diI
        3Vzl2+Mhxpgb46o2z9ihu06u0DO6i6wNMD5yzkW579JPv+Y4lqevaMMuI6kQuyFdyofbPijttbH
        0rtqvyV7+o5shevPMho5Ugu8qzeFdLBlaofOTYg==
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr69882813edx.52.1621240158129;
        Mon, 17 May 2021 01:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzfvlH5EzvwOwvjZrfGS/mgdWYRGeWBuLqXSaxf59eSojt+fwGp2Tv4PXBiEmsWL6Vcbb4nQ==
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr69882802edx.52.1621240157962;
        Mon, 17 May 2021 01:29:17 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ho32sm8220626ejc.82.2021.05.17.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:29:17 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Mon, 17 May 2021 10:29:15 +0200
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        aaro.koskinen@iki.fi, tony@atomide.com, linux@prisktech.co.nz,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, mst@redhat.com, jasowang@redhat.com,
        zbr@ioremap.net, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, horms@verge.net.au, ja@ssi.bg,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-scsi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] treewide: Remove leading spaces in Kconfig files
Message-ID: <20210517102915.072b8665@gollum>
In-Reply-To: <YKImotylLR7D4mQW@kroah.com>
References: <20210516132209.59229-1-juergh@canonical.com>
        <YKIDJIfuufBrTQ4f@kroah.com>
        <CAB2i3ZgszsUVDuK2fkUXtD72tPSgrycnDawM4VAuGGPJiA9+cA@mail.gmail.com>
        <YKImotylLR7D4mQW@kroah.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7AKy83dA=gk+i5Iqn9=k5c";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--Sig_/D7AKy83dA=gk+i5Iqn9=k5c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 May 2021 10:17:38 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, May 17, 2021 at 10:07:43AM +0200, Juerg Haefliger wrote:
> > On Mon, May 17, 2021 at 7:46 AM Greg KH <gregkh@linuxfoundation.org> wr=
ote: =20
> > >
> > > On Sun, May 16, 2021 at 03:22:09PM +0200, Juerg Haefliger wrote: =20
> > > > There are a few occurences of leading spaces before tabs in a coupl=
e of
> > > > Kconfig files. Remove them by running the following command:
> > > >
> > > >   $ find . -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'
> > > >
> > > > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > > > ---
> > > >  arch/arm/mach-omap1/Kconfig     | 12 ++++++------
> > > >  arch/arm/mach-vt8500/Kconfig    |  6 +++---
> > > >  arch/arm/mm/Kconfig             | 10 +++++-----
> > > >  drivers/char/hw_random/Kconfig  |  8 ++++----
> > > >  drivers/net/usb/Kconfig         | 10 +++++-----
> > > >  drivers/net/wan/Kconfig         |  4 ++--
> > > >  drivers/scsi/Kconfig            |  2 +-
> > > >  drivers/uio/Kconfig             |  2 +-
> > > >  drivers/video/backlight/Kconfig | 10 +++++-----
> > > >  drivers/virtio/Kconfig          |  2 +-
> > > >  drivers/w1/masters/Kconfig      |  6 +++---
> > > >  fs/proc/Kconfig                 |  4 ++--
> > > >  init/Kconfig                    |  2 +-
> > > >  net/netfilter/Kconfig           |  2 +-
> > > >  net/netfilter/ipvs/Kconfig      |  2 +-
> > > >  15 files changed, 41 insertions(+), 41 deletions(-) =20
> > >
> > > Please break this up into one patch per subsystem and resend to the
> > > proper maintainers that way. =20
> >=20
> > Hmm... How is my patch different from other treewide Kconfig cleanup
> > patches like:
> > a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'he=
lp'")
> > 8636a1f9677d ("treewide: surround Kconfig file paths with double quotes=
")
> > 83fc61a563cb ("treewide: Fix typos in Kconfig")
> > 769a12a9c760 ("treewide: Kconfig: fix wording / spelling")
> > f54619f28fb6 ("treewide: Fix typos in Kconfig") =20
>=20
> Ok, I'll just ignore this and not try to suggest a way for you to get
> your change accepted...

No worries. I can make the change, was just wondering...

...Juerg
=20
> greg k-h


--Sig_/D7AKy83dA=gk+i5Iqn9=k5c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmCiKVsACgkQD9OLCQum
QrePLw//Ykimz2jPT7e6QtcgGI7q3Z9YELDFMiqk+ujC4vzVJBFi+WZekZa+tti2
7T5x1ci+i2mPSr/sNSIuKfQcvBH7SBdcckdjSdD55wGKV7GWUMNDkJR1x7aW5Pzo
eEhHCY0hTkEq76S1wegRvD2HxXpsW4aH6rZjB/uNo9V/lRaJJNuouXrxs1zI/6zr
UtYRTLVqVCsTxv0C+XF/C0T+gdbhYaU/68B/+zUSLVo83JQBo9rXrPfNmRWGo5hO
SnFkkcfMuosZZ9RQqmpdR1y4D+1x7OrROghRJT8gy9LBF5c/0yTimblVifcoNXi0
fUZmNRzYvteApmm8m0SBbOEE3mHiKDVIJ7MHDdjtPweaNNJrH+CkXztENtzb+AJr
h6hlvQklXSI2/h+PaCLMPGxUnYDj5xhXVWwmiIy/0Hk466jeuPz4od5EQSe607ZB
dw8oX5/MCHtJhdsgSUB3BHiwWPD7zBuUouHOBGsyFJBsCFcU5MIiQVFe2fiNRbkA
nlmkOuBT2+LKK+2AU/nQ1IGkcP1b8a3Az8g6+ywxyjMHv1+7FafEMrFgJUGIeXNl
z80JfoWhqqI4UcRltEhJE44NfdVqDqHMomAwI2qHuSSZAWLKEjIPQkFtDlWDAlB4
d2q4e+YbdD1XE5/fFDYMOvZk31+d9GLtO0SQeZyuQo8r3MAkpR0=
=CrpS
-----END PGP SIGNATURE-----

--Sig_/D7AKy83dA=gk+i5Iqn9=k5c--
