Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531AB6FE0B6
	for <lists+lvs-devel@lfdr.de>; Wed, 10 May 2023 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbjEJOqU (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 10 May 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjEJOqR (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 10 May 2023 10:46:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9A59F3
        for <lvs-devel@vger.kernel.org>; Wed, 10 May 2023 07:46:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9619095f479so1170437766b.1
        for <lvs-devel@vger.kernel.org>; Wed, 10 May 2023 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683729975; x=1686321975;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=jZv3FUrBl62Fvs9pKWQlJOarnYq6yUsJd+wINBi1wshRDPyl7808tWx74fTw07fw3B
         tqV/frHxW/L9WTUI41Lp6+Qwok9Fl3kxZimSgfFWmphb8Br7Go8RpfKGMWZ27EZjjQdd
         1LDT4T7mKJ/bfyFNdbHo65i5Mz6PSF+ZAEJDz2gC2v4HPnUXI1hsu+lttau7pl7sam06
         s89fj8ODjzmybM42E4YUuTUdmlI6Q+ICekPpz0VCiRwwCppZGRtfARGmGZ19DZwfwflJ
         UsJcb4Iaon0OzbWKU5ttUNQ3XfcnGUlGE5vgjsUZhD56e3aAUNFSjHkPYpH9/RUO+ygr
         hmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729975; x=1686321975;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=OFQiHFan3XVjAdPz773x1pOahQV+nxmxrpTpLVBWKLeoc6Ta/5LK9DSiU221/EBoox
         IxWYGcEngdj7GLgMnrocPls2WnAjr42bkxnIFUhcabq29aunFHs8/z/AlZsApUqJSnpV
         lP1Bd4QEDdKUR51TXbnk9B04MF0N7WgBjnzbB5zqhcPSSW9halSdwbNDqeYSOMqX7XyK
         CMfYrdHF8vVHtTRWJMSkyVuzm22FsdaraxHlRmebknbtwyBS3cAfBK48vzS59DHpuBNY
         pq/3xrlbkbxYzymmzrJ5YTLG4F+kOXQsgFnW9kXSso5vpPzFq34OkIh+fJW6PlYz36Ed
         YXmg==
X-Gm-Message-State: AC+VfDyhvEjiQubeqJhkMQRmz1ZJQM6xFChB7o8bHid9sjbOiKrJx4yX
        P2LxoXk/PKOz/YxTj/PCuap4YqZCTXTOXQhe5M0=
X-Google-Smtp-Source: ACHHUZ7rAhyuO6gR2eRcdghZARXnWmCCHHkGRaTAlp+LnS/OO6qk4Cd4G+ePXzhacUWe9BawVTSMvFmw82ZBcY9fSUE=
X-Received: by 2002:a17:907:3686:b0:965:fa3b:7478 with SMTP id
 bi6-20020a170907368600b00965fa3b7478mr14819264ejc.53.1683729974927; Wed, 10
 May 2023 07:46:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a502:0:b0:209:c5a4:ad9a with HTTP; Wed, 10 May 2023
 07:46:14 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulibalynina09@gmail.com>
Date:   Wed, 10 May 2023 07:46:14 -0700
Message-ID: <CABeZed5cvXFhRkL2Gq-8JnKkAhU16zGuO1fD5i1VV7iNihtK6A@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
