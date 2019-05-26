Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921322AA5B
	for <lists+lvs-devel@lfdr.de>; Sun, 26 May 2019 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEZPDD (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 26 May 2019 11:03:03 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43977 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZPDD (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 26 May 2019 11:03:03 -0400
Received: by mail-pg1-f169.google.com with SMTP id f25so7627391pgv.10
        for <lvs-devel@vger.kernel.org>; Sun, 26 May 2019 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJH8yOdBYSQpJIiPGRwtg0joAHpICqlf8Kg5oBlh5Kc=;
        b=jBzguhtPPETQGpgwUEAKHQnAvkXpOegttwv7BLoqIl30Edr3MiRrC7DmB0Ru2onzCm
         QW27jwjf4pT/EjdC2Ig6tmhm0Xjri+mpGQguOXaRNOVWrx3dItbX+ROHgiK1JyRABT8z
         jNxrBj7eAWuabkdZe3j/Tp+M6Pto6w0tFGvEkPGnu25Vm6YO3wXCHa7wofoNbmpu1WIM
         Pbk3019eciu8V2IpADFkwPaI6thfwBRqsn1HAO7ocuCbLyVefOoiEgTb+dyp5zB353ah
         y3JaMkKVJjzuytKoPsYli2Y0Wz12nR/cvA5ynmePTle0XMHp1Fow+s1IblhQ4Nrtb8Zt
         HR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJH8yOdBYSQpJIiPGRwtg0joAHpICqlf8Kg5oBlh5Kc=;
        b=GwIUb3Mt3ru9S0UQWJfFrlSgLvtwRJ1JX2oJoA3phg2DoD0YClGUY8ol5UGDkxsEfC
         v4kzE4RqNVqOcUx6ak5StX/2kT8PO8Sjhnz3qbduGSPDfoP0UJgHR/DCxOgqaLHQOXBN
         ThLl3tJJPEnhOS5Z+IoPyfSU4MU3/pvXwjzSF6e/cgKJom5HCPkxNFpe1Z+qrv9PlG3+
         bbZXBZty9HkrWKFC3w61pUWf+y2t9lUuy81vNLiqxWoRGO0XIx5x0/MDX6LKamzlTZH7
         CY5je/iDMYGh2OnzhFT6su8BAU+Jb3zFpPTF6Dp6pgR9VfQQ7+CXUml5VPXS3v2/P6Y/
         Hs+g==
X-Gm-Message-State: APjAAAWqr4oUCyMek51IH20ucCJjCQt2sBopcAMUVrTppIWRUwHvl2i7
        KJdcEUbyH1rBUmcflDzGdw==
X-Google-Smtp-Source: APXvYqyE6GtCQqYeR4CY1eAS89S3xjKz6+aBeLXL90cOxH4wmaz/Zwp+gq8thejN7smpxLbLRSCd4w==
X-Received: by 2002:aa7:9ab0:: with SMTP id x16mr120303563pfi.201.1558882983021;
        Sun, 26 May 2019 08:03:03 -0700 (PDT)
Received: from localhost (2.172.220.35.bc.googleusercontent.com. [35.220.172.2])
        by smtp.gmail.com with ESMTPSA id e73sm10670509pfh.59.2019.05.26.08.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 08:03:01 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     hengqing.hu@gmail.com
Cc:     brouer@redhat.com, horms@verge.net.au, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, jacky.hu@walmart.com,
        jason.niesz@walmart.com
Subject: [PATCH v7 0/2] Allow tunneling with gue encapsulation
Date:   Sun, 26 May 2019 23:01:04 +0800
Message-Id: <20190526150106.18622-1-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

This patchset allows tunneling with gue encapsulation.

v7->v6:
  1) fix type of local variable in parse_tun_type
  2) use up to 4 letters in the comments
  3) document new options

v6->v5:
  1) split the patch into two:
     - ipvsadm: convert options to unsigned long long
     - ipvsadm: allow tunneling with gue encapsulation
  2) do not mix static and dynamic allocation in fwd_tun_info
  3) use correct nla_get/put function for tun_flags
  4) fixed || style
  5) use correct return value for parse_tun_type

v5->v4:
  1) add checksum support for gue encapsulation

v4->v3:
  1) removed changes to setsockopt interface
  2) use correct nla_get/put function for tun_port

v3->v2:
  1) added missing break statements to a few switch cases

v2->v1:
  1) pass tun_type and tun_port as new optional parameters
     instead of a few bits in existing conn_flags parameters

Jacky Hu (2):
  ipvsadm: convert options to unsigned long long
  ipvsadm: allow tunneling with gue encapsulation

 ipvsadm.8         |  72 ++++++++
 ipvsadm.c         | 427 +++++++++++++++++++++++++++++++++++++++-------
 libipvs/ip_vs.h   |  28 +++
 libipvs/libipvs.c |  15 ++
 4 files changed, 476 insertions(+), 66 deletions(-)

-- 
2.21.0

