Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827352C719
	for <lists+lvs-devel@lfdr.de>; Thu, 19 May 2022 01:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiERW7z (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 18 May 2022 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiERW6f (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 18 May 2022 18:58:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295E185424
        for <lvs-devel@vger.kernel.org>; Wed, 18 May 2022 15:57:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2fedd26615cso40030017b3.7
        for <lvs-devel@vger.kernel.org>; Wed, 18 May 2022 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=OlFXN1eUBDDeH6maPNBU0CLent/60Oo9sydON0U2hmnm7MDA2BlH640BXaM6qmW1H8
         E5k2ld1b0Z/cr91IW2JYQ1JTEHKAYxAwTk4XjbO6T0n8IhGQQFclRdcj+ecOnpbrgLpc
         Sk+wLB/mTHyDuo1bFdT4tl7KIstEQivdO9ReiezxKIoFmiWYzWAIqhvXlX3A02mV2i8T
         fZlO3WLVewUGskFDhzzK7I8ijY6zXtMPbSmI0oy7gY2Swo3+Y3LJmUHIYbk+FTzJ/kv8
         JOWljwzhZwL4fSazVm9/+D9T++xX+c+dU506WbfXM3k8nbJ4m3KAtuR8F46d+8D8WK80
         9LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=xHUnVmDcVzhC1k8G1pP5hU4P6WAaFe8BIPv0o/1IFRmtPm7mhctTaiyNtoxD8pzsYV
         P50yVUGqbN5TdzdaPUmE8Si4/hE8oJlTBld1BJpwDu8hD/w2nJUdGVtA7Jd60Rkg7Qnp
         VbTBeNsmxsB05wCvwiBQOjcjGSgpUssB3FmhhEcjESnGlnuTZlIXjbUWJfLn1Z8GZF9z
         8Kxk8Qhl6vp20QWd5O/MtUCXcck2u4tH1csKzW/2t2W+sFNJ/m1sIeT7hsGvZXAJ95NF
         humef+8tMd4cPN7m2FeQni53rs+jQJmXK9nx6sxBM8/jJLpPh9kezbnjJlIaCEtSpZ4i
         5zQg==
X-Gm-Message-State: AOAM531wgzxkOAQvpCezqUEcS+LDKRdzgK3jwoXV4jOdPBrcW0dCc3rb
        bgNDVYrBlvyoiA3f7MQxCbe2R158jN8+HrSBovM=
X-Google-Smtp-Source: ABdhPJwyUPs8n1hxffrrniykXlg6DyPFwxRqOv9G+BHetoiNPma/QRRuCBWfc1ziheuH+jNHDYLiG9u6ddv9DLlJGNg=
X-Received: by 2002:a0d:e444:0:b0:2fb:94f3:73b5 with SMTP id
 n65-20020a0de444000000b002fb94f373b5mr1800733ywe.59.1652914649917; Wed, 18
 May 2022 15:57:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:57:29
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:57:29 +0800
Message-ID: <CAE2_YrCr5V0pjHRb_r4r2=1YWoJakhqtt40TbSSNzu9MDs9UZw@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Can I engage your services?
