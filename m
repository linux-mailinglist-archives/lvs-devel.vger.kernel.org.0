Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85091639586
	for <lists+lvs-devel@lfdr.de>; Sat, 26 Nov 2022 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKZKs3 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 26 Nov 2022 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKZKs2 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 26 Nov 2022 05:48:28 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77131A23C
        for <lvs-devel@vger.kernel.org>; Sat, 26 Nov 2022 02:48:27 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id b10so1773077vkn.10
        for <lvs-devel@vger.kernel.org>; Sat, 26 Nov 2022 02:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wlb4SYlCkKFrC3vDbrNKcnlsbFr9aWDknzVh2AdUFE=;
        b=R/cgs0aDSiNSgx4hJpE49NhRBv4ZrqW4usaU+vpdDNJ3pas+PnhFqiGDt6qP+wM3uo
         XcyYDZ1eJZ6XqS9B6I7Bud8ap4XPXFXbCC0oyxYoaw5O47/efY0XDXDYG8crGkytSdCB
         wnM1rQeC/oDw+25NzBKlAiSbkm/u/cG/6YNMPgSmAGzyaX6AKKnW3RPAxwBEXWJBByNC
         ArhYdV6vFExeYazLjeYPtMNw38kevmdpWmE5r7IZ/rjMGMSPZo1xOh0d0xF9dZ1nkzXn
         u5KlcGVAw7VfRkyUaV/YVmB8I7zFlF72yjzqYQRQR/BC0rXSrRk459IVqc/2dE6RfY5I
         uagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wlb4SYlCkKFrC3vDbrNKcnlsbFr9aWDknzVh2AdUFE=;
        b=R/FtkFrMEE7xG50jFIICRSy75/y9Gn3i3RaCLxhWuWVxBCiaGCzcCucXNJfeQGkPjR
         Rf1p6IIxoeFls7x2ttBCe8VdBQRFeiLHVOpgBdCeb1BFgL5ArNzbVcBzYPUsHGQEc4b6
         BfdwZw/2UeE3CNxlqtfxX/8QI8fBcECXgfEizav24smVZmviu68MqGHxlsBnRFRHkJc+
         3MLyl2DvPNY+MI8V9rJone7nrQ/RcxcMB1Z38RjeFv6nPqlPPoW0kRD8+ighbmzF2P3x
         PvP5tT91uulyStMJ12hlbT3wGJORWcoYWVFq6c8tAomDl7sJbYJuT7EpM9kXZXfNuu5n
         1eXg==
X-Gm-Message-State: ANoB5pkudYAxy8pZblAY5OfEM8Ojab2emFPROg3thcsipR6Vq+gMh4Dt
        CItmEfshDQLXG+ej++ZbJIpgUQj97vo7KaJQyoI=
X-Google-Smtp-Source: AA0mqf7zaJKXou0um0Xxhr1KJD4CJuy2zlRwtp/SWfYgpPHvpwdRp/XSJQPMVu2sXFLtie0wJEeiAOhkSyHA19qChUs=
X-Received: by 2002:a05:6122:1697:b0:3a2:ea68:a989 with SMTP id
 23-20020a056122169700b003a2ea68a989mr14067005vkl.7.1669459706711; Sat, 26 Nov
 2022 02:48:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:193:b0:2de:ed04:8dca with HTTP; Sat, 26 Nov 2022
 02:48:26 -0800 (PST)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulibalynina09@gmail.com>
Date:   Sat, 26 Nov 2022 10:48:26 +0000
Message-ID: <CABeZed4gRojJG-OPYa0y0pyTRJjNavh3xnLAxhmzNTZowO+dkw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

-- 
Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
