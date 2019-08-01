Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4D7D9C2
	for <lists+lvs-devel@lfdr.de>; Thu,  1 Aug 2019 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfHAK7f (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 1 Aug 2019 06:59:35 -0400
Received: from smtp-out-6.tiscali.co.uk ([62.24.135.134]:62430 "EHLO
        smtp-out-6.tiscali.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAK7f (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 1 Aug 2019 06:59:35 -0400
Received: from nabal.armitage.org.uk ([92.27.6.192])
        by smtp.talktalk.net with SMTP
        id t8lahg5UdMbUct8lahoQsE; Thu, 01 Aug 2019 11:57:02 +0100
X-Originating-IP: [92.27.6.192]
Received: from localhost (localhost.localdomain [127.0.0.1])
        by nabal.armitage.org.uk (Postfix) with ESMTP id DB6D8E0589;
        Thu,  1 Aug 2019 11:57:00 +0100 (BST)
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from nabal.armitage.org.uk ([127.0.0.1])
        by localhost (nabal.armitage.org.uk [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EwXHIyx6M9cx; Thu,  1 Aug 2019 11:56:58 +0100 (BST)
Received: from samson1.armitage.org.uk (samson1.armitage.org.uk [IPv6:2001:470:69dd:35::210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by nabal.armitage.org.uk (Postfix) with ESMTPSA id 407BAE01EE;
        Thu,  1 Aug 2019 11:56:58 +0100 (BST)
Message-ID: <1564657015.3546.67.camel@armitage.org.uk>
Subject: [PATCH 2/2] In ipvsadm(8) add using nft or an eBPF program to set a
 packet mark
From:   Quentin Armitage <quentin@armitage.org.uk>
Reply-To: quentin@armitage.org.uk
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org,
        Inju Song <inju.song@navercorp.com>
Date:   Thu, 01 Aug 2019 11:56:55 +0100
In-Reply-To: <1564656793.3546.64.camel@armitage.org.uk>
References: <1564656793.3546.64.camel@armitage.org.uk>
Organization: The Armitage family
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJuj0u3PbCJsGV9EXx2VzB4xPXppIpeGAaWKSn4Lo9EB2Hw10TI3gcCrJjYyE5QlTG9zMN6kP/2JcXHim66GsMO/1W3DU/ckBc7s3TekTKx2+0SJzB5s
 eNk1o98RQDYIhSiDzjofUJbBR4t9uF9yqbP2Ergk1/2/zKmIRew1hmpo0qWpZkH5Kt/UYsCdEufdMQ==
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

The ipvsadm(8) man page specified that a packet mark could be set
using iptables. It is now also possible to set the packet mark using
nft, and also via an eBPF program.
 
Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
---
 ipvsadm.8 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/ipvsadm.8 b/ipvsadm.8
index aaee146..64a3526 100644
--- a/ipvsadm.8
+++ b/ipvsadm.8
@@ -196,9 +196,10 @@ Use SCTP service. See the -t|--tcp-service for the description of the
 .TP
 .B -f, --fwmark-service \fIinteger\fP
 Use a firewall-mark, an integer value greater than zero, to denote a
-virtual service instead of an address, port and protocol (UDP or
-TCP). The marking of packets with a firewall-mark is configured using
-the -m|--mark option to \fBiptables\fR(8). It can be used to build a
+virtual service instead of an address, port and protocol (UDP, TCP or
+SCTP). The marking of packets with a firewall-mark is configured using
+the -m|--mark option to \fBiptables\fR(8), the meta mark set \fIvalue\fR
+option to \fBnft\fR(8) or via an eBPF program. It can be used to build a
 virtual service associated with the same real servers, covering
 multiple IP address, port and protocol triplets. If IPv6 addresses
 are used, the -6 option must be used.
-- 
2.13.7

