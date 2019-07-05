Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD93F60C83
	for <lists+lvs-devel@lfdr.de>; Fri,  5 Jul 2019 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfGEUng (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 5 Jul 2019 16:43:36 -0400
Received: from mail.us.es ([193.147.175.20]:42574 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfGEUng (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:43:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 65C03FB6C9
        for <lvs-devel@vger.kernel.org>; Fri,  5 Jul 2019 22:43:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5831CD1929
        for <lvs-devel@vger.kernel.org>; Fri,  5 Jul 2019 22:43:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4DD72DA4D0; Fri,  5 Jul 2019 22:43:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 641D2DA732;
        Fri,  5 Jul 2019 22:43:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 22:43:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 39D914265A32;
        Fri,  5 Jul 2019 22:43:32 +0200 (CEST)
Date:   Fri, 5 Jul 2019 22:43:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Vadim Fedorenko <vfedorenko@yandex-team.ru>
Subject: Re: [PATCHv2 net-next] ipvs: strip gre tunnel headers from icmp
 errors
Message-ID: <20190705204331.pnovxzj5shwwdxy6@salvia>
References: <20190703183809.4554-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703183809.4554-1-ja@ssi.bg>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Wed, Jul 03, 2019 at 09:38:09PM +0300, Julian Anastasov wrote:
> Recognize GRE tunnels in received ICMP errors and
> properly strip the tunnel headers.

Applied v2, thanks Julian.
