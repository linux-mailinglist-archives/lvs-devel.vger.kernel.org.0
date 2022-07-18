Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939BE578A3E
	for <lists+lvs-devel@lfdr.de>; Mon, 18 Jul 2022 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiGRTCp (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 18 Jul 2022 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRTCp (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 18 Jul 2022 15:02:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1022F646
        for <lvs-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:02:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 75so22567973ybf.4
        for <lvs-devel@vger.kernel.org>; Mon, 18 Jul 2022 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=mrphmoaV83dvpkL966qIXp7/JhNk5Yj1W4WVxjFdfwvGuJF6zDTsVA9WXKYCG3kTKq
         oyBsVB5ij5QkCDsFt/y+a3XWDA98Q0Ecc/QNrcMQJpZsdbpIBTQ/vIVw1nTsO+W8ofUC
         k5+H3IjU3SC/aVbO/OmZbADYUahlQW4TITJRHQLT38je0jtXleOMYkN7b1dDfCJ/Sd9W
         wyC5iHKuiPkBsPg6PZGYWAtDBKZOvo4vn0UqGORml9ffE8evHELkImO2zTTR5i8nfp3L
         9f3QnCcVYCFQUNXBA4aXfGhITQD518THM7CsXz010DVw5fE8m5MCS4cOI3hXY5Vzki9V
         8d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=h0ZslgqQ94UM3iGDYCZGEx8ZwvbYHY5ZrQARiO/Kpbc=;
        b=OP8tDYNCIFknEBB0zRtKtozohJgll0MociO29Mg7VBZvyBEXfs0XhWRlWpNEFqjg0I
         n3uv1AiJgIWwPa17LEX8AMQhdQXrPnVZy7jZfVhXLvxhs/OUzXg/FF91LIEyRtTenF8O
         +BBMLD8S8ws2FJWhESZ3ekNiImivGCfKdCaRt0Wn3UdEWgf9ovBcdQlCNADOPgA1nRgb
         1JFndAXibsLIQYxRIdtDJoSVgovPn0Z5+QiDRc39oqeV75IQweC/FRIn3qUiafWfyQKW
         YPg7ypQtNjGt9+5+cm8X1aQvzats6frxDJ23KCPeAST0dtWRtYQ10/IxPs86SsGhCOjy
         s6Rg==
X-Gm-Message-State: AJIora9V60anyekp/KOr5HMzWoiQXk9QqqCqcb21RYaJhWH9i1fMXo7+
        7QXXVU2Xh5o0eFIPQn5LfS2nBLQWkm6fAMwcJCM=
X-Google-Smtp-Source: AGRyM1sDaRgX5PeSuKZMJ3Cv2xUFXQfxdArdQfSsqv13KJzO6qhPl79ciFV9lLgsA8Z4+VtWwZ63Y2R2Krs7Pr3uaNI=
X-Received: by 2002:a25:d690:0:b0:66e:c2fe:bebe with SMTP id
 n138-20020a25d690000000b0066ec2febebemr30027070ybg.198.1658170963526; Mon, 18
 Jul 2022 12:02:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6919:4004:b0:cc:50ff:b3d8 with HTTP; Mon, 18 Jul 2022
 12:02:43 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <sgtalberts@gmail.com>
Date:   Mon, 18 Jul 2022 11:02:43 -0800
Message-ID: <CALPTejOurZapFesYPMOaac8TZLP+yeg3O8WyHg9KCHy3S2BMPA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
