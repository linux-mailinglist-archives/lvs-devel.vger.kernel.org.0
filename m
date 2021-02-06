Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D67311DC8
	for <lists+lvs-devel@lfdr.de>; Sat,  6 Feb 2021 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBFOjA (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 6 Feb 2021 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBFOi7 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 6 Feb 2021 09:38:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F34C061786
        for <lvs-devel@vger.kernel.org>; Sat,  6 Feb 2021 06:38:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i20so9862828otl.7
        for <lvs-devel@vger.kernel.org>; Sat, 06 Feb 2021 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=XYtszzE/LpsbnaOMbL3i9ek36+51/HV8infauGGc6JaIR1GnQCdJ7/Ds54KZgDytKR
         GrbOFZZrlAKdoP1HWZ31I/tybvcK+AP/bDsHKiqpDpAlXEpcDpCa0mYuflpZTxUVQ4qI
         H+dd8GoCBPz1SVY95lMzAzSvN6vUMgt3AW7qfgZLpC9eal6ImbEeoagHUm3JbcCgRt6g
         iJvYlnLvTYFZ6FV+ydcHXcBPX5NUmPYUeOqAYFNZvf+Dd9zbXQt5Z9rpAkKLwysww/m6
         7bUFq/PIuL1O464cmeOvkQiSYFtdQ8879hE/wINpEd8ORGfl3409wl1BIuqsmQ+kP2gC
         6cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=RLaEe4PWqqte+vEBZxrYgOVByNLf7CvA6OhBKQoCDN06cWfMWDT3ef7uQI4BehDqya
         NCBDsfE3yb7ZdKD9jtHZN459GPvn0E0oXVJrfSI7L2jd0NPzM53vHceWzj8jA0T+SoW+
         UU25g7lws6OAT9cRcYAAeVSM55p8qHUQhosaNPfSjn8+MsJSUu6erZaAae9wbthQd8F8
         0sOQohORNJGygljGFjnRuQ3cCKJP6RnDxhLFHtkzA08avlnwCj4UCIkyxsiMplhU2vzV
         hvgBmhCjKp4Hh6KVuDScD6k9Lct4sp3Y9qmNognp5izKRDAorGT6m0m9zJE2Nd9I6u8D
         ZwcA==
X-Gm-Message-State: AOAM531yjaQrsyVRabJsc/xS6T5YbMygu1jcYy6eXebt+38lIwyMrF33
        HedRG2y38Evb/mCdGj10l5mjiY1djqfYhNavxIQ=
X-Google-Smtp-Source: ABdhPJwUKNaKhQgD18aXLaGI1VUUqx+mmipeHKQay5fg9bMqMiX3U52bBqmDaXfmT0RLeuR5O3e/lB3MO8VVlccjwJk=
X-Received: by 2002:a9d:6056:: with SMTP id v22mr7041213otj.266.1612622298539;
 Sat, 06 Feb 2021 06:38:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:38:18 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:38:18 +0100
Message-ID: <CAO_fDi8mto=dAz+hr5DM6gTY1yjhGRPbwgY-QXyVfXCJW3AKqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
