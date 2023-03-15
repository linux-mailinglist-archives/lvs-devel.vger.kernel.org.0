Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1E6BC601
	for <lists+lvs-devel@lfdr.de>; Thu, 16 Mar 2023 07:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCPGNG (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 16 Mar 2023 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCPGNF (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 16 Mar 2023 02:13:05 -0400
X-Greylist: delayed 54598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 23:13:04 PDT
Received: from mail.pinedalecol.com (mail.pinedalecol.com [38.242.223.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB06C49DE
        for <lvs-devel@vger.kernel.org>; Wed, 15 Mar 2023 23:13:04 -0700 (PDT)
Received: by mail.pinedalecol.com (Postfix, from userid 1001)
        id 6D722AE2C46; Wed, 15 Mar 2023 10:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pinedalecol.com;
        s=mail; t=1678871145;
        bh=PX1a+qXfAxEHThxyEDiykIvbszIgr3FWbFaJ++Zb97Q=;
        h=Date:From:To:Subject:From;
        b=iU+ggxPAA3cWOzC6MxxInoAIyIXiQfHs1erSlg+NLtSJ5uP0MQrJdGnRN5CKmhAHb
         etuH17MSvgm6QduEqVN20UmP8XxIcg1M/7QHChaltICHsHKV1wXs07eNqK9wO3RuIR
         MdcWnSJzYoW2hHwsgzlzcs/05spWWuPD1NhQK9uw/2YO+HaZ0i5dCe1kmYe/yDI1vD
         7ZfvkH19N4ji/q12KvpODIt1OxLwUIECymFCN7MdPHtVsSlfZ/Ih7iki6Q2yzot1Ts
         MCYUPvPukyYJnE0bK9tSIivx9rozZrbSsKLD2GY6z+E6W5V6eYwBq2Yxwz9zakjrwh
         ZleXnq/kKKwKw==
Received: by mail.pinedalecol.com for <lvs-devel@vger.kernel.org>; Wed, 15 Mar 2023 09:05:26 GMT
Message-ID: <20230315084500-0.1.25.7ddr.0.03io7i37xk@pinedalecol.com>
Date:   Wed, 15 Mar 2023 09:05:26 GMT
From:   "Victor Pollard" <victor.pollard@pinedalecol.com>
To:     <lvs-devel@vger.kernel.org>
Subject: Wake up - Audit time
X-Mailer: mail.pinedalecol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: pinedalecol.com]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [38.242.223.15 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: pinedalecol.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Good morning,

we provide a solution that significantly shortens the audit time, enables=
 standards control and non-compliance reporting:

=E2=97=8F Audits - to check quality or process standards (ISO, 5S, LPA)
=E2=97=8F Scheduler - all work can be scheduled and linked to the notific=
ation system
=E2=97=8F Checklists - for carrying out work "point by point" with a desc=
ription illustrated with a photo or video
=E2=97=8F Non-conformances - immediately report non-conformances and send=
 them to responsible persons
=E2=97=8F Tests - to check knowledge after training or (customer's) expec=
tations
=E2=97=8F Summary of Results and Reports - presented on dashboards

Are you open to a conversation about using such a tool in your company?


Yours faithfully,
Victor Pollard
