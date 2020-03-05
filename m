Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7617A406
	for <lists+lvs-devel@lfdr.de>; Thu,  5 Mar 2020 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgCELQr (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 5 Mar 2020 06:16:47 -0500
Received: from ulan.pagasa.dost.gov.ph ([202.90.128.205]:48094 "EHLO
        mailgw.pagasa.dost.gov.ph" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgCELQr (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 5 Mar 2020 06:16:47 -0500
X-Greylist: delayed 1194 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 06:16:46 EST
Received: from webmail.pagasa.dost.int ([10.10.11.8])
        by mailgw.pagasa.dost.gov.ph  with ESMTP id 025AsfdC006745-025AsfdE006745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Mar 2020 18:54:41 +0800
Received: from localhost (localhost [127.0.0.1])
        by webmail.pagasa.dost.int (Postfix) with ESMTP id 77D4229819B7;
        Thu,  5 Mar 2020 18:38:02 +0800 (PST)
Received: from webmail.pagasa.dost.int ([127.0.0.1])
        by localhost (webmail.pagasa.dost.int [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CHiicN88rBPk; Thu,  5 Mar 2020 18:38:02 +0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by webmail.pagasa.dost.int (Postfix) with ESMTP id 5615829819B1;
        Thu,  5 Mar 2020 18:38:01 +0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 webmail.pagasa.dost.int 5615829819B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pagasa.dost.gov.ph;
        s=96B9A03E-48B0-11EA-A7E8-92F42F537CE2; t=1583404681;
        bh=RC75T5p3JPNk7JUNB+lH0UfaFQO1Ac584gPL3SIL6h8=;
        h=Date:From:Message-ID:MIME-Version;
        b=YK1laF1zCZ4x5bK5XS35JE1ciQoLir/KcnGDsqGDcQvqDv9mppz8wY1QcWgS2BWyf
         1NTkWDdFzQWCMIxPeGB5jMeQe6LmaH+Vv1XgM2cjcliaFltcm7zq+L2mk/WQA+h9aF
         9iWbSt1ZNz0CqEMbXHguKFK7HWO0s3wrvqjSWfjs=
X-Virus-Scanned: amavisd-new at pagasa.dost.int
Received: from webmail.pagasa.dost.int ([127.0.0.1])
        by localhost (webmail.pagasa.dost.int [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id djY_-VVsjmJn; Thu,  5 Mar 2020 18:38:01 +0800 (PST)
Received: from webmail.pagasa.dost.int (webmail.pagasa.dost.int [10.11.1.8])
        by webmail.pagasa.dost.int (Postfix) with ESMTP id 8AE6429819A8;
        Thu,  5 Mar 2020 18:37:59 +0800 (PST)
Date:   Thu, 5 Mar 2020 18:37:59 +0800 (PST)
From:   "Juanito S. Galang" <juanito.galang@pagasa.dost.gov.ph>
Message-ID: <148084345.3574540.1583404679539.JavaMail.zimbra@pagasa.dost.gov.ph>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - GC79 (Win)/8.8.15_GA_3895)
Thread-Index: MiwLb5uCp71zH/b07Uv+5xhVjMK4qg==
Thread-Topic: 
X-FEAS-DKIM: Valid
Authentication-Results: mailgw.pagasa.dost.gov.ph;
        dkim=pass header.i=@pagasa.dost.gov.ph
To:     unlisted-recipients:; (no To-header on input)
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org



Herzlichen Gl=C3=BCckwunsch Lieber Beg=C3=BCnstigter,Sie erhalten diese E-M=
ail von der Robert Bailey Foundation. Ich bin ein pensionierter Regierungsa=
ngestellter aus Harlem und ein Gewinner des Powerball Lottery Jackpot im We=
rt von 343,8 Millionen US-Dollar. Ich bin der gr=C3=B6=C3=9Fte Jackpot-Gewi=
nner in der Geschichte der New Yorker Lotterie im US-Bundesstaat Amerika. I=
ch habe diese Lotterie am 27. Oktober 2018 gewonnen und m=C3=B6chte Sie dar=
=C3=BCber informieren, dass Google in Zusammenarbeit mit Microsoft Ihre "E-=
Mail-Adresse" auf meine Bitte, einen Spendenbetrag von 3.000.000,00 Million=
en Euro zu erhalten, =C3=BCbermittelt hat. Ich spende diese 3 Millionen Eur=
o an Sie, um den Wohlt=C3=A4tigkeitsheimen und armen Menschen in Ihrer Geme=
inde zu helfen, damit wir die Welt f=C3=BCr alle verbessern k=C3=B6nnen.Wei=
tere Informationen finden Sie auf der folgenden Website, damit Sie nicht sk=
eptisch sind
Diese Spende von 3 Mio. EUR.https://nypost.com/2018/11/14/meet-the-winner-o=
f-the-biggest-lottery-jackpot-in-new-york-history/Sie k=C3=B6nnen auch mein=
 YouTube f=C3=BCr mehr Best=C3=A4tigung aufpassen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
Bitte beachten Sie, dass alle Antworten an (robertdonation7@gmail.com=C2=A0=
 ) gesendet werden, damit wir das k=C3=B6nnen
Fahren Sie fort, um das gespendete Geld an Sie zu =C3=BCberweisen.E-Mail: r=
obertdonation7@gmail.comFreundliche Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * *
Powerball Jackpot Gewinner
