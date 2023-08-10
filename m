Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A40776D08
	for <lists+lvs-devel@lfdr.de>; Thu, 10 Aug 2023 02:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHJAau (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 9 Aug 2023 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHJAat (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 9 Aug 2023 20:30:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD2171D;
        Wed,  9 Aug 2023 17:30:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3490f207680so1482555ab.2;
        Wed, 09 Aug 2023 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691627449; x=1692232249;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgSnc+u+kbp/QMsiSMo1lKUz4Qdpl315YK5X8DFb5ck=;
        b=ICtwK6cXoGKdAD2t5MqAhwnUcfiuQHSt6ZuVi/uRBsoK9+fMijN5qGaVKjksRl+i/e
         1YGevAuqKdHISPNR/FtzvAKlHNzdn9qN/OHMaj6JeKuDJ7NT5SODvVf3woqMo4VKo+cD
         2ZcniWn4WmORHx02OBTqR9+CDD8On1ecV/hK1dQ8ah3pTZkR06KqTJByjXdGLlcnyO7V
         j6QUbatXwu9qRoIpz3osyDalxuD3AvSputENrAE8k8NbqKMU7rlUeJQLu1P4JBNjJw8T
         cfoj1ecgbj+nnCKyuTnhhLMNSumwbZTGANnOY6hrE+WDJdVNRr4P8DNI/ivHuMa2JTcv
         /ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691627449; x=1692232249;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgSnc+u+kbp/QMsiSMo1lKUz4Qdpl315YK5X8DFb5ck=;
        b=LE1UBHQ/PBCF6VJ9cGv8Bg2pyfHyfV/Vwuz/GnNzmitDUY98Oc3foWBxjYoJgwUPo2
         tO1SHj3zZUhWWDBYBCo40wtwJmxppt1L+1jV1dAQ0YcyzyU5jQaAdza7L8hWXohCCmMJ
         xOoPnzEWNtbrRkzKsBY6DM9z8DwWWeDPmLbCZ8NC3sJzpG87UuKEblpmpNiEmz97PtnO
         w2uGdxtt9hFdaPRmxZu2FrwmTUXFoJLnJLpMk8Hf5VJtSUxaXxuWJsl8kiBPhdBLDoza
         DkmpRPtWXh88M0bH6KFCq0M8h1Gz9o4QdmkJz9pjJNKmgjQFuCzMPgdR/10ki2MCAK7c
         4BQQ==
X-Gm-Message-State: AOJu0YyehAoTZJFpiKNHZL76oldH2+DymbDpx/Ds1SV4nKrtqPZ6NXge
        U1ydDO/yZ3AhFMSRUOVNX8nOIlDgiCEC0hTc
X-Google-Smtp-Source: AGHT+IFsZ7685N0LVwr1S4nIrtNqvG3Kr0qiZabW/c59ku0TYIplO50JG5bKMeY9ddVW6so/jNopOA==
X-Received: by 2002:a05:6e02:1b0e:b0:348:fe3b:c8b with SMTP id i14-20020a056e021b0e00b00348fe3b0c8bmr1019290ilv.1.1691627448974;
        Wed, 09 Aug 2023 17:30:48 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id u7-20020a92d1c7000000b0034587c5533fsm73494ilg.51.2023.08.09.17.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 17:30:48 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Race over table->data in proc_do_sync_threshold()
Message-Id: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
Date:   Wed, 9 Aug 2023 20:30:37 -0400
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org
To:     horms@verge.net.au, ja@ssi.bg
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi,

We observed races over (struct ctl_table *) table->data when two threads
are running proc_do_sync_threshold() in parallel, as shown below:

Thread-1			Thread-2
memcpy(val, valp, sizeof(val)); memcpy(valp, val, sizeof(val));

This race probably would mess up table->data. Is it better to add a lock?

Thanks
