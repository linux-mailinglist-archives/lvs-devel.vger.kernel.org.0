Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2C5CE29
	for <lists+lvs-devel@lfdr.de>; Tue,  2 Jul 2019 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfGBLMS (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 2 Jul 2019 07:12:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfGBLMR (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:12:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94E4633027C;
        Tue,  2 Jul 2019 11:12:17 +0000 (UTC)
Received: from carbon (ovpn-200-45.brq.redhat.com [10.40.200.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C217760C67;
        Tue,  2 Jul 2019 11:12:11 +0000 (UTC)
Date:   Tue, 2 Jul 2019 13:12:09 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Jacky Hu <hengqing.hu@gmail.com>, horms@verge.net.au,
        lvs-devel@vger.kernel.org, lvs-users@linuxvirtualserver.org,
        jacky.hu@walmart.com, jason.niesz@walmart.com, brouer@redhat.com
Subject: Re: [PATCH v8 0/2] Allow tunneling with gue encapsulation
Message-ID: <20190702131209.57c018ea@carbon>
In-Reply-To: <20190531084955.7cd4af00@carbon>
References: <20190530080057.8218-1-hengqing.hu@gmail.com>
        <alpine.LFD.2.21.1905302130360.4725@ja.home.ssi.bg>
        <20190531084955.7cd4af00@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Jul 2019 11:12:17 +0000 (UTC)
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri, 31 May 2019 08:49:55 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> On Thu, 30 May 2019 21:37:34 +0300 (EEST) Julian Anastasov <ja@ssi.bg> wrote:
> 
> > On Thu, 30 May 2019, Jacky Hu wrote:
> >   
> > > This patchset allows tunneling with gue encapsulation.
> > >   
> [...]
> > 
> > 	Both patches look ok to me, thanks!
> > 
> > Acked-by: Julian Anastasov <ja@ssi.bg>
> > 
> > 	Jesper, this patchset is based on the kernel patch
> > "[PATCH v4] ipvs: add checksum support for gue encapsulation"
> > which is to be applied to kernel trees. If needed, I can ping
> > you when the patch is accepted.  

Looks like this commit got applied to the kernel in commit 29930e314da3
("ipvs: add checksum support for gue encapsulation"), but only net-next.

Thus, I've applied this user-side patchset to ipvsadm.
 https://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git/

As you might have noticed, I've created a release v1.30 prio to applying
these.  As we have to wait for a kernel release, likely kernel v5.3,
before making an ipvsadm release with this GUE feature.

It should also make it easier for Julian's GRE work, to build on top.
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

commit 29930e314da3833437a2ddc7b17f6a954f38d8fb
Author: Jacky Hu <hengqing.hu@gmail.com>
Date:   Thu May 30 08:16:40 2019 +0800

    ipvs: add checksum support for gue encapsulation
    
    Add checksum support for gue encapsulation with the tun_flags parameter,
    which could be one of the values below:
    IP_VS_TUNNEL_ENCAP_FLAG_NOCSUM
    IP_VS_TUNNEL_ENCAP_FLAG_CSUM
    IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM
    
    Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
    Signed-off-by: Julian Anastasov <ja@ssi.bg>
    Signed-off-by: Simon Horman <horms@verge.net.au>
    Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
