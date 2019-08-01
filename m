Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E440A7D9D1
	for <lists+lvs-devel@lfdr.de>; Thu,  1 Aug 2019 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHALBb (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 1 Aug 2019 07:01:31 -0400
Received: from smtp-out-6.tiscali.co.uk ([62.24.135.134]:52878 "EHLO
        smtp-out-6.tiscali.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHALBb (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 1 Aug 2019 07:01:31 -0400
Received: from nabal.armitage.org.uk ([92.27.6.192])
        by smtp.talktalk.net with SMTP
        id t8i2hg4VUMbUct8i2hoQlb; Thu, 01 Aug 2019 11:53:22 +0100
X-Originating-IP: [92.27.6.192]
Received: from localhost (localhost.localdomain [127.0.0.1])
        by nabal.armitage.org.uk (Postfix) with ESMTP id E5E75E0589;
        Thu,  1 Aug 2019 11:53:19 +0100 (BST)
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from nabal.armitage.org.uk ([127.0.0.1])
        by localhost (nabal.armitage.org.uk [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hPOgFLW9inks; Thu,  1 Aug 2019 11:53:16 +0100 (BST)
Received: from samson1.armitage.org.uk (samson1.armitage.org.uk [IPv6:2001:470:69dd:35::210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by nabal.armitage.org.uk (Postfix) with ESMTPSA id 4D54BE010A;
        Thu,  1 Aug 2019 11:53:16 +0100 (BST)
Message-ID: <1564656793.3546.64.camel@armitage.org.uk>
Subject: [PATCH 0/2] Add missing options to ipvsadm(8)
From:   Quentin Armitage <quentin@armitage.org.uk>
Reply-To: quentin@armitage.org.uk
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org,
        Inju Song <inju.song@navercorp.com>
Date:   Thu, 01 Aug 2019 11:53:13 +0100
Organization: The Armitage family
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAySRWitFoxz6Uc4JCrctNm3RyyrUq0ZrNkJGG+lgx6KFWLtroQmn2q9xIAZLndwaDMVFhWImW6u6B5p4rwKrAPhH+j6YpkFSOWx+Qid4uULciRg7dK+
 v327HzebSXyqkt+2MzyE+UCuTR1ZJ5o0mUAilOinHKveWBfB48f2GBtvqfcuPR5Y2z1hwdIQun0iIw==
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Quentin Armitage (2):
  Add --pe sip option in ipvsadm(8) man page
  In ipvsadm(8) add using nft or an eBPF program to set a packet mark

 ipvsadm.8 | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.13.7

