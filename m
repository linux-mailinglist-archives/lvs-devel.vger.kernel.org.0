Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349A51140FC
	for <lists+lvs-devel@lfdr.de>; Thu,  5 Dec 2019 13:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEMre (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 5 Dec 2019 07:47:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39291 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729096AbfLEMre (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 5 Dec 2019 07:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575550053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCSP+OWY5s+EVxPlUvbauvM3zknf/JnJy1iXOn3yG3Q=;
        b=DarjII+4eX5lzlHqCHlyaqvVFkD7btWoRZfhx5y5dw8RhZ8/OBEQCEusqn84bxu8vZQSnx
        BGh+2dIBSicW603KCN1WseJq4RbbC88cBwCmKRdzajiUVvezq0fMl262KYUHouVvEouVMk
        qb8ILffaAXpzTtIvha5QOU1grnhNk84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196--XpydwjjMXCE3quoMuqOmg-1; Thu, 05 Dec 2019 07:47:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3261C911BD;
        Thu,  5 Dec 2019 12:47:29 +0000 (UTC)
Received: from carbon (ovpn-200-56.brq.redhat.com [10.40.200.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 198C21001B28;
        Thu,  5 Dec 2019 12:47:23 +0000 (UTC)
Date:   Thu, 5 Dec 2019 13:47:22 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Quentin Armitage <quentin@armitage.org.uk>
Cc:     Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>,
        lvs-devel@vger.kernel.org, lvs-users@linuxvirtualserver.org,
        Inju Song <inju.song@navercorp.com>, brouer@redhat.com
Subject: Re: [PATCH 0/2] Add missing options to ipvsadm(8)
Message-ID: <20191205134722.128a9c15@carbon>
In-Reply-To: <1564656793.3546.64.camel@armitage.org.uk>
References: <1564656793.3546.64.camel@armitage.org.uk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -XpydwjjMXCE3quoMuqOmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Thu, 01 Aug 2019 11:53:13 +0100
Quentin Armitage <quentin@armitage.org.uk> wrote:

> Quentin Armitage (2):
>   Add --pe sip option in ipvsadm(8) man page
>   In ipvsadm(8) add using nft or an eBPF program to set a packet mark
> 
>  ipvsadm.8 | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

This patchset is now applied to ipvsadm kernel.org git tree.
Sorry for not doing this sooner.

https://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git/commit/?id=e904a8cd1d7712
https://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git/commit/?id=089387716f0252

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

