Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2F2F82D
	for <lists+lvs-devel@lfdr.de>; Thu, 30 May 2019 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfE3IBF (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 30 May 2019 04:01:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IBF (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 30 May 2019 04:01:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so3438657pfh.9
        for <lvs-devel@vger.kernel.org>; Thu, 30 May 2019 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQ3actLmmuqUwQwFAEcEF4VMFgQyCFWm/OW+Ly/yVrE=;
        b=SOXVW86l6W2dkUD2y1GEnM8d/Pj/uOelwzuBmoA9vrAaPeYRl0W9FeyRZCaT/kyOKn
         IyZsr4/ZToztaGYpxM1TAgVi7Vr5A4LR3CA1w3u7+Dph+PufJ8nYAcCG/duJSIYqRqk5
         c1VXJFZuqW1ccD3mjV6RmJi+IyBnVxsaDOvtFXv/64TKJt2j53XuSkhAmGTOQF9ZtE30
         C7wtx23MrGqHfGxUNCWwNiQiIj1sJ+D42csxNwRwzGA7stmJZVXR9MwoTSSAZY/zGgJa
         pr3j2RM6UTQpt4c5jTyRQXA/tFwe+VnY8ENIMuUmt1itWsga+I0MmoZwLjvTOPSJUm4g
         zSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQ3actLmmuqUwQwFAEcEF4VMFgQyCFWm/OW+Ly/yVrE=;
        b=AdcMnuuFL2ciZGIJQnXNjVnvjoHXCXyWKZ5Y6DFbWQaG4DVFR8E6r0CS54yUj0lR+n
         hcb1t9IeYInucCKjA0mr7jnuESufh/Tzhdx/PztHuPR0rDfrm2d3ccbzvTVmRckIZTWZ
         yx0BLo/69xhk4VM4Ec9UM6ig2iko2/+tiKaChMAwyJ0iht8ALFw5f0QQ+h2D6tc4qfHB
         VTu2H0zI0QHNNEAyZGi1p5RxdAIEwrW7zuizDFdFgswl3lnk2PYyJUFGfxKD36bVNKGM
         /W9NVS+NhSU4Qi+Eogg836JIWwEWUV5L4+bz63MFc4dp6njwRSBaXwl8j5ewFJRK/yjF
         1kUg==
X-Gm-Message-State: APjAAAVaftTN2i2bjcRjlbtIwadgv8nN902YPmACIaKvvcGnSG6x7/xE
        0bBDQhpNvTFs3VLrUSSFoQ==
X-Google-Smtp-Source: APXvYqwKn+9mu8Hrm3h+qynQmaKzniaKIrIrW3JO2Mf+73FY6H7Fn6BSKbhi/GAZx+1p0wi5Dr/9pQ==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr2486906pfn.216.1559203264378;
        Thu, 30 May 2019 01:01:04 -0700 (PDT)
Received: from localhost ([2001:19f0:7001:54c5:5400:1ff:fec8:7fc2])
        by smtp.gmail.com with ESMTPSA id f11sm8124229pjg.1.2019.05.30.01.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 01:01:03 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     hengqing.hu@gmail.com
Cc:     brouer@redhat.com, horms@verge.net.au, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, jacky.hu@walmart.com,
        jason.niesz@walmart.com
Subject: [PATCH v8 0/2] Allow tunneling with gue encapsulation
Date:   Thu, 30 May 2019 16:00:55 +0800
Message-Id: <20190530080057.8218-1-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

This patchset allows tunneling with gue encapsulation.

v8->v7:
  1) fixed a few style issues from scripts/checkpatch.pl --strict
  2) use up to 4 letters in the comments
  3) updated document for new options

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

 ipvsadm.8         |  70 ++++++++
 ipvsadm.c         | 426 +++++++++++++++++++++++++++++++++++++++-------
 libipvs/ip_vs.h   |  28 +++
 libipvs/libipvs.c |  15 ++
 4 files changed, 473 insertions(+), 66 deletions(-)

-- 
2.21.0

