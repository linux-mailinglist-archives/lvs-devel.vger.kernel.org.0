Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D352503509
	for <lists+lvs-devel@lfdr.de>; Sat, 16 Apr 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiDPH4J (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 16 Apr 2022 03:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiDPH4D (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 16 Apr 2022 03:56:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FC410BBC1
        for <lvs-devel@vger.kernel.org>; Sat, 16 Apr 2022 00:53:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y16so5899980ilc.7
        for <lvs-devel@vger.kernel.org>; Sat, 16 Apr 2022 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=QuVwkd6hB2s6/JF5TiIa/hWaQnfb/zHpeClq9Sg3qMVR0qGBBsuTQtIxLwuii/a0l+
         fGS0Dr0pq1IKXuSkr3DS38SFDbBZmneBvXfXn/+ARx18MHG/CW9YyUbpblq6/FxkbDxd
         8I6o/6t9mCAToGDkKe9S6vwBbxojNEbdn7XOMNHiGtCbaYfqrengar2hNdV4/sx1j1I3
         Cz4TEbafgYljICX7NnCg9M1ZXBhTKFfi+xUrJemG+Ocy7pcag926InGbAg1EuxnqLBvw
         xE+gNHseo9nYtpbHc15PmVQ4qWzNMlMWa3XXanngYw8w1Kos48RrHpeKMFvDsa19mg30
         4ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=2xQXkpxRbgMAaKDymvXLpcDCbs8dt9iXYsyyjabDUI3hwKDvn+EYg7Te+5TJ3QI4MH
         CAEuJAEaWyE1jMYYfMENZ+SaWDF9uJ7k5I1wR/hwRPBk04Fd7CJR+1itqNKS8wh9Tc2F
         Ls3UEuY3zm3POlk9RhjEVBbbci1bvWTRpm86nfKGHYjTiyzAl4oYbtkB8DX3das4WtH1
         IhBiOqVGGdrBAOGsQn7IAvCuLSt+Q+ax/W9P2+7As7zYZa3+mN+HYINbUJeEC4290He/
         HeRWdadu6ko+2ixUzsOJw3P0P3Hb5kCb2pFSZCf+0nf5f92D6KXWG/nFrZYy+H7Xjt/E
         xhOA==
X-Gm-Message-State: AOAM530eadBBrEyi9lKWK8JsbHzAicNe6s1H3uAk+gEv4oqSteehvPLp
        SNfRRuRZEDoyrpFeSYVduCBlZy4MolzzKe2Ht5s=
X-Google-Smtp-Source: ABdhPJzDQzPbz8m9UqF1QDZvOJWxKeAOhl9vj8Oe0Iu4jMGKe3CC5JMBvVEmFYAi6ZE8qoa8+YpwoyPfu0pl0kakOCA=
X-Received: by 2002:a92:c567:0:b0:2ca:fd1a:3976 with SMTP id
 b7-20020a92c567000000b002cafd1a3976mr919250ilj.301.1650095611405; Sat, 16 Apr
 2022 00:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1309:0:0:0:0 with HTTP; Sat, 16 Apr 2022 00:53:30
 -0700 (PDT)
Reply-To: daniel.seyba@yahoo.com
From:   Seyba Daniel <royhalton13@gmail.com>
Date:   Sat, 16 Apr 2022 09:53:30 +0200
Message-ID: <CALSxb2zUhViEnddVrn_NEOwbkZu4QZ5AdoTOtNn74V_mhPMAAQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [royhalton13[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [royhalton13[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
