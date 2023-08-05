Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644CD770E2F
	for <lists+lvs-devel@lfdr.de>; Sat,  5 Aug 2023 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjHEGqW (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 5 Aug 2023 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHEGqS (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 5 Aug 2023 02:46:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09A4EE2
        for <lvs-devel@vger.kernel.org>; Fri,  4 Aug 2023 23:46:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5231f439968so1547754a12.0
        for <lvs-devel@vger.kernel.org>; Fri, 04 Aug 2023 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217971; x=1691822771;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=d9JSqdA0/mM6RZE98bMoUnvv3/DVFv/PNIO5davHfllB5fDUGeDSXAcc1NGTC7T2ch
         aPrPYqulMTcE//rE1NCa9yGLllwMZrd8I/IkzqwO/xf1YwBLE4ZyB4j9ig0icy072wfe
         Z+5GMb07gnRagyI0po9/eMUFovL/eBgWMdYFLi7N2is64C+lyULFW0Y7Qfv+RK9u5aCb
         z8PUOQ7w2jtmU5IGGYthA1ESIYrXpWPorj0g1kGkxpzqKkmpFN3SocBs9D0xO9lmYU4K
         Rk13AZu5SFJs134C35hpyQUoeoujCRBlKtUuUXnV7di6AQ4GjseE6Z2Fk0O0gEowOjc/
         WIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217971; x=1691822771;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=duR2Y2YDkL7s3Dx4vZugPZ1bC0juvTi6OlEsnL3bQtQZCBk2jGM99c4lfLH+W7163m
         jQGSbAK5VfJybLiCp0OVJjlO/GhBpGonRP1hKeY02NJSCVsIzJpFLYGl63ftB4BBNxQY
         x12rgr+T5FNJndZP53YiPWUkSlhcvuTWLVQE0IgaLc63Jfa3L/rScsZbzC83/rLGbet8
         Ockkfh7yA/W3Z//6Q3q+nERJPwTF6avWpF69e4Bsd2zuQ1dVbKP/jZAPLojsKJtMCcHU
         5iudEPteoe5CfFbTpPp40Kd6s7PZTwKET8a5b421sSOb2e6dCDa+yi/PiBsVn/0SLznb
         Ckpw==
X-Gm-Message-State: AOJu0YxiFS/rOw7AoHpGgJ3s7H7jEKVOabFiaBWqHTTCapwvYSM+l0sx
        1H1UbzXPh4LFiXReC4IpwdcrFm5Hr3W+mDpYQlg=
X-Google-Smtp-Source: AGHT+IGykQf/7koBSgDky9EajSN5O/qsrduc7rYgOXicIG1kC8WXU2kTFyWTivo9vgyPy1p4cz13l4IMzxL4CYK7NBQ=
X-Received: by 2002:aa7:d690:0:b0:522:4f6d:c443 with SMTP id
 d16-20020aa7d690000000b005224f6dc443mr3596907edr.23.1691217971247; Fri, 04
 Aug 2023 23:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:6629:b0:df:940:19b1 with HTTP; Fri, 4 Aug 2023
 23:46:10 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   Bintu Felicia <bimmtu@gmail.com>
Date:   Sat, 5 Aug 2023 07:46:10 +0100
Message-ID: <CAAF5Ruy7YoRw5_QaXJ9H=anm0vt+FKz4Jmk-xoSHB6Au1Ww45A@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail
with a wish for much happiness
