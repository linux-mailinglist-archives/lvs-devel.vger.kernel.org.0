Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABD61D9FC
	for <lists+lvs-devel@lfdr.de>; Sat,  5 Nov 2022 13:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKEMi5 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 5 Nov 2022 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKEMix (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 5 Nov 2022 08:38:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BE175A7
        for <lvs-devel@vger.kernel.org>; Sat,  5 Nov 2022 05:38:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so6707994pji.0
        for <lvs-devel@vger.kernel.org>; Sat, 05 Nov 2022 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=ZV2TcGDoVIbq1v5Mx1L1rUnUNhUQbze72wuOuh+wa69lbnQcoFfWFbkhfb7gZAMr2W
         ByUyHxmNJ+EgAzfkEbgt2p4DOLQzRBGtUuogzeUQqAM9RqI4JEUvU9sSGNzhT5Afew3Q
         d4OngWwLOFgISkd6x5vooHRKK9Az4aJczFzroYPLH7Dt+vGVCRowVZ5uZAV52Cgy+A2F
         D3j8/lIwVLi3bxecncjVVFxwzOJ1xg3DK6jhFVflm1wFbGzu0e/ikP7247t4mqip1Jkf
         Njk6WVMatLJ/Jf10pKJi5H9vXXx7mlCmIY7ZKhF8dEeWXppRLVuVdsqFZujt6LQJeXIn
         5+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=G9JTWpMJ9j9Z2n8lekzL/a9+QmbBBcslg0cfEm+E5Y7ERKEuRmB/WjJPnm7FWgdiWA
         zMmkrbBdz4qLrATZk9gFEGwbOgtd3vHXnevPVI/MKdmE/6AlljXL+g+E+OTqnmlk+bt7
         4PkahRD9IW9W9nwKNg1E+2eT9A3aDI7QiHEqmnpPzN+jMEg+0EzbKhZPwtSu/dhIsiLz
         LgB8KWFjl4XbxZ/SP6k4By9UUPCrwxQtIPFyqR9tGRhGymD06bOwbvQ9dxrkPFAHHh2a
         p37eYloqKuT01Y1R2Mkg3m9FxajEbWBKPHuX48lr7fL4BheNbJirlbuUid3YVuUfcM7B
         hLEw==
X-Gm-Message-State: ACrzQf1Jm1Ryp97AuxXV18DQ1Fm4lbZ+Ye3zyWLF1lCulE5KgOtu9obE
        o7Rzb01QwHOB9RpaIYBhWiWLZeZ+JsfHvPpzvfI=
X-Google-Smtp-Source: AMsMyM4kXiQfEHD7xTnbuAFjuPJHm46vGSi/KRiuWhPRjTwiHbLpMEWmL5EuXvVkMsm5T5CXDTvs4U+iY+YcWl58B1s=
X-Received: by 2002:a17:90b:4ac3:b0:213:3918:f276 with SMTP id
 mh3-20020a17090b4ac300b002133918f276mr57019553pjb.19.1667651930232; Sat, 05
 Nov 2022 05:38:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7301:2e91:b0:83:922d:c616 with HTTP; Sat, 5 Nov 2022
 05:38:49 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <wamathaibenard@gmail.com>
Date:   Sat, 5 Nov 2022 15:38:49 +0300
Message-ID: <CAN7bvZJ4rp_NOu942tGepXyrWhRuYBiZxGOwGAGice4B=GS3aA@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
