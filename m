Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A38570A4A
	for <lists+lvs-devel@lfdr.de>; Mon, 11 Jul 2022 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGKTFO (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 11 Jul 2022 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKTFM (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 11 Jul 2022 15:05:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CE37193
        for <lvs-devel@vger.kernel.org>; Mon, 11 Jul 2022 12:05:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u13so10252117lfn.5
        for <lvs-devel@vger.kernel.org>; Mon, 11 Jul 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9uj+gt0nlN86Hh2HhDPU+Dz5M8xxhS8LxhKLS5xLSBg=;
        b=JtrFuQ7pIivNs3w/3tGUcDjAh137lBPCO5uVD9tMAqN9/43j0SK1jIQPjOd0kFsmvF
         zs96+SHH/uwAQyr6inXysJa7wIBN9Qqcr9A/S3C1qdz+hCElMKznxJkG0WwHxjnSXkZC
         bRpJxXYMTBo7hgXAj+AgCVH8wI3WCcTQ7j4CyCsie3ntT3ZzAUvK9CerbhAywdjqWkPS
         1fsz4sekOOhx53pgoCuVzJ6ekZYDhYPnB8X0f4ySs2utdAR4AIlMhFBzcINmdpy5xLQQ
         WsXO0gAY7rO0kx9xctZPj3zlnb0dtQYpLcTUbKIfdOYrsi+Fhv6ewoNSZgRTtRDIpl8C
         dmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9uj+gt0nlN86Hh2HhDPU+Dz5M8xxhS8LxhKLS5xLSBg=;
        b=tmOeNqcTRNNZvKrFSHu3bNIpQMQeO/108E4hDsLUZ3RPwQ+C4fN81StdAgwLi7Kz1G
         yw9ouor/Fh1+cgzfGCRxiYRVpmOxvxMxpHKBd7j0rTppEHaM/QdJlMhF0fEi9DKWOVZu
         gncImxu0fOn+uIlsvE8+cqvVjP3tqsUkir6CbFju5tolEoYv31rTQavJTVbtTcbZvisY
         6vVoRHS512/9P27b8vRVMcKcPK1JmroaWQH5BUlhNWSf9JJ1eia/ur21892Ql/J03DXJ
         iYAoi0/G5sfu1GkXykgrYOvTez7V6BZSNplQVGn64ZKNd7dRhnuFUBcih8rh7z3M5Go2
         eTuA==
X-Gm-Message-State: AJIora96JG7UtXEY3tv/quyHNdCo+0ULI28DxYzDobm3oWZXdFO/0Dc3
        0n1+geDrzuaH2pKhR1F2wTkHIJJILZwBKRyEI3w=
X-Google-Smtp-Source: AGRyM1vBhramakwcjkrNxaqiizveTRpMdm+1dUNMcy8eal8vDk7Diad7/BRqQ/mP6LZ17WYOW8nLHZrsFBtKVWKvLA8=
X-Received: by 2002:a05:6512:3d8b:b0:488:80d2:5960 with SMTP id
 k11-20020a0565123d8b00b0048880d25960mr12447060lfv.331.1657566309281; Mon, 11
 Jul 2022 12:05:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:ca1:b0:14b:3472:6627 with HTTP; Mon, 11 Jul 2022
 12:05:08 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL GROUP <jamilahusaini6369@gmail.com>
Date:   Mon, 11 Jul 2022 12:05:08 -0700
Message-ID: <CAK38h1f7JhmLxWtiq-6Ny-yJsRdm1Xw0p9WOJKNHSQH+TZUFEQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamilahusaini6369[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamilahusaini6369[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--=20
Hey, guten Abend,
Ben=C3=B6tigen Sie einen Kredit, um ein Auto zu kaufen? oder brauchst du
ein Gesch=C3=A4fts- oder Privatdarlehen? Sie wollen Ihr Unternehmen
refinanzieren? oder investieren? gr=C3=BCnde ein neues Gesch=C3=A4ft,
Rechnungen bezahlen? und uns auf Anfrage in Installationen
zur=C3=BCckzahlen? Wir sind ein zertifiziertes Finanzunternehmen, das Fonds
aller Art genehmigt. Wir verleihen Privatpersonen und Unternehmen. Wir
bieten zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz von 2 %.
F=C3=BCr weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com....
