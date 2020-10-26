Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24732990F6
	for <lists+lvs-devel@lfdr.de>; Mon, 26 Oct 2020 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783825AbgJZP1u (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 26 Oct 2020 11:27:50 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41466 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783556AbgJZP1t (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 26 Oct 2020 11:27:49 -0400
Received: by mail-ot1-f45.google.com with SMTP id n15so8314984otl.8
        for <lvs-devel@vger.kernel.org>; Mon, 26 Oct 2020 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eubxZeME9MVo04i3g72Z1OM8ee4gR4GC+PAdwG/Au5k=;
        b=QYZuoscyQaujv+iztaxwUNJDww7d+xKaIUPvG8YIUGJuHFlUKlav9SYWWo9H0iDRca
         hw5dhEYPpoViHKJ5n2A4tnghdBn/5IqC9V+hopc2b3CY8W26mGFIRAAUu/a/MqL1717K
         YNtaQoIIE29O4x8ofoC0876OkpMGyDzpyoGYpQ8X+k4uJlMPBVs60kjNDTvgVs2YlEo+
         hZl3F4Rc9YAJoJXiC1JSL2+W3ABuVAYYu4T4TS7e8F2G4Agwq+3vlfOTMrlcG+wz5es0
         udP3lkXwTWPmiZE+jHysjq5qJ4D6a2kapWwkIk+4twgk+ICtWlSHGP/+hfgOujHQ1kio
         kL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eubxZeME9MVo04i3g72Z1OM8ee4gR4GC+PAdwG/Au5k=;
        b=gx+oRQaIRNG+ei7OGSFyuHsc+rB56A6PaKqMoD5d3MtL9qI91PEzHdMa+PxDcx2T0i
         IsfdQqKmF77+gzIcHFmj8UuiQkL2nzWKb12VoczBmuNeriEr4mvATaS2wmbAufqit/Au
         7xiXPcIpaalrRG2zMf2XZuEZtd+kvh6pGPcuFW7QpDcoem8FL01k/grAvZ8IYRWXTLF0
         ioa2uWVqY0hXq8MD1sMkkcSEuteVUMHl0Ie3vP5rEG1mU457soK6WVQ9oCSF3SUNi0mo
         mPHuv2KlT6dRA1NNxR/wkWiZb3cYIvxtCByIA5qPOvuvVGRTFQxozOTzPIZWr/TdhGu5
         LEWA==
X-Gm-Message-State: AOAM531ERef0cvqZ+2tPbKSZawnZAuRMqWvdXOVUQY0J6vLVhmdcWlJf
        lgFz/R+M0JeilEtpZ3XGhzeZ3iCVDSSZ5O4w00FEB29UmFpCvQ==
X-Google-Smtp-Source: ABdhPJzgaqr2urgHYDVXMVdHI2fxkDtxcj0YctlOvQNvTz6KM9uv7GbjrpS97XD/DWgutUC9D4YaxLiaE3tSZS9xuQs=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr11264456otc.368.1603726068558;
 Mon, 26 Oct 2020 08:27:48 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Cezar_S=C3=A1_Espinola?= <cezarsa@gmail.com>
Date:   Mon, 26 Oct 2020 12:27:37 -0300
Message-ID: <CA++F93g_WfKbVHLMUFYgQbR63o2-s8Ky_W9Z85qsFM77OaweEQ@mail.gmail.com>
Subject: Possibility of adding a new netlink command to dump everything
To:     lvs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi all. This is my first message here and also my first attempt at kernel
development so I'm a bit nervous and afraid I'm doing something wrong.

The last few days I've been toying with a patch to IPVS to allow me to use
netlink to dump all services and all its destinations in a single call.

The motivation for this came after profiling a kubernetes node machine with a
few thousand IPVS services each with an average of two destinations. The
component responsible for ensuring that the IPVS rules are correct always needs
a fresh dump of all services with all destinations and currently this is
accomplished by issuing a IPVS_CMD_GET_SERVICE generic netlink dump command
followed by multiple IPVS_CMD_GET_DEST dump commands.

The patch in question adds a new netlink command IPVS_CMD_GET_SERVICE_DEST
which dumps all services where each service is followed by a dump of its
destinations. It's working now on my machine and some preliminary experiments
show me that there's a significant performance improvement in switching to a
single call to dump everything. However, I have some questions that I'd like to
talk about before trying to submit it.

1. First of all is such a patch adding a new command something desirable and
could it possibly be merged or should I just drop it?

2. I can see that besides the generic netlink interface there's also another
interface based on getsockopt options, should the patch also add a new socket
option or is it okay for this new functionality to be exclusive to generic
netlink?

3. Should this go forward, any advice on my next steps? Should I simply send the
patch here?

Thank you for your time!
