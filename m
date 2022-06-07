Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B441F53F9CE
	for <lists+lvs-devel@lfdr.de>; Tue,  7 Jun 2022 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiFGJa1 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 7 Jun 2022 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239607AbiFGJ2b (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 7 Jun 2022 05:28:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC83B571
        for <lvs-devel@vger.kernel.org>; Tue,  7 Jun 2022 02:28:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i66so23105653oia.11
        for <lvs-devel@vger.kernel.org>; Tue, 07 Jun 2022 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ohM259uqobJqtM7gttWurWj7P+4iDfPJquHax95olDY=;
        b=TE89Kt1rGIt7JRRPbnzM2iXymIpORAQXTec04UuyrWuDcP+smp+Cyv9xdRrziyqkj6
         A/YK8VTbwlbZ06/ZAcCEeo7ppUKFYuxCA/ItlguhjTMLETcFMgTIyn6jvIrPBAnt0tb1
         xL/pUGckrQl+jFHhLGl4KbJY0nB1UxtXVX9JwBHgVTHrMRk2JTidaZdqCSITq4a1CJWW
         uZ349h8JSpypWAuWmlxTA/QwELVW//I/2w20vw2DkdQhDm8sK5xoz9thHxF68lsF6xJ5
         oXyb5cE4e71H4s/8xqcKEXfboOM20sqrL1eVWLEsIEkNCG76hxf/uxtiKY6Tdg68AuwR
         Iq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ohM259uqobJqtM7gttWurWj7P+4iDfPJquHax95olDY=;
        b=IFQEy3e87q9RSh6vgLtiQ4gl08QsiBteYk7Io+5orslJUyivYazExJjSpuNAvgWMYK
         qdATLM3VFVZrRm0MhrJZNRXkmO08FaBurm+XGuqEn1oTKZuVRopsD2buimdcC0UYPGHl
         MRMZupy2evIj5/BgqVtnAo5q6E6K2LAJX/KLl2FxGFcNBXgW7nuXifLUQaxRTxDvtDD1
         M7q7V/9qfd7rzytovL4aUMI6CzldEJmhS+0M8N7mHDdNDIr6WgSiGj6Hmj5hKjpL/Vy+
         6a+DqIxTJrfT2fJm8H5kt9mZpD6IdpdgFuKCjT1DyXRq0Ir+z50QLFkoXWeUoNMmeRwF
         1A8A==
X-Gm-Message-State: AOAM531ZfzcBuHWQHJE8l5N3dzi7RmPktxSb94xbQTP5ydEH8TNEi6h3
        urXjY/0iIw8CApMtFpUX8bnzFO9vg0nyWml2EJwu6ocAnna2CQQ/
X-Google-Smtp-Source: ABdhPJzEyrFiOhdME5hbEgqlTFw6UCSaVE0WQK7FPK3Q1UKMKEz72Y8lGFaYsR3FGjCeg4wi+3M+LNy8M/62xGl5aPo=
X-Received: by 2002:aca:4488:0:b0:32e:b7fc:5e68 with SMTP id
 r130-20020aca4488000000b0032eb7fc5e68mr1090449oia.22.1654594098366; Tue, 07
 Jun 2022 02:28:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:99a5:b0:a2:a1fa:9308 with HTTP; Tue, 7 Jun 2022
 02:28:17 -0700 (PDT)
Reply-To: robertbaileys_spende@aol.com
From:   Robert Baileys <mercymiji.j@gmail.com>
Date:   Tue, 7 Jun 2022 11:28:17 +0200
Message-ID: <CAAD1zOabinYwsJxZbbOyRg-15RLqH57huf3pFyUA84C5VWdONA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mercymiji.j[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--=20
Hallo, lieber Beg=C3=BCnstigter,

Sie haben diese E-Mail von der Robert Bailey Foundation erhalten. Ich
bin ein pensionierter Regierungsangestellter aus Harlem und ein
Powerball-Lotterie-Jackpot-Gewinner von 343,8 Millionen Dollar. Ich
bin der gr=C3=B6=C3=9Fte Jackpot-Gewinner in der Geschichte der New York Lo=
ttery
in Amerika. Ich habe diesen Wettbewerb am 27. Oktober 2018 gewonnen
und m=C3=B6chte Ihnen mitteilen, dass Google in Kooperation mit Microsoft
Ihre "E-Mail-Adresse" f=C3=BCr meine Anfrage hat und diese 3.000.000,00
Millionen Euro kosten wird. Ich spende diese 3 Millionen Euro an Sie,
um auch Wohlt=C3=A4tigkeitsorganisationen und armen Menschen in Ihrer
Gemeinde zu helfen, damit wir die Welt zu einem besseren Ort f=C3=BCr alle
machen k=C3=B6nnen. Bitte besuchen Sie die folgende Website f=C3=BCr weiter=
e
Informationen, damit Sie diesen 3 Mio. EUR Ausgaben nicht skeptisch
gegen=C3=BCberstehen.
https://nypost.com/2018/11/14/meet-the-winner-of-the-biggest-lottery-jackpo=
t-in-new-york-history/Sie
Weitere Best=C3=A4tigungen kann ich auch auf meinem Youtube suchen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
Bitte antworten Sie mir per E-Mail (robertbaileys_spende@aol.com).
Sie m=C3=BCssen diese E-Mail sofort beantworten, damit die =C3=BCberweisend=
e
Bank mit dem Erhalt dieser Spende in H=C3=B6he von 3.000.000,00 Millionen
Euro beginnen kann.
Bitte kontaktieren Sie die untenstehende E-Mail-Adresse f=C3=BCr weitere
Informationen, damit Sie diese Spende von der =C3=BCberweisenden Bank
erhalten k=C3=B6nnen. E-Mail: robertbaileys_spende@aol.com

Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * *

Powerball-Jackpot-Gewinner
E-Mail: robertbaileys_spende@aol.com
