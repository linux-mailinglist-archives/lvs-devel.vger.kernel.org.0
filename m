Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B12EF517
	for <lists+lvs-devel@lfdr.de>; Fri,  8 Jan 2021 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbhAHPrF (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 8 Jan 2021 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbhAHPrF (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 8 Jan 2021 10:47:05 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127B4C061380
        for <lvs-devel@vger.kernel.org>; Fri,  8 Jan 2021 07:46:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h205so23948399lfd.5
        for <lvs-devel@vger.kernel.org>; Fri, 08 Jan 2021 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=qEQRI9w1mli1GsRcFKGVWaC7QncCFRvO2b0CWFQU+ds9FyfXNdsjei/93HDo6tDhua
         WqQksBY9gPRtlDmrYl+VFBQrp4Si39e9AW0G2x10gqY3LfveEOgStGMMgunz+DKgp7W3
         fM03rvVxYV2AtyRADj7E6191S7tDAUczRRuaAmCuM1dqqkj58gidMRJ0C3wgWxV97cNK
         AnHxZ2Gm1u8dPxw/FtvGQimfb2UGlTrtKexWPcXHgskcBLBcB5/uroe3upGN1dKq0tax
         4QU1INHVKZrF80TE8tu3Rl6S0+4ZmwDZq0D/h1pbrT9iZaxua1KFzTeHD8O6D0e3lAN+
         Y3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=GtcFUx/Wapyp9afxnUbVVTHS7vrqEuIVo2T9S2QzynmuldoEUgCaVF0J2u8YtqhVH9
         kp+NM/73IAp2vIxO4Z17DinRWk1Y1LkrYQGr6kmIk2nA4NUQovDj2hjCVfSc1/hCbhpQ
         qHFQ1NxvNx84g/L0IkySxk2OIECxeZDrxMph4tecWTKNDgQaez/DY/TVGCsy7SPAFbLF
         UBwe1VTZfqaS/ij9QMiW9cGGZao9NTv1jrI8bpPrnSmHnTsbDVLffZqrTjVUMeLzkkZ/
         KQZYGO6Mlvf5mZ6XDlYtGggAtxq1qXNZlb002y/JxezOFtn1VrqodlHUlO9JwdNFhtKo
         ANWQ==
X-Gm-Message-State: AOAM530Fiem9MGvJCPjJS1BwtKo12fSIh1KZ6B1xrBG2cy0L2HPwZGhB
        nQM5bW2YvzeTJNwAeI+o+fhXODt87CkDeVqlHFQ=
X-Google-Smtp-Source: ABdhPJzvUv1FPWBqZ85mlWYPKtHzMU9kiqfcfkZyJj+KyztQ5cwQHCUMqrzM5Gcd9WtL+7feKRewxVpDlKY4esITblk=
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr1658531ljo.152.1610120783593;
 Fri, 08 Jan 2021 07:46:23 -0800 (PST)
MIME-Version: 1.0
Sender: nayoakofa8@gmail.com
Received: by 2002:ab3:65d6:0:0:0:0:0 with HTTP; Fri, 8 Jan 2021 07:46:21 -0800 (PST)
In-Reply-To: <CAF020ZT8J_mfHdpSC91BqOhGxEDo8x0QfRCyPaUXwXV6bDg44g@mail.gmail.com>
References: <CAF020ZT8J_mfHdpSC91BqOhGxEDo8x0QfRCyPaUXwXV6bDg44g@mail.gmail.com>
From:   camille <camillejackson021@gmail.com>
Date:   Fri, 8 Jan 2021 15:46:21 +0000
X-Google-Sender-Auth: 30mHGZl6cuPTS7QLEOGxkKP1A0Q
Message-ID: <CAF020ZRXUuoJSRnRyDE=KiaK0T2JarbhqLvz2_B9xu9-GN2==w@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDRgtC10LHRjywg0LzQvtC5INC00YDRg9CzLCDQvdCw0LTQ
tdGO0YHRjCwg0YLRiyDQsiDQv9C+0YDRj9C00LrQtSwg0L/QvtC20LDQu9GD0LnRgdGC0LAsINC+
0YLQstC10YLRjCDQvNC90LUNCtCx0LvQsNCz0L7QtNCw0YDRjywNCg==
