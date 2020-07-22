Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045B22985C
	for <lists+lvs-devel@lfdr.de>; Wed, 22 Jul 2020 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgGVMlQ (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 22 Jul 2020 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMlP (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 22 Jul 2020 08:41:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CAC0619DC
        for <lvs-devel@vger.kernel.org>; Wed, 22 Jul 2020 05:41:15 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so2337374ioh.5
        for <lvs-devel@vger.kernel.org>; Wed, 22 Jul 2020 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MRJYdBEWDkphEZG/UEdwwg3luf4wsGYhc8hRIEMMM04=;
        b=S+71BlSngXQ5LNt44+n/DUWb03Hg+RWDDq7dR5Ub7Pzs/XDeuKup5z2qu/SSHkPKIj
         b1uuXFdCdw3nM4vJFi/QIp6pestq6n5OQ86j0sPx+2gW7zuTu3XHsxSlkpOsdZNIpOFW
         3mKioPICRHEnx7009X5ObCMleBmyOkNr2ccLs6LVIQsCvChZ4A0cPSxIYWAd8hTzB71O
         xX7revvljJzhXBPoIhC9jW7O1RnMvTjhYNAZP0BIkgaGuPVd7XOcChOGAGpruLb7OFms
         1y34DrleeCI+SWcFRc/AySpAj6mCVS7ca/tYmUVxa6u0W6acH8o/E3KCGSY22m+RREMn
         r+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=MRJYdBEWDkphEZG/UEdwwg3luf4wsGYhc8hRIEMMM04=;
        b=TedI9fFRh2wd1dDfCPBbXy1ZJQsnEjKAEq8YNciH/0Wu2pOuNAmFEtHPN5W8kLe9Gd
         XqNFRYYC0h0s/uDT8XJAa7ogZpis0FP8PnS+shFO5ir8fxku9YvvB+r77YOJ9klIIiFY
         CVAHXoxAR1xkUBXYYuG7MhAFoRSBRQ7B/28iaOESXBUIJWW+gnJgMnxbRyHI2hkZ+4ZM
         nAzGg2h2R0T8DSSF1xw8SA4Mq7n5NuWecTzMoeg/fuM6K8RttwFHJy0WnfYaBeq39zKv
         74vNUnzkpbtiJLZG6PW70bWaJOfgkdIVDBuIdWUmolGXwF2h5+98bEiSS1322LHVM7yB
         SRwA==
X-Gm-Message-State: AOAM530vHXpLHxfaZc5M+Xsf42AE1tfhQGFRhhl+ft2/rPXy3QIDEuLI
        5O7BkFI+lVBwpnOsEQ587NVAc9KKYawSk1Kb7GQ=
X-Google-Smtp-Source: ABdhPJwmd9FaYrPTNKSMS94c322CTfUMF+qzrw4WHzSUt4JvTfANICAHmrk7/9IkzYksUEVZPipgxD5RXoPgxjEun+o=
X-Received: by 2002:a05:6638:1341:: with SMTP id u1mr22396644jad.9.1595421674634;
 Wed, 22 Jul 2020 05:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8c34:0:0:0:0:0 with HTTP; Wed, 22 Jul 2020 05:41:14
 -0700 (PDT)
Reply-To: jinghualiuyang@gmail.com
From:   Frau JINGHUA Liu Yang <pp094933@gmail.com>
Date:   Wed, 22 Jul 2020 14:41:14 +0200
Message-ID: <CAFu0bsxwNVreU=PmzjGbEOZA00PRTMqzyJaEir+1T44mHtMdDA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

       Ich bin Frau JINGHUA Liu Yang f=C3=BCr die CITIBANK OF KOREA hier in
der Republik KOREA. Ich habe einen Gesch=C3=A4ftsvorgang. Kann ich Ihnen
vertrauen, dass Sie diesen Betrag von $9.356.669 USD =C3=BCberweisen? Wenn
Sie bereit sind, mir zu helfen, melden Sie sich bei mir, damit ich Sie
dar=C3=BCber informieren kann, wie wir diese Transaktion am besten
perfektionieren k=C3=B6nnen, damit das Geld an Sie in Ihrem Land =C3=BCberw=
iesen
wird.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe..
Frau JINGHUA Liu Yang
