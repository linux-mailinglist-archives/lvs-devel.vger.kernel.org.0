Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0F58E9E0
	for <lists+lvs-devel@lfdr.de>; Wed, 10 Aug 2022 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiHJJnZ (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 10 Aug 2022 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiHJJnY (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 10 Aug 2022 05:43:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0450182
        for <lvs-devel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a9so20427665lfm.12
        for <lvs-devel@vger.kernel.org>; Wed, 10 Aug 2022 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=5bgCV3nNdsfNKccV4X6WE16NKKZvjGLnx1EdI1tbuwI=;
        b=M5iMsb5iqnO0LPxF8PVvyxpNZVUfICza8LFsx48SNQQn+OdsuUMLD6/4SQyQnxixDg
         EJH5VTcE87nMOOFRufNkl/vLx6GnQNyR/vi5YI0rVlONIMlFJMhRtq/BgwoiO3ts6/Sh
         Fp2+QHAEQKJL+wjOAiVc7osnbf7eHzyuZNioK3uFWleRJN7aJZCIHgs8zp/8g6lwbLK7
         CxKz7D3KvQA+UK5NUlMDmHCr2BQBw53DByDfeLe6fR/pFevEgqF66q7lecdBvMZ2KKQG
         rEWiURcqFFUHLyLuX2YGEiLRRQToEViXtQimNfzFdgcWNx12DGgumeJIqr5mN6mhgVHn
         aq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=5bgCV3nNdsfNKccV4X6WE16NKKZvjGLnx1EdI1tbuwI=;
        b=bprezZ0a9F8U23l1dngV2qjX0bIc0lhWTPkgItqwS6G3haW6wmiXSRUfjT0uglrrFa
         pqXb6G9bpe9daqTrLFbd2b1yoiUcwmFo8cSG1TqVFXqeNo904e/VIt7vNy8mCGFNouaV
         kM2eZ+VH+sxtu+8LR6Wu4Ab8XGX37I0TPJ4b+L0OfYoc8F+3NvJ8cCUjf4MNT7WL+hxb
         h1OJkl0px99XgCMnrsQbpKEl4Hgc8Pmav2qDtLofvFkhPKlNeECHjJ3JcxztTCJLEbaU
         1UGTaIIzlc8sZlXIu4OM5QkxM3ixayu4TRhWJIjReU/viQ0zXRO+8pQeQ5TCoB19Emj3
         iHVA==
X-Gm-Message-State: ACgBeo0yRqH1urYxa9sjLuI7mtGxhIM9/D6OeZZy7sOakd8ts1AV6Ry+
        UpTOnVik68lHOqMI6N3u1U1tGVpxudJmRePWVcgFZROUt84Cpe/sc1o=
X-Google-Smtp-Source: AA6agR7pD+veO9MwkxI0RLd7tAFywxOOJhr6/d3iCwfDe9fnkORx2fWMi6x/ZSPU+lfRbj1X3/XZkt38tSwaIT34/d0=
X-Received: by 2002:a05:6512:3d08:b0:48b:123e:fcf3 with SMTP id
 d8-20020a0565123d0800b0048b123efcf3mr8805258lfv.418.1660124600698; Wed, 10
 Aug 2022 02:43:20 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>
Date:   Wed, 10 Aug 2022 17:43:09 +0800
Message-ID: <CACsrZYY6aWpVOdZ5SOhDPdU+_=P0LX4=q4xCht+E-+PHRwEhGw@mail.gmail.com>
Subject: How many physical machines do I need for running the Linux Virtual Server?
To:     lvs-devel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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
