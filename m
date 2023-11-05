Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70A37E1718
	for <lists+lvs-devel@lfdr.de>; Sun,  5 Nov 2023 23:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjKEWAI (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 5 Nov 2023 17:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjKEWAH (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 5 Nov 2023 17:00:07 -0500
X-Greylist: delayed 5180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:00:04 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C86CCC
        for <lvs-devel@vger.kernel.org>; Sun,  5 Nov 2023 14:00:04 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 1EED719453;
        Mon,  6 Nov 2023 01:58:07 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 17CE1192FB;
        Mon,  6 Nov 2023 01:58:07 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id A8B431B8250B;
        Mon,  6 Nov 2023 01:58:08 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id L70n9FsZxJOJ; Mon,  6 Nov 2023 01:58:08 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 79B311B8252B;
        Mon,  6 Nov 2023 01:58:08 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 79B311B8252B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210688;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=DRv+Yq2kfLSODq326CY7rbdYr8B/bjHSeB1h6z0wnyYjM7oe3kENpaVlLg8nj3wF+
         ao4gVOILPEHpu3cMIsM0LhXy/Sobkpjeoi1QY5+ShNqesDJzwdk66x1pXK1r7GSq8Q
         BLdFCOAw4eV81akB4+hGJwnZ9bCgEScJm8xEHzEXiXMQqUxzkwKBbMCmCbg3hvyAkS
         22DzkuFqGCuS1UjOi3b4AvSFSB01wV2irOhV39iEldbwEP8m+QrvB4+HhgNCZ1zw+M
         b21tyWW+VNo1rKYdK3S4VfuaX65COes4MVkIpJCXNtQq1mUYrufv/vnA1FBkhx/3E2
         AfawwzIEkpvfA==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AQk08MST6VKO; Mon,  6 Nov 2023 01:58:08 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 211A31B8250B;
        Mon,  6 Nov 2023 01:58:01 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:48 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185802.211A31B8250B@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

