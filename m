Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1888791591
	for <lists+lvs-devel@lfdr.de>; Mon,  4 Sep 2023 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjIDKPw (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 4 Sep 2023 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbjIDKPu (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 4 Sep 2023 06:15:50 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A801B5
        for <lvs-devel@vger.kernel.org>; Mon,  4 Sep 2023 03:15:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44e8fc5dc63so188032137.2
        for <lvs-devel@vger.kernel.org>; Mon, 04 Sep 2023 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693822545; x=1694427345; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqoQwotzhMNaRU2qkT/+yRd7xaxRmvW/PXDwvubnW7I=;
        b=X5fKwc00v7r7H90U9lQgfEBzH/IXLQyB6MWHesBFo0MW3thh9Si5MgBodSm8tyTNiC
         7YClFWdQEExCbqwb37Cz87NfHC8t1JtWVlpmEeqkbPFpOpCilyrvyfhVS6WmCcwG4EAZ
         yfG98/Z37SpXBnYZywW0BigHyPJ7+8x/flAgOfXfwT3QT19igWRVLWmG7cYGaUNhTnug
         EACpRt1swMvFtl34P65+zknsxcHRk0ZAQU/hIF6nqcj0vO/v0vIYgX06jlsl30rhJoWS
         YggIGTQNjuobHW8NBNWEyTA5bw6akGrrYzFLCR+tlXZD0GbayJ6C8BBA0AHd9a7gqtJ0
         AdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693822545; x=1694427345;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqoQwotzhMNaRU2qkT/+yRd7xaxRmvW/PXDwvubnW7I=;
        b=X+3TuGs5YSrcCwycu/TnuFOPCnWGsIDKrSNbdltqBXz66rVpBPNjZ/oM6QLbQ24hsf
         /AHrE8v+9ofOLpSQRjtlwrSSIo1SDhSE0YhNtn8v7JnubyX2+1oa7IUJmJemfslRB3iE
         NTJkjnaHJu2z9mzXbsdqLmvIhydHukjF+EcdV1TxLU86d/IAuVEu9F4YDKXSu0AU5NBX
         Xwf+EXMRHuVORztWJf0AEDiWzdZjyghOn4YGM8cZ+eyGOpcTzki9A8NdWo8/+yHBejpO
         aq2f1GR2Dj26vzPx+lsmFo7lqtK+vIW/bp5be9JkvU8OiYcwY8v0mOO1uEDH846JHdvk
         M1ZA==
X-Gm-Message-State: AOJu0Yxity5TT2d7aIC4qvo6sif+W/FycKkv3O7QsxGR1m5gj6Vkzh92
        GuMHI6svFv9RipaXBNDOnIUpCyPPpQwu2Guptbk=
X-Google-Smtp-Source: AGHT+IFOqEzEmzfwpZ1B8i/HJ3dtaEXCgiiUhm/JQ/OcBrhPi5oDtnDPXp21L3sk78KxeyDV9yk6/uOSem5uMAJ5FaQ=
X-Received: by 2002:a67:ce0c:0:b0:44d:476b:3bbf with SMTP id
 s12-20020a67ce0c000000b0044d476b3bbfmr5530758vsl.33.1693822544571; Mon, 04
 Sep 2023 03:15:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsnh001@gmail.com
Sender: aamirah.banneth555@gmail.com
Received: by 2002:ab0:3a89:0:b0:7a5:1da8:bbc1 with HTTP; Mon, 4 Sep 2023
 03:15:43 -0700 (PDT)
From:   "Mrs. Holofcener" <001nicole.h@gmail.com>
Date:   Mon, 4 Sep 2023 11:15:43 +0100
X-Google-Sender-Auth: oqRmgXOf-99_998ttWUyBya2lTw
Message-ID: <CAHGp-4=3yWS0aFwRA4k7opupD2O_FkyuD=wShmUDR6JhAPYTFg@mail.gmail.com>
Subject: Waiting to hear from you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:e34 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9752]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrsnh001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aamirah.banneth555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aamirah.banneth555[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Good Day,

It's our pleasure communicating with you, I am Mrs. Nicole Holofcener
from the USA and I have been diagnosed with ovarian cancer for 2
years, I have a fund left in the bank which I want to donate to assist
the needy and to building an orphanage home for the less privilege,
please reply to me if you are willing to carry out the humanitarian
charity mission, it's very important I explain all in details to you
and you must assure me that 30% will be enough for you as your
share/gift, while the rest to of the 70% will be for the poor less
privilege and building of the orphanage homes.

Thanks for waiting to hear from you.

Yours sincerely,
Mrs. Nicole Holofcener.
Email: nicole.holo@yahoo.com
