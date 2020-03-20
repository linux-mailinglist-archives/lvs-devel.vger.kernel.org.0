Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4C18CDE7
	for <lists+lvs-devel@lfdr.de>; Fri, 20 Mar 2020 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTMcV (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 20 Mar 2020 08:32:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31295 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgCTMcV (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 20 Mar 2020 08:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584707541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q59I6+lX0Di4/mSsiaIDK7x6zwRbWQxto0rO5l0DxN4=;
        b=fEhWEmfEo+e9DE7z9/7twK9x+bACUpYHBVoiRKB9cBTbCcswM6rbB1qBa0Vini9SLiTvb+
        APKrc98jRtUzZcl11TcoRCdnOqKLs1X8/2zBK9tJaqNcON8gILOjk2kfEJJDXneTRrG/zm
        GpbWvo8+7O+HNLwQBiOFILN9cHV8j1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-o6SReZ5hNS6_jKfJ8GSx5w-1; Fri, 20 Mar 2020 08:32:17 -0400
X-MC-Unique: o6SReZ5hNS6_jKfJ8GSx5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7923C101FC82;
        Fri, 20 Mar 2020 12:31:58 +0000 (UTC)
Received: from carbon (unknown [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7068394B22;
        Fri, 20 Mar 2020 12:31:39 +0000 (UTC)
Date:   Fri, 20 Mar 2020 13:31:37 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Alexander Petrovsky <askjuise@gmail.com>
Cc:     "LinuxVirtualServer.org users mailing list." 
        <lvs-users@linuxvirtualserver.org>, Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>, brouer@redhat.com,
        "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>
Subject: Re: [lvs-users] Micro ipvsadm patch
Message-ID: <20200320133137.3cc59704@carbon>
In-Reply-To: <CAH57y_TcVNdCe7ciAXX85HzWXPhWgUWvXn2f7r8yWjM2TUNecQ@mail.gmail.com>
References: <CAH57y_TcVNdCe7ciAXX85HzWXPhWgUWvXn2f7r8yWjM2TUNecQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Wed, 11 Mar 2020 15:05:58 +0300
Alexander Petrovsky <askjuise@gmail.com> wrote:

> Hello!
> 
> This micro ipvsadm patch fixes wrong (negative) FWMARK values
> representation:
> 
> # ipvsadm -L -f 2882430849
> Prot LocalAddress:Port Scheduler Flags
>   -> RemoteAddress:Port           Forward Weight ActiveConn InActConn  
> FWM  -1412536447 wlc
>   -> abc.my.host.net. Tunnel  1      0          0  
> 

Hi Alexander,

Your patch submission does not follow all the procedures, but given
this is fairly trivial, and Julian didn't object, I went ahead and
applied the patch with (your SoB and credit to you), here:

https://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git/commit/?id=e61c8cdd1dcad

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

