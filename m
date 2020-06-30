Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A550420F9AB
	for <lists+lvs-devel@lfdr.de>; Tue, 30 Jun 2020 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbgF3Qn2 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 30 Jun 2020 12:43:28 -0400
Received: from correo.us.es ([193.147.175.20]:55848 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733117AbgF3Qn2 (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:43:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 72B09F2581
        for <lvs-devel@vger.kernel.org>; Tue, 30 Jun 2020 18:43:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 63A49DA8FD
        for <lvs-devel@vger.kernel.org>; Tue, 30 Jun 2020 18:43:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 58E83DA722; Tue, 30 Jun 2020 18:43:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 04196DA722;
        Tue, 30 Jun 2020 18:43:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Jun 2020 18:43:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DB1EC4265A2F;
        Tue, 30 Jun 2020 18:43:23 +0200 (CEST)
Date:   Tue, 30 Jun 2020 18:43:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] ipvs: register hooks only with services
Message-ID: <20200630164323.GA25884@salvia>
References: <20200621154030.10998-1-ja@ssi.bg>
 <20200630152348.GB12560@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630152348.GB12560@vergenet.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:23:48PM +0200, Simon Horman wrote:
> On Sun, Jun 21, 2020 at 06:40:30PM +0300, Julian Anastasov wrote:
> > Keep the IPVS hooks registered in Netfilter only
> > while there are configured virtual services. This
> > saves CPU cycles while IPVS is loaded but not used.
> > 
> > Signed-off-by: Julian Anastasov <ja@ssi.bg>
> 
> Thanks Julian, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>
> 
> Pablo, could you consider this for nf-next?

Applied, thanks.
