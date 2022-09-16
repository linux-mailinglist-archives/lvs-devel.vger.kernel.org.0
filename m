Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3B5BA491
	for <lists+lvs-devel@lfdr.de>; Fri, 16 Sep 2022 04:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIPCQK (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 15 Sep 2022 22:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIPCQI (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 15 Sep 2022 22:16:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2208.outbound.protection.outlook.com [52.100.164.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5367C8E
        for <lvs-devel@vger.kernel.org>; Thu, 15 Sep 2022 19:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezDLHh3zejTPQxkRjzFwatutTqenV9c4lx7aCw9+v/EBuhox69MHTXQ/C+3HB2/YnYFW+61wyhUNee1UU6hxnjnxdxJ53oTwYhLdM9gHbBD3FT36p7jQbtOZm+F/SRk8S0dPflU13MUXkiPdT+NhAmWGsOuujWfc/s0zqGITa9xm9ABpJq1yNf62edQpukF0Tq2ZOtC7EzWKBhaQK7H1yHYb9CDDAgCqG5ThoywD8V4LJXKcj7EMx8M7XWMBn++2psbUyZ819+prtCPVOwLyyOi/LVHNC2GrCRKYGFcvf15rKH2uSAWI5FMmW5bQAllaJiXv/y7wgiG+lSV1e6dImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=ITRjdjiCcSO3JqgKI5Mc1IGF4+mvHGko77OXi2VUKXTfeLBID3QbAAvEuFSgdQ+m/n8ooQMb03/t5tJ6kI3vWemnzp4KS315Ssw8WlQ4ZaI4LSWEcZmUJl5a2GV7jLTEIpuZfOH1hToDKwpu9nLeZV5+NaufmJrG8B4iva5m/we9mFvcM6OOXYQ+XIY/i+FAV1VAcLfElBsWmAcGxhWfvwf7z9M6XS/qQob27BDO8Cxp1e72Nxj5J0egnC4MNtIEgL5tVyNoL7Rw6YL8MZf2DcXcaDSoCNyN0JCuUgoh7JaDgkxO1Yg4wPKccDxmjbVTEgGPe248nKii4hixQzuFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 45.14.71.5) smtp.rcpttodomain=ekwadraat.com smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0186.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1a::23)
 by KL1PR04MB6757.apcprd04.prod.outlook.com (2603:1096:820:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Fri, 16 Sep
 2022 02:16:04 +0000
Received: from PSAAPC01FT065.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:1a:cafe::3f) by SL2P216CA0186.outlook.office365.com
 (2603:1096:101:1a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Fri, 16 Sep 2022 02:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 45.14.71.5)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 45.14.71.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=45.14.71.5; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 PSAAPC01FT065.mail.protection.outlook.com (10.13.38.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 02:16:02 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 10:15:28 +0800
Received: from User (45.14.71.5) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 10:15:03 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 10:15:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <b4840c3a-0e45-45ed-8fcc-6c3baff43551@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[45.14.71.5];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[45.14.71.5];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT065:EE_|KL1PR04MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: d1137355-1350-43cd-d9a0-08da97896731
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?NkxdFCxnOIVmOJ9KxdJ0kzpyHxGowJjMxTURMevbLfaNE+lvqamX74yH?=
 =?windows-1251?Q?t9Z1PkMJ2Zd+a0crjXOJ6w1nDs+PcTkdB+j8vUUJMHensME9R8Ib2vOe?=
 =?windows-1251?Q?YRuBHs4PePiErh+gvEXYqazFpc0I5+iCy4WTQdIMhiIEcodtnb2xeF5G?=
 =?windows-1251?Q?cOJEroMBiuuBJMKYWRbzpHcKFsrkS3WvYZl5HwFjZgDOPGc1hRPGpFX+?=
 =?windows-1251?Q?2p01Cxj0CBsxBiWUrf5MAZG8Ui8AzIfShYxXCYwLIQYZqVQQ6WSS48XN?=
 =?windows-1251?Q?pKbfhlulGiyiAbcZ4WKBstEV+JnwvctpHTjhek3uCONyC5YXA/UWScHZ?=
 =?windows-1251?Q?re9jZwrW+XDZRLXnq8gqBhKaDbaSQQ3ZXr/MEsPVxVIyKnVpZoQSM4Cv?=
 =?windows-1251?Q?obfIKayyoyv4IhEOWajAuBI5rcFdpjRbRV/l1GgXD9oOLyxLEgyv8Wgq?=
 =?windows-1251?Q?+ttsJryHgCWmhgAPbNl9qMtWvyrcI8kUyGGiPP/xDJyJSAoa0YBRRwZC?=
 =?windows-1251?Q?0efiDSZ75xAyiU/txzZAk/k/i3IUC8o/cgVPpE5HY0Iz8uE0RbM/o8r1?=
 =?windows-1251?Q?qRDZAnEbvSNASbuf8+BEqnYAPtN5ScmUWnw6DWgwnN3JXcSEb2DsBHgR?=
 =?windows-1251?Q?ZsbWKaUerPosgPYc1SRrcSPpBW/CBi+IXZQ8lt3WhNqzSwh5bQhIDQis?=
 =?windows-1251?Q?1MnCJpMucA6wJ8yB+Jh2jpp+JOlJ1oi31OuJ+ZV9++ZGTGef23hvVriI?=
 =?windows-1251?Q?IDBKjJxOyDyHk+xpUhZa5is9UYeGaCEIW09EJmL2lD57y/4mAp4cPPqk?=
 =?windows-1251?Q?QqSkeamSzFvNBtSK/RiHuaiNQC15aPkYCKfSEDZnrJD4WIdWe/LKYyal?=
 =?windows-1251?Q?QCSB6uFayT9g7HQdV3hG955LeOAiRCO3fWZlK/q1zLvxd1txIdfBJBeB?=
 =?windows-1251?Q?giFLrUI5A8ElkyTVIohPcvN9ZSlXbB/uYtxA+0S5YBWgYlUsSWkdOQ7r?=
 =?windows-1251?Q?aJfTWqlOHTbwD1siX752PlDG2bj+KA+kZwA5C1vUHAisy5P/tyWAjV/N?=
 =?windows-1251?Q?BrgC6f/NgctqgVbqv6wGOlSjzfrVmb5rqv78VvS0/kqsOfBk81HabQ2f?=
 =?windows-1251?Q?nmNT0IsFmYRzwQt0sq/1ygLPN7tDQxDmhrupZxL5BkW6cX3gbXnFPOCQ?=
 =?windows-1251?Q?XO+4O49d1i8qANeU40mb5JxHfBWUe+d6XDBoQHHPr62G9tIIu3BOFhPP?=
 =?windows-1251?Q?dezXU5t25OGFjpd900ATXh69wPzX7FLEkl+GR8MtYW+L2vyMnex1aDQP?=
 =?windows-1251?Q?xjDuNlLx3yyFA1n78eJbmGO0FNpIJgkkJS6PiUED+HcXyINX?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:JP;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:45.14.71.5.static.xtom.com;CAT:OSPM;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(70206006)(8936002)(5660300002)(86362001)(31696002)(316002)(8676002)(32650700002)(35950700001)(70586007)(32850700003)(336012)(81166007)(109986005)(6666004)(41300700001)(956004)(40460700003)(498600001)(26005)(156005)(9686003)(31686004)(82310400005)(40480700001)(82740400003)(2906002)(4744005)(7406005)(7366002)(7416002)(66899012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 02:16:02.2418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1137355-1350-43cd-d9a0-08da97896731
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT065.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6757
X-Spam-Status: Yes, score=7.4 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_80,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.164.208 listed in list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9352]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.164.208 listed in wl.mailspike.net]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
