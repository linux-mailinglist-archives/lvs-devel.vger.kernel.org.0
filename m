Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79657D9BE
	for <lists+lvs-devel@lfdr.de>; Thu,  1 Aug 2019 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfHAK62 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 1 Aug 2019 06:58:28 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:37761 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAK61 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 1 Aug 2019 06:58:27 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 06:58:26 EDT
Received: from nabal.armitage.org.uk ([92.27.6.192])
        by smtp.talktalk.net with SMTP
        id t8kUhmRaznuQZt8kUh4Mxw; Thu, 01 Aug 2019 11:55:55 +0100
X-Originating-IP: [92.27.6.192]
Received: from localhost (localhost.localdomain [127.0.0.1])
        by nabal.armitage.org.uk (Postfix) with ESMTP id 598ACE0589;
        Thu,  1 Aug 2019 11:55:53 +0100 (BST)
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from nabal.armitage.org.uk ([127.0.0.1])
        by localhost (nabal.armitage.org.uk [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id slCADr5Vb0wO; Thu,  1 Aug 2019 11:55:50 +0100 (BST)
Received: from samson1.armitage.org.uk (samson1.armitage.org.uk [IPv6:2001:470:69dd:35::210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by nabal.armitage.org.uk (Postfix) with ESMTPSA id 90682E010A;
        Thu,  1 Aug 2019 11:55:50 +0100 (BST)
Message-ID: <1564656948.3546.66.camel@armitage.org.uk>
Subject: [PATCH 1/2] Add --pe sip option in ipvsadm(8) man page
From:   Quentin Armitage <quentin@armitage.org.uk>
Reply-To: quentin@armitage.org.uk
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org,
        Inju Song <inju.song@navercorp.com>
Date:   Thu, 01 Aug 2019 11:55:48 +0100
In-Reply-To: <1564656793.3546.64.camel@armitage.org.uk>
References: <1564656793.3546.64.camel@armitage.org.uk>
Organization: The Armitage family
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBRgLx6N0P2Vv6urO7gRCSxGRfNgIb4ZXOLpgNP5fEDoDDZ559nG7iIwRjfWxhwAs1detx1GZclWYRCH9L/Xv6wwqi5khyIlUXtQMI0MrUA/CZC8H22w
 cbuLqj583BttHabNSrwfDxoYfoi8BfoKVaBjRxMGM5Bxx6Ldm3kIwuj3QJafcDt7aEHT4/nczOgA2Q==
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 ipvsadm.8 | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
 
diff --git a/ipvsadm.8 b/ipvsadm.8 
index 256718e..aaee146 100644
--- a/ipvsadm.8
+++ b/ipvsadm.8
@@ -94,11 +94,11 @@ The command has two basic formats for execution:
 The first format manipulates a virtual service and the algorithm for
 assigning service requests to real servers. Optionally, a persistent
 timeout and network mask for the granularity of a persistent service
-may be specified. The second format manipulates a real server that is
-associated with an existing virtual service. When specifying a real
-server, the packet-forwarding method and the weight of the real
-server, relative to other real servers for the virtual service, may be
-specified, otherwise defaults will be used.
+and a persistence engine may be specified. The second format manipulates
+a real server that is associated with an existing virtual service.
+When specifying a real server, the packet-forwarding method and the
+weight of the real server, relative to other real servers for the
+virtual service, may be specified, otherwise defaults will be used.
 .SS COMMANDS
 \fBipvsadm\fR(8) recognises the commands described below. Upper-case
 commands maintain virtual services. Lower-case commands maintain real
@@ -313,6 +313,10 @@ resolve problems with non-persistent cache clusters on the client side.
 IPv6 netmasks should be specified as a prefix length between 1 and 128.
 The default prefix length is 128.
 .TP
+.B --pe \fIpersistence-engine\fP
+Specify an alternative persistence engine to be used. Currently the
+only alternative persistence engine available is sip.
+.TP
 .B -b, --sched-flags \fIsched-flags\fP
 Set scheduler flags for this virtual server.  \fIsched-flags\fP is a
 comma-separated list of flags.  See the scheduler descriptions for
-- 
2.13.7

