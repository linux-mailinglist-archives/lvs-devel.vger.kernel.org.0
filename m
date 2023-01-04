Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7346065D35A
	for <lists+lvs-devel@lfdr.de>; Wed,  4 Jan 2023 13:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjADM4P (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 4 Jan 2023 07:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbjADMz5 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 4 Jan 2023 07:55:57 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6631D0E1
        for <lvs-devel@vger.kernel.org>; Wed,  4 Jan 2023 04:55:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id i19so22398886ljg.8
        for <lvs-devel@vger.kernel.org>; Wed, 04 Jan 2023 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=WaRW1340A/QkJQWV6zgM5BJsZ0ybbzzVVpOuvHgUIbt61IugYee4YkL+IgnHuzX8CH
         8PklYjmo72EHadIxqmBsXhvyk1HIjKglPXgTzLNWzxKSFVDwjrJ+a14JYaWmHSsiQQQk
         5lo8VlUP+FEtz4Ej7i+2OwvGYZiU8fhDzKsSUIz7sjKk53z0WERF2UNyJa844SKWVYgy
         U1ZsfJaw6LlJQ1+hH+kDofCU1KBAAjCRlfb3QHEPZB3QYMgwT85yJGVRzJCtpypQEm57
         nKLP07D/PXztfZP+WumswBxd0GKB2MVQA2YBxxz/dmTacqRmDu+YWr3ZAcBN59Mkt8+r
         SUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=S9elGJkLH8aa+vl7s/EZxK3XDHwz9SBSzs7psK/8+XSSybT2jxeK3x+f7cQUPFdaGe
         kZEq1lV31/XMgNwBn5GFVo57bEq75gGJrCAnj0pEuXWcUFuOTc5P/HTrIxlndoV+UCH+
         ECcDHMwpLSuMMMeE1awq5S7MTY6nxmtRbIEGRppPLF/L/JzFrqaiQCheaSHto1rPwcOn
         lwLT4WSEl6boPTo3cFze0wYEd3uwarUYPJhfSsihJ2HxPQJv7hTphcCzSH5AmHn1twq0
         3MKEBEc+41t6PUkcY3KgZTTyKi7wVG7tsNkuErrxaQDVMMz5u9QtJkbFiAG2IR8/KUqG
         jbcw==
X-Gm-Message-State: AFqh2koooLcV6BLX1uZ0EIW9aAxvX5UgM21r54u9dp8w2hr9imQQpy92
        y6EogURFEKG5xnpPdkSMAqv2k+8dXHJqGGGd+A==
X-Google-Smtp-Source: AMrXdXskh5sw/zoJK6qGT8Fz7L58JTTqgYYR6RiJXsV9GZ6sCtTWrvyBnkR/xoAYVjpSgNphnMFZlri55LW2Wo/J81o=
X-Received: by 2002:a2e:bea8:0:b0:27f:b76b:629c with SMTP id
 a40-20020a2ebea8000000b0027fb76b629cmr2025457ljr.162.1672836935546; Wed, 04
 Jan 2023 04:55:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:58d:b0:35:ec7:21d2 with HTTP; Wed, 4 Jan 2023
 04:55:34 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <miajohn0300@gmail.com>
Date:   Wed, 4 Jan 2023 12:55:34 +0000
Message-ID: <CANx7L2_Zt=2oybS74BhKqzOwPrkFGstj7cbSajcG3F8xv11CLw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
