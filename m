Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD25458EA0D
	for <lists+lvs-devel@lfdr.de>; Wed, 10 Aug 2022 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHJJwB (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 10 Aug 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHJJwA (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 10 Aug 2022 05:52:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EF6CD1A
        for <lvs-devel@vger.kernel.org>; Wed, 10 Aug 2022 02:51:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s9so15554402ljs.6
        for <lvs-devel@vger.kernel.org>; Wed, 10 Aug 2022 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=5bgCV3nNdsfNKccV4X6WE16NKKZvjGLnx1EdI1tbuwI=;
        b=iynB8oLsAkDJc9invlfVQnwDTIXkMkT+qQmagomFQlP0zdC4OvkNNeDmrgQQ+ZPcAU
         bCPEjaIkobqPIalVBNYgJDI+FXwL/iwRE/pc6+Q/LSf+oIasfWhTU1zMF7LoQnVawjrD
         bShIiPKceJIb4V4UycvVYQAfh+SZapAq/M2Ui8gSC4WtHwXCpvalbYTvZ7POKmo6Eh+T
         bTM1hGuwaPOJgoHOCHubXpAqvX4Lwv8KRSoFGLELvMBFBIh5NTwJGhA5tHW6evjcrntZ
         L+kkRnTuXWawWWnz0fbS4g+Fav7iqWX+iV6nLVRAyzkDEZVVJiC5YkUT2kJD9B5DfSNf
         whww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=5bgCV3nNdsfNKccV4X6WE16NKKZvjGLnx1EdI1tbuwI=;
        b=4uBrGMKKlevtLSll/3Dw02A0nNqNo4j0MNVvBmoqtwLWCNMIL3VC3kc/EcsSL9Sqgl
         W28vgVoXiHDBl3kxVPwyyjzrb1vSmGBfGd4UcOe2IATKr0IwU/IswWShrNzq6ha0PyBR
         ZjPXERTTQszkScZjrsPY1OFI77GR10sFCIcF2USbgiSu0bSAObQwCWc+rXQSnQqRkeyo
         9EO7wvysEihjOm5s13jbvobj28wMBb3XqvkRLZrrtDHf+07s4SJv/DdHVjoO2iLnnJYd
         2I9djPgqzpv/sdiHKZS/XG35xIMC+22zyUlQI4WEEf3nui3QKkho27GJG764y4dLtbYH
         DGFw==
X-Gm-Message-State: ACgBeo1kb6cqNkIAvQI5maQDQvfTprtDXN120FeExbg7dPSTm1yDDE1e
        Md9vS/RayjyPNvfdIpAq6VRD82lUpJqiGDariFOYRxWYgxxPebUUel4=
X-Google-Smtp-Source: AA6agR6LWTBorpUYqhlK3ffCwnrNm26VX7xN03SeJjYQ93X2Q1axG6UcPjrU94Eo0Syp7sKlSDDEDOfAt0v4Js3QnG0=
X-Received: by 2002:a05:651c:160a:b0:25a:62a4:9085 with SMTP id
 f10-20020a05651c160a00b0025a62a49085mr8752702ljq.214.1660125116822; Wed, 10
 Aug 2022 02:51:56 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>
Date:   Wed, 10 Aug 2022 17:51:45 +0800
Message-ID: <CACsrZYauHZ9FLbA-4f=dRvCOKDYdzV=42dkqgWo537hbizncXw@mail.gmail.com>
Subject: How many physical machines do I need for running the Linux Virtual Server?
To:     lvs-devel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Subject: How many physical machines do I need for running the Linux
Virtual Server?

Good day from Singapore,

How many physical machines do I need for running the Linux Virtual Server?

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
10 Aug 2022 Wed
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
