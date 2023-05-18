Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BA707CE3
	for <lists+lvs-devel@lfdr.de>; Thu, 18 May 2023 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjERJaN (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 18 May 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjERJaM (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 18 May 2023 05:30:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284292122
        for <lvs-devel@vger.kernel.org>; Thu, 18 May 2023 02:29:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so280818566b.2
        for <lvs-devel@vger.kernel.org>; Thu, 18 May 2023 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684402192; x=1686994192;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=ip3VwFMhd0/gsbLPeyblqtJK83rIEIgpC+1wj2brgyyKA7TtC82RrjfOMscZexla5y
         la/iOLYuJZUz5f1/35+XTafliDkIHbyqDzl8bp1AH51IG5LvDZq/U/z3OX310g/I6CMz
         jqtV/0QjqLXpP1u2ePU3HbdXxIRHhFx1A+S4DBohRhCSzpameao2SBDWcByGpbYTkZmk
         kmnX/Ub5w6CFCFVulht3a6td9RZk3Ctu8PyEmr2iRMP3GAClyt22cuuQz2HJ4LW4qUA+
         XffQ1WBTd291jpy1RkGBLi2MhGXpdiNblkwNzkvyOLtJ6eqwzsLRUlWaq8xo5KJ2Hiom
         vTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402192; x=1686994192;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=j7k3LhMbtgrLLItGuY2bLyNVNGnREC1cQq3WCrRv9MOLkMuO1UANq7pw5OgtNFR3Cd
         k86WRySKuf3VLXM5wbBsjJFwxt7T9GvQilPM4jI1zIkNaNx2mr3NCvKEeazHJcTgxdpS
         5cMWqE88yX/grzY6H89EIr1QhRM8V0xKh21vKJ9YV3rl85/WQM4idF8g9f/T3BpkIDtk
         eNTLN2FE3uM4WLC/cXAbfUceorYnoKg18aLzbVFbAvGcPRVMCsRqxhxOwMpkSxb41CqL
         wQJRd8T7C2oxIYJe8jGFsA3x7FjQOcbC0HWXCPVANAXR2jx4ZvXUHi9y3bYjZRX76iVW
         BjqA==
X-Gm-Message-State: AC+VfDxcETWb26zeOX1862DfURwGckyXhVF8QT5BbW/LAq4FZ/v56LNx
        gkyoAmeuFhh/N9SjMHJNmDCWhXsOqIQPwvaD4+E=
X-Google-Smtp-Source: ACHHUZ7ymR8xg6gmlimJikqdTdN9EwjsIAMtiY6mantPHzxDcOMsx6EXIKP09xGuiPoZExiZXrKbbCNsxKb4RZ6Zh7M=
X-Received: by 2002:a17:907:1c23:b0:966:2984:3da0 with SMTP id
 nc35-20020a1709071c2300b0096629843da0mr40602921ejc.63.1684402192335; Thu, 18
 May 2023 02:29:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:dace:b0:94a:7e28:ef2d with HTTP; Thu, 18 May 2023
 02:29:51 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly013@gmail.com>
Date:   Thu, 18 May 2023 02:29:51 -0700
Message-ID: <CAHS6EwUN1hPTfwdP2X6-1hjfuShzCTkxBJQqRaJ3H7yU8uGBLw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
