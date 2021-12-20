Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6590247B444
	for <lists+lvs-devel@lfdr.de>; Mon, 20 Dec 2021 21:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhLTUTO (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 20 Dec 2021 15:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLTUTN (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 20 Dec 2021 15:19:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA0C061574
        for <lvs-devel@vger.kernel.org>; Mon, 20 Dec 2021 12:19:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t26so22397533wrb.4
        for <lvs-devel@vger.kernel.org>; Mon, 20 Dec 2021 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=DlgK2BTyW0uEGMOdEOAYmhrBxm3/xOpQGbtYGXQyQFtHblAb9as0vDd+yZxonrTwit
         yVcXd+Fc8XAa85dREqOEJviNp7SBfMQRpJJ8ME7utRbHx+LGrrDiko4vH4S20uelLGwp
         TKP82nTMhQK6w5PB1NL4ZyuPpaZNO5KHfuo3TMyLU9nQJXSmOQp0xvMJ5XWWsm0luLsO
         /N08nsAlSgLW5tSTzXbxgMdnaNLiIpdMRc4+Xv1b9dxDDd8KaomqA1N8Lu/n1n7U133I
         Tt2ZygZcJSLZmfYlTvN8OY1n/OvT9WrwLVgBqjOx99JB4tPGpVjwBu+kOPIGglyRy4Xx
         J9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=H3O+p0G4vUFfsotS1U7ALdQE7Y9EUvm2XgiBou0qGHSS/lKgIAC516sipSuKj8Qrar
         gfHzMfFFj9jd9D6O34/PIMspF8ku5qDartTKLKIHlAhvNILHKCFSqmg0cHJgk0cOliU1
         3VihtRpbVghR/3y5VFZPoBwy9SmeuzfBabQVcsUJHjHgPcnWARmMu2EPQ/A2dqq30Wqc
         PHlJ+pSp8nUQOMnuhFUBRo/3aL8pea2Z+3Q2ercb/U6oauxDU4lgGt4E1YueV5g3ZwIM
         fP0TRtudScMNGrxSuNqaC/nCxZKKf5K5EE9PiZ8jq0Yhli0Cl5yWKUuxQ0rI4OveNWiv
         9RiA==
X-Gm-Message-State: AOAM5336zsLfpKwie81f2lX4eEXGFzgtB37gJYN/aVJqYSl2APlyYuuQ
        ghocKwkbFnap6pp2iukFTzA=
X-Google-Smtp-Source: ABdhPJyBOS5G7o4+GJ6t3bfr3D6neJqRl3GvItz2/2PjuJ8k+u7czyMjB4LGEIqRN31Gi+ww9Aq0bA==
X-Received: by 2002:adf:e788:: with SMTP id n8mr14781609wrm.685.1640031552072;
        Mon, 20 Dec 2021 12:19:12 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id c13sm11189430wrt.114.2021.12.20.12.19.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 12:19:11 -0800 (PST)
Message-ID: <61c0e53f.1c69fb81.60fed.9b86@mx.google.com>
From:   Margaret Leung KO May-y <abubakaradamishaq631@gmail.com>
X-Google-Original-From: Margaret Leung KO May-y
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 21:19:03 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
