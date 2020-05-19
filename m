Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338BB1D9A35
	for <lists+lvs-devel@lfdr.de>; Tue, 19 May 2020 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgESOl7 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 19 May 2020 10:41:59 -0400
Received: from sonic305-21.consmr.mail.ne1.yahoo.com ([66.163.185.147]:45459
        "EHLO sonic305-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgESOl7 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 19 May 2020 10:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589899317; bh=5gCyJ+OqEpp5mbAlNtNv58P62XCklDNCTlGARRHXZQA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uVtCbM7R2CFu7IwU9pVGS/z9ygJ++qSD25kJE1Ji3O6DdgMCCFBMr48IA5FGDZL53/1nPeMsu8Ibn4HMK6lXQ1xoFM+08NDl3gz7MTjSfqU7NXpBDR2lmWf6bj/8qrvfC+O+F+5tcFY0pSFIW/Kn1+e+ob8reHXY7Couy9iApPYx0IJsqcpQo/FxJzWeE8FqKmXV0crF+4VHJwwbN6G/ESrbquQlEOlhiPed2UfKfKLqblzn9DXI+IP7tCdF4hyctqRE8zj0zHED3sgwYJrk/yzvd0xEF38klBiG3yxU3LDwiPIhr55JPEGzcZJRLa2NDPuTe0DzC3rsSU33O5HP8Q==
X-YMail-OSG: LSDcslsVM1mtmk.HRyhhg2LVQplt3mLozXKUajASOb3OgOr1KtXApvvzucQoHT7
 PT.xSa.VHNa1Ml_IgHcKX6nrX6WuWBgKUjeoSeQXqjMIkGF08IZ3cnlvCcxdVMnvWjtzHdBTeFr5
 0YDDTDkvvkairDVHZjLbHwnqb2MV_PQFLahr4XQXIfVBpX2PEXoZZwKcka7Df8EU6J_cP5wGi_CW
 2ha9VJV7Pyk48uOZLUdpKKdK6dK4HSUT5eapp4XSF2.KAGF5tcW5ieZl0EWT3scg28Zr_HCSin_V
 V0pba832Jw38cBTRDNElFlh1IJLz84oM6bGDU0osgRa57vHfsFhQqLmg7ikPIXEQpsrQX5XACY1F
 M0TJxgESHto9S_nYLu9yzm9sUng4dEqBCgbBipLQL3nPLMhuRSYMLvbmJnWcIvQFT2YO_lPrc6nv
 6XVnmE1y.cfw5ld45SwCMhJCm1g4Zo0_djVVB2YVhAjOGIC35YUPkVJwQax8sl.cS7KoyXn6WWHy
 eApiCz2ROTYVMxSlm76VMVCyTBwhFm.Of9ztI_WWbWplgJ4n3_dPw3AsV6NOH8UYrfk28grxCB24
 DtV8Gn29hgXJfg5eLKh4MfKU59aS_i64NbOiGhU5cGgrprotc4C9LSTgaiV4x1YSEMBKtFvzos_1
 zCw2CnO70bDtX4vTv.LzmI6IDJDGZl.VxbastebOFMYQEojziripD1Qbb6VDw1WFl_W8M3KK2DC4
 cmClYvB5bjwTgeI2rfYWLy1RbdjJk_CjntlHVq7s8KcG3DxqEMq22uzFVa.bxSv2.QfrY5x8wf39
 b1LQax87vKygfIwk5ERPXZfQi2IPaaAZnGbAYT_arKJvonMjrwIaOphocW04qdTEdWaXXPtZTRFB
 woa_qp31GZZtJDnPuqnA1KXCi.puFFrX49_x7lWgpEuqQ1U4rtbLBpSbA7HdseS41Ssc.QoB_BhI
 YnmqrObQ458KzSbg4wb4RgXqpck9U5ZsqBWTiY2k0nQ7J0ecZXmsMXtBR5wWbNSP2vPGAknP0AKm
 NBV7SmjbKdU0qWY5D0UxAKNCMRWHlUHxXryAG45T_fvhKEGtsXoEglJ6oHtd1PuCd2Q8xu7D0mAP
 qPAUdEF.ToprFL6bCmkXv5SgnNeqa33S_Ta65T.Aom4MFv33k_dlb.six.zQf4hBQa1s8knKAAAv
 mI6433li8ZTCvXzeyg0NMnCDfATRXmmA_y7Hyv1H0bI0wgvamwR.URU0CwWf0Tk5QL_TPK6RHQDF
 br4AnDkq4cwQN2yvRUlJUyyoO.1f2ZwYQ06lM0jElguCuqIfHzCj4DXTyk5ajCAqbJ5w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 May 2020 14:41:57 +0000
Date:   Tue, 19 May 2020 14:41:54 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <1491118023.1489328.1589899314572@mail.yahoo.com>
Subject: Hi there
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1491118023.1489328.1589899314572.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Hi Best of the day to you I'm Rose by name 32years old single lady, Can we be friends? born and raised in London in United Kingdom Take care Rose.
