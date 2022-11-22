Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D613763328E
	for <lists+lvs-devel@lfdr.de>; Tue, 22 Nov 2022 03:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiKVCCD (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 21 Nov 2022 21:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiKVCB5 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 21 Nov 2022 21:01:57 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF318E0695
        for <lvs-devel@vger.kernel.org>; Mon, 21 Nov 2022 18:01:55 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id s18so15715811ybe.10
        for <lvs-devel@vger.kernel.org>; Mon, 21 Nov 2022 18:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pu42MunT7HuGSf8TtaVVshZBTol5G/rOSQf0WM1IiWk=;
        b=c5WWtMtTouPC8c2M9c2kr4zYZfMDt6hQRLeUf2LxO44xUoy92vcN/O1vhr+VtxpKKX
         gC0Jt+SvfS4of8V+yfHGiaKl7h4Z9qHbbjsFelizP+XechPsr/Ig3mIDhP6S/g6MLtAj
         mv0mr8b91OU2Rsb74sCOIbr4VLjFjqZufrBmLQpfEnXJoE6tKh/qs91Hl9D0lPkSPFog
         HJZOyYUWlZmu1ymKc4JbH4seBaxZt2Z51ux8Z/FDpPLLJp18RFsX81L6un4yPpXe/Uog
         9XqKx00m7y3qT2vS/mS5XWrnFqEV7SLKoGUZQK7eS2CQjG9Daa+bch70FaeuyescMMS2
         qx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pu42MunT7HuGSf8TtaVVshZBTol5G/rOSQf0WM1IiWk=;
        b=2LuNxXwQ2rOWf1uUGIqtqpmzGZf2/lMrc4ZmSQ8O00DiFckHhFvTnSQ1OeO7qlYrS/
         w0JC73eSwIhUFgnkDHpaPvebLk3+DBkOYvuCmaZTbfojgovHsaGTTpE/ZOv+dG13+kYV
         BGq3IEIvAhjcjClKyxzD+Tz/EdA1L9TLmwcndUinEfIjKXQTCkQvg7cia6O3ICdAobwb
         ekVvilcGkBn2SvVlgrV1kJvLQcLXhBqGY71WHwku9vtVl+wKAkR5msD5BesD+XOUyNka
         IG1+bSN4Ll72mV8oarZLhcled/IABHfCNnHwz8tdN9P5iiVUNrest65aaG+2mg6n9v/3
         j95w==
X-Gm-Message-State: ANoB5pnbxBtOgxUGKGhUTVTMO2pXU831zrmdXU6XQkTdrtb3fh4sFgx4
        UfVQgBGdEvcw7ZsMH6bdLqkV6MfqJJjEFOnG1LTNHBRAZEleqI2N
X-Google-Smtp-Source: AA0mqf4h381oJTfMaTfS+xFtvLgx2MkIZch0Ugz2jEdHh1BsL51mvKh/67HiGdR9NlZSB94VG9Yzd8kdg+ir0hJ4QzY=
X-Received: by 2002:a25:bdd2:0:b0:6d7:5dd5:eec1 with SMTP id
 g18-20020a25bdd2000000b006d75dd5eec1mr3294051ybk.67.1669082514828; Mon, 21
 Nov 2022 18:01:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:9f88:0:0:0:0:0 with HTTP; Mon, 21 Nov 2022 18:01:54
 -0800 (PST)
From:   Felipe Bedetti <felipebedetticosta@gmail.com>
Date:   Mon, 21 Nov 2022 23:01:54 -0300
Message-ID: <CAFO8usxY08Ey2qs1n_-VXnbqKFRtK8brBGDdo5eTbL3Cb9AYXQ@mail.gmail.com>
Subject: Re:Norah Colly
To:     lvs devel <lvs-devel@vger.kernel.org>,
        lvtexan77741 <lvtexan77741@sbcglobal.net>,
        lw heringa <lw.heringa@chello.nl>, lwa <lwa@teaser.fr>,
        lwainwright <lwainwright@nisource.com>,
        lwalker <lwalker@simplysay.com>, lwallace <lwallace@esc17.net>,
        lwalls <lwalls@insightbb.com>, lwang <lwang@ithaka.org>,
        lwang <lwang@messagesoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_PDS_SHORTFWD_URISHRT_FP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5153]
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [felipebedetticosta[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 TVD_SPACE_RATIO No description available.
        *  0.0 T_PDS_SHORTFWD_URISHRT_FP Apparently a short fwd/re with URI
        *      shortener
        *  1.6 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.7 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

https://bit.ly/3XvVv2n
