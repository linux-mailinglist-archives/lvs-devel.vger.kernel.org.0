Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E62BC5AF
	for <lists+lvs-devel@lfdr.de>; Sun, 22 Nov 2020 13:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKVMqe (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 22 Nov 2020 07:46:34 -0500
Received: from correo.us.es ([193.147.175.20]:47394 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbgKVMqd (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:46:33 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 32313A24C8F
        for <lvs-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:46:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 232E4DA798
        for <lvs-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:46:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 18271DA704; Sun, 22 Nov 2020 13:46:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8B11DA73D;
        Sun, 22 Nov 2020 13:46:28 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 22 Nov 2020 13:46:28 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B1EB74265A5A;
        Sun, 22 Nov 2020 13:46:28 +0100 (CET)
Date:   Sun, 22 Nov 2020 13:46:28 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Yejune Deng <yejune.deng@gmail.com>, wensong@linux-vs.org,
        horms@verge.net.au, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipvs: replace atomic_add_return()
Message-ID: <20201122124628.GA28719@salvia>
References: <1605513707-7579-1-git-send-email-yejune.deng@gmail.com>
 <9cd77e1e-1c52-d647-9443-485510b4a9b1@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cd77e1e-1c52-d647-9443-485510b4a9b1@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:57:52PM +0200, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Mon, 16 Nov 2020, Yejune Deng wrote:
> 
> > atomic_inc_return() looks better
> > 
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> 
> 	Looks good to me for -next, thanks!
> 
> Acked-by: Julian Anastasov <ja@ssi.bg>

Applied, thanks.
