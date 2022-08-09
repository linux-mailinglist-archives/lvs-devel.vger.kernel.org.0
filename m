Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9358E2BE
	for <lists+lvs-devel@lfdr.de>; Wed, 10 Aug 2022 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHIWOB (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 9 Aug 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiHIWNk (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 9 Aug 2022 18:13:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A574219C1E
        for <lvs-devel@vger.kernel.org>; Tue,  9 Aug 2022 15:13:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so12599232pgc.12
        for <lvs-devel@vger.kernel.org>; Tue, 09 Aug 2022 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=GI1h58u9NHz7rI/vIwOU5DkUcoHPmL+b4tk5i/xxv5Y=;
        b=lXABuOK2L/14BEXnZ8vCyQLT2L2vd4DjgtKwW+LtJEWKmQyYaTaQfhuGriaR0TU/Vu
         maTYLnDSNuTwygFu2pgolfzcgwokQAqOMhjHkdVYqJd8O0EUUBNQhRnv4NBPI8zyKM6t
         XUJ4nyNX0rSM6qge0cvGhCLdtiqswjLcuNWQyMO6fp1+CCt9nMP+8HeHsfOHWv4Um5TY
         ZX8TCo/TPK8kGdEBMvJ9tPnf3wu82xR+eN3f4u99OW5sz3IVHB1ze3JZHeiwKo61fn3j
         NrXmMEGuXCE++4/mxIZW0nd6Jo0cPk1KHtZk7yMkOWK0GD6u3E4XgL2gb0+ljOfkoAEC
         3fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=GI1h58u9NHz7rI/vIwOU5DkUcoHPmL+b4tk5i/xxv5Y=;
        b=7E1ooLYLjVU/NfThlzEljxsYA5hOFxypf+1kPQqTd27ehGw52FU74yEhQqVxq/sbNP
         8TuAapkYpCvNLl7Jg0e1MgtoelWqvd5N1i+9mdGwWwZfNaNPkbmUwG2nVgbIqyb2iov9
         UT0GgZOcwF/Buy/yopLhFAYvoCVOpJPjpPzG6/mmu6xFppWz8xSoJ1sbN26TsJtC5Iaz
         MXqWCrskY7F2JoeI0SBx7r5fpn9vS2xz2R3aW8C60eX376k/Z0IWxQdPEDlZeG0Euxnc
         yeDIKfgum5qxOE1PjjUvy8coFNQ5AOzqggmgqCYsPAeM16F86QbLzgYyKJP+8vh99tc/
         lP4Q==
X-Gm-Message-State: ACgBeo0Am73hBuA6x/vU0rkWEaaIpXi9An9ibKfNAoKvjEm7yw/k2ewi
        Ua/UCbHA5p80ItCjBx1VOIRLHx6UBWlwzyc7M0A=
X-Google-Smtp-Source: AA6agR6wZ/JT5GpGETwj6xPLp6CKCSB4nw7+jruDnj/R4wPmAGfv2gDBHwHy/ayFX0NWW4gNWtfAz13h9VuH5Gp8Gi0=
X-Received: by 2002:a63:4642:0:b0:41b:d353:c5c7 with SMTP id
 v2-20020a634642000000b0041bd353c5c7mr20355370pgk.568.1660083196120; Tue, 09
 Aug 2022 15:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e8a6:b0:2d4:fb1c:cc5e with HTTP; Tue, 9 Aug 2022
 15:13:15 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Ali Moses" <alimoses07@gmail.com>
Date:   Tue, 9 Aug 2022 15:13:15 -0700
Message-ID: <CADWzZe6nqHG9_C04aakkC3jS8Vby9GB90oUhLoxr82Pv0eDbqg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alimoses07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimoses07[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Ali Moses..

Sincerely,
Prof. Chin Guang
