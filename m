Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23B5D6A7
	for <lists+lvs-devel@lfdr.de>; Tue,  2 Jul 2019 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBTK7 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 2 Jul 2019 15:10:59 -0400
Received: from ja.ssi.bg ([178.16.129.10]:58156 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfGBTK7 (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:10:59 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x62JA2LD004538;
        Tue, 2 Jul 2019 22:10:02 +0300
Date:   Tue, 2 Jul 2019 22:10:02 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
cc:     Jacky Hu <hengqing.hu@gmail.com>, horms@verge.net.au,
        lvs-devel@vger.kernel.org, lvs-users@linuxvirtualserver.org,
        jacky.hu@walmart.com, jason.niesz@walmart.com
Subject: Re: [PATCH v8 0/2] Allow tunneling with gue encapsulation
In-Reply-To: <20190702131209.57c018ea@carbon>
Message-ID: <alpine.LFD.2.21.1907022204510.4236@ja.home.ssi.bg>
References: <20190530080057.8218-1-hengqing.hu@gmail.com> <alpine.LFD.2.21.1905302130360.4725@ja.home.ssi.bg> <20190531084955.7cd4af00@carbon> <20190702131209.57c018ea@carbon>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Tue, 2 Jul 2019, Jesper Dangaard Brouer wrote:

> > On Thu, 30 May 2019 21:37:34 +0300 (EEST) Julian Anastasov <ja@ssi.bg> wrote:
> > 
> > > On Thu, 30 May 2019, Jacky Hu wrote:
> > >   
> > > > This patchset allows tunneling with gue encapsulation.
> > > >   
> > [...]
> > > 
> > > 	Both patches look ok to me, thanks!
> > > 
> > > Acked-by: Julian Anastasov <ja@ssi.bg>
> > > 
> > > 	Jesper, this patchset is based on the kernel patch
> > > "[PATCH v4] ipvs: add checksum support for gue encapsulation"
> > > which is to be applied to kernel trees. If needed, I can ping
> > > you when the patch is accepted.  
> 
> Looks like this commit got applied to the kernel in commit 29930e314da3
> ("ipvs: add checksum support for gue encapsulation"), but only net-next.

	Yes, I waited net-next to be sent to Linus but it is
fine to have these patches applied.

> Thus, I've applied this user-side patchset to ipvsadm.
>  https://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git/
> 
> As you might have noticed, I've created a release v1.30 prio to applying
> these.  As we have to wait for a kernel release, likely kernel v5.3,
> before making an ipvsadm release with this GUE feature.

	Very good, thanks! The GUE+GRE work can be part of next release.

> It should also make it easier for Julian's GRE work, to build on top.
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> 
> commit 29930e314da3833437a2ddc7b17f6a954f38d8fb
> Author: Jacky Hu <hengqing.hu@gmail.com>
> Date:   Thu May 30 08:16:40 2019 +0800
> 
>     ipvs: add checksum support for gue encapsulation
>     
>     Add checksum support for gue encapsulation with the tun_flags parameter,
>     which could be one of the values below:
>     IP_VS_TUNNEL_ENCAP_FLAG_NOCSUM
>     IP_VS_TUNNEL_ENCAP_FLAG_CSUM
>     IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM
>     
>     Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
>     Signed-off-by: Julian Anastasov <ja@ssi.bg>
>     Signed-off-by: Simon Horman <horms@verge.net.au>
>     Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Regards

--
Julian Anastasov <ja@ssi.bg>
