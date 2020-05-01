Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D61C21AC
	for <lists+lvs-devel@lfdr.de>; Sat,  2 May 2020 01:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAXxL (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 1 May 2020 19:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgEAXxL (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 1 May 2020 19:53:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A14C061A0C
        for <lvs-devel@vger.kernel.org>; Fri,  1 May 2020 16:53:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id m5so5885248ilj.10
        for <lvs-devel@vger.kernel.org>; Fri, 01 May 2020 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jM94nNBrNF36elR9SpxnlLBXmyEcl3UvUFgw939tv+U=;
        b=BGhxQC4ruZdb1fgsEpta3pkepGPosNTMRfq20/V7vGpjWNyAjrmDHYwpkbTpQrS4T6
         vU20lGp50YpvPtSe6oAmpOHzO2aIHoHQu6eatd+SCzFn4aD9IX1wX3tWVWrEjqmpn/R/
         b6urZiGc8vquRjGohtZu9+pHMZ83b1UYEwNE9J5wcgj6SY/tACmh/59UsTxanlK7rYQq
         BnNgDRuSvF1SmzJAuOaB7//EyjSOzFFOT4usYoP1KznlFgS2FLulDq2dI81fBGXljDaJ
         W4JBCLGfPFn7v4ODawAPnoBTyOZdQu1ov48Ztd/dII76AUTFUYnzUsNGhpUXMMQESnxH
         7U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=jM94nNBrNF36elR9SpxnlLBXmyEcl3UvUFgw939tv+U=;
        b=dYnqdc0NafZgN0rOqcfYUpt7xj3oeBRMj3Q/KTPZbPkneRhcODTL9LIt8LBUVBYwil
         bxaJMI0bbzL21RXFthMKN61spWu+It9SaXJ+jiyBLnBQeirRwdSZNn7kU/1bjnJeXEIi
         OSylrPCdQ2TcP02QXKLPrBdvWz3syWWFansxxWDRQ5FzQREEgjxYClUdJpZw+inR5O5H
         t6GTKilBNljtSrsCR/6a9YEv+PYCf/BTNjnTziVwwPJTTVtZIfSvZJq4vP8aWpTzJsbQ
         ykWFSxAK39oThOPvEWY5226KM7qkbvA/qyrH9s/CXm0WzKUfocR6hKy8lrDt7dfbt6UW
         OPQA==
X-Gm-Message-State: AGi0PuajI/ZkVpn4SbEmkkvGUpwrRhNbKPNj/fUzVrWJ9N4opwp+1uSY
        J0FH0xbbfpQRvdVlbjKqOh1w+KMzQrWa5PKHK+JL1L2xFRU=
X-Google-Smtp-Source: APiQypJ9tZZ5WVaCw6obM6Cuktc6Bdf4Zwaexuo/2i5D/gTB+yBbNdM00UDnAcicvu1JNxzWE1Sltfg52TUx0xg9HeU=
X-Received: by 2002:a92:8885:: with SMTP id m5mr5646855ilh.154.1588377189125;
 Fri, 01 May 2020 16:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:b31e:0:0:0:0:0 with HTTP; Fri, 1 May 2020 16:53:08 -0700 (PDT)
Reply-To: robertmrwilson@gmail.com
From:   "Mr. Wilson Robert" <s.samuel0r@gmail.com>
Date:   Sat, 2 May 2020 00:53:08 +0100
Message-ID: <CAARCaUdcOjtMXcpSkSYvU-QrXedEo1b-RNo8u+iKRi_BdKr0sQ@mail.gmail.com>
Subject: Dear Owner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

From: Mr. Wilson Robert
 Director Inspection Unit
 Hartsfield=E2=80=93Jackson International
 Airport, Atlanta Georgia United-States
 Regional Division Shipment
 Officer, Atlanta Georgia.

 Dear Owner,

I am Mr. Wilson Robert, Head Officer-in-Charge, and Administrative
Service Inspection Unit United Nations Inspection Agency in
Hartsfield=E2=80=93Jackson International Airport Atlanta, Georgia. During o=
ur
investigation, I discovered an abandoned shipment through a Diplomat
from United Kingdom which was transferred from JF Kennedy Airport to
our facility here in Atlanta, and when scanned it revealed an
undisclosed sum of money in 2 Metal Trunk Boxes weighing approximately
130kg each.

 The consignment was abandoned because the Content was not properly
declared by the consignee as money rather it was declared as personal
effect/classified document to either avoid diversion by the Shipping
Agent or confiscation by the relevant authorities. The diplomat's
inability to pay for Non Inspection fees among other things are the
reason why the consignment is delayed and abandoned.

 By my assessment, each of the boxes contains about $8.5M or more.They
are still left in the airport storage facility till today. The
Consignments like I said are two metal trunk boxes weighing about 65kg
each (Internal dimension: W61 x H156 x D73 (cm) effective capacity:
680 L) Approximately. The details of the consignment including your
name and email on the official document from United Nations' office in
London where the shipment was tagged as personal effects/classified
document is still available with us. As it stands now, you have to
reconfirm your full name, Phone Number, full address so I can
cross-check and see if it corresponds with the one on the official
documents. It is now left to you to decide if you still need the
consignment or allow us repatriate it back to UK (place of origin) as
we were instructed.  (REPLY TO THIS EMAIL:robertmrwilson@gmail.com)

 As I did say again, the shipper abandoned it and ran away most
importantly because he gave a false declaration, he could not pay for
the yellow tag, he could not secure a valid non inspection
document(s), etc. I am ready to assist you in any way I can for you to
get back this packages provided you will also give me something out of
it (financial gratification). You can either come in person, or you
engage the services of a secure shipping/delivery Company/agent that
will provide the necessary security that is required to deliver  the
package to your doorstep or the destination of your choice. I need the
 entire guarantee that I can get from you before I can get involved in
 this project.

 Please reply this email strictly at  .

 Best Regards,
 Mr. Wilson Robert
 Head Officer-in-Charge
 Administrative Service Inspection Unit
