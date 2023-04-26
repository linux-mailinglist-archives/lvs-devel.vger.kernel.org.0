Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A36EFBC8
	for <lists+lvs-devel@lfdr.de>; Wed, 26 Apr 2023 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjDZUij (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 26 Apr 2023 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjDZUii (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 26 Apr 2023 16:38:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A9010DE
        for <lvs-devel@vger.kernel.org>; Wed, 26 Apr 2023 13:38:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74fc1452fbdso199679485a.2
        for <lvs-devel@vger.kernel.org>; Wed, 26 Apr 2023 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682541517; x=1685133517;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=OvQqWKtnHE9ZYSOGWQiek75elK/AS5J2BUX9CwuSoKShoVo0Ise6FWhfma/gcRaI2r
         4JFpmFRAaSg6hu/+VeLLx+9MW7RzVW35HL8C0/xkDeMi7k5l3LJbhZnF9vpSrFfRcZgx
         E9RLvPuGgL/NZf1ni2UWzZPMEEfn6K6xfMAEaq/PuMr4f84ErGXbrf2b6qR6UNzx1FWf
         GfyD1P15JXyIkDo2WuxInfMmiTNXfJLykGMlOOg5NvLAdljiDWZtRUddSi6ta9gx/d+w
         PIH7qejQ8/7PhlZT/zMF6mAJE0u/qFTyo62sNwWd0mHXJ3VeKm+0gMQCIxYW4WoPFstR
         2qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541517; x=1685133517;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=JLZmZOAaodxrAheDDUpBAySM7rxSWtqe2QE0nmdCG7qKsOqZvNXBf3zdSgMx/c1vkp
         PR4Q3fu0ElOgo7CpYN4VBjHAICLSGQTUL0Tcqf4PCtxrkzgXuFt4Dpj32FHcTsw4twML
         tzX/etTVUEqaaa4wXaHoxrtDrKOLJnwQwcO7RTzPtyzGv5CyBNu8+0TQqGmqfvlmEYTu
         XM81/DzN6/RUUODXFc6uDNG+MqCW98mc6CR9To+DYGIvT968ovo0c9Z0W8h8aWff616E
         Q+rxZzf8WFUOK9CHc2DgA5eo3ARrTXNXNb2diEqQVlVf98lbSdbR8o2y/LQcRkcI/189
         yuKA==
X-Gm-Message-State: AAQBX9cWsTE34s41z3ry/ci0RllLMgFcqcEfK28A5PIFPrKgDi65H2If
        IFBUj1fL9K14H2IT0ZqwLBd2XrcjMFsxzrCCYi8=
X-Google-Smtp-Source: AKy350aahtT5urGRpRt0dmA3+1cGpPY1YEGq3M9gCFbNPtkMSZ2OjV05EO7SLcW4lSbkAUDp7UiNgM2A3R68/j5eVPQ=
X-Received: by 2002:ac8:5812:0:b0:3ef:58f5:a001 with SMTP id
 g18-20020ac85812000000b003ef58f5a001mr35727525qtg.44.1682541516703; Wed, 26
 Apr 2023 13:38:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1391:b0:3b8:6d45:da15 with HTTP; Wed, 26 Apr 2023
 13:38:36 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <georgerown101@gmail.com>
Date:   Wed, 26 Apr 2023 20:38:36 +0000
Message-ID: <CAHmBb7tucZuQ0ROUiFYY3mxfmnDP64+Xz2so2JPVkRCM6-hvsw@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.
