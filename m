Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D237F2BC9BA
	for <lists+lvs-devel@lfdr.de>; Sun, 22 Nov 2020 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKVVt0 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 22 Nov 2020 16:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKVVt0 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 22 Nov 2020 16:49:26 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBCC0613CF
        for <lvs-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:49:26 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id t9so15127622edq.8
        for <lvs-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=Ir7Kfb2CRuyi38NdyXO/AfqY/yLA50txIVvf6Ffe+9WdLAReLDWbGGOlH9TN+bkfz9
         Pk87iFyQ6YAlohcmHCfNdoAiKMAkOO8iAezNkPNhTG+i8ijzgLNr49bQU440S5ODjpju
         meEcj+lQu7m0TByz3xNhcUQB7vwgmiuT+j/qhSoWEz8ijADz4YYucNoggoajrf51ha/e
         RvNBAwWOtiFd/zOT2BkDEcIbei5TDmuINYdOwiCSVKVoOzws/YQFCyWnuK9a2RFEAdMU
         AmNydMGGIERo8zHvVoTNRe7tYbIfU0mDzrGhiB4sIkUqsl1EPDtBXSOOkz7geyRxhgm1
         InNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=Rt77XPTrI/bZ1oKtD5mbifzAZ1Ct9gOkjzrv3FysilazA3wlDn6YN7NTnWW9aAvyNr
         sXrT0l3V9OosSLgl7wyuvWu6Kdjlc5bAINCEwnWrrOZuFXoCOX2ExnRuQiL6uLE6UyMF
         HGITG9vHPWxuo3G0+nfC70g3ZWHWDXU5MX3jh7Q2ixnC0kgCIVmY4yu2hUaFKACWXLLA
         Kt1/k/B5QqD49isgWPNbtIQbIgL8kx8o/+hMoKEwvzUQrZTTtSjMm86i5REXQjzpXqmh
         BhqDoEjxDQjhg4UCrdgW9QNcsiiL7upIvRsH1n7panSyjoVaaKdpUk/f5Y+bGn4lFFyl
         GtXw==
X-Gm-Message-State: AOAM531eQSTAIl6UYUrDDOrsFdJeIL0ehHL0+5vBijEWFaYEPdZ4xF5n
        skRWYB/XPRZKpFUFhu2hamY=
X-Google-Smtp-Source: ABdhPJz9PBPJNlvdIEMhlNKSWgX4SfVJtj6X0CALHPW/HAeZ9jueR6ZcdREz9j1mKtkmtRe1V8APgg==
X-Received: by 2002:a05:6402:2031:: with SMTP id ay17mr25875380edb.358.1606081764856;
        Sun, 22 Nov 2020 13:49:24 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id e17sm4016232edc.45.2020.11.22.13.49.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:49:24 -0800 (PST)
Message-ID: <5fbadce4.1c69fb81.8dfc7.11bb@mx.google.com>
Sender: Baniko Diallo <banidiallo23@gmail.com>
From:   Adelina Zeuki <adelinazeuki@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:49:13 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi dear,

Can i talk with you ?
