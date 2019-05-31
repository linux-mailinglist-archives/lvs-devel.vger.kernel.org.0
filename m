Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D0308F8
	for <lists+lvs-devel@lfdr.de>; Fri, 31 May 2019 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEaGuG (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 31 May 2019 02:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaGuG (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Fri, 31 May 2019 02:50:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E4A93082E21;
        Fri, 31 May 2019 06:50:05 +0000 (UTC)
Received: from carbon (unknown [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F30F2B5A6;
        Fri, 31 May 2019 06:49:57 +0000 (UTC)
Date:   Fri, 31 May 2019 08:49:55 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Jacky Hu <hengqing.hu@gmail.com>, horms@verge.net.au,
        lvs-devel@vger.kernel.org, lvs-users@linuxvirtualserver.org,
        jacky.hu@walmart.com, jason.niesz@walmart.com, brouer@redhat.com
Subject: Re: [PATCH v8 0/2] Allow tunneling with gue encapsulation
Message-ID: <20190531084955.7cd4af00@carbon>
In-Reply-To: <alpine.LFD.2.21.1905302130360.4725@ja.home.ssi.bg>
References: <20190530080057.8218-1-hengqing.hu@gmail.com>
        <alpine.LFD.2.21.1905302130360.4725@ja.home.ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 31 May 2019 06:50:06 +0000 (UTC)
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


On Thu, 30 May 2019 21:37:34 +0300 (EEST) Julian Anastasov <ja@ssi.bg> wrote:

> On Thu, 30 May 2019, Jacky Hu wrote:
> 
> > This patchset allows tunneling with gue encapsulation.
> > 
[...]
> 
> 	Both patches look ok to me, thanks!
> 
> Acked-by: Julian Anastasov <ja@ssi.bg>
> 
> 	Jesper, this patchset is based on the kernel patch
> "[PATCH v4] ipvs: add checksum support for gue encapsulation"
> which is to be applied to kernel trees. If needed, I can ping
> you when the patch is accepted.

Yes, that would be great!  I'll apply it as soon as the kernel patch is
accepted.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
