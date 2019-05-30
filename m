Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE42F7E6
	for <lists+lvs-devel@lfdr.de>; Thu, 30 May 2019 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3H2U (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 30 May 2019 03:28:20 -0400
Received: from ja.ssi.bg ([178.16.129.10]:54594 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfE3H2T (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Thu, 30 May 2019 03:28:19 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x4U7RcC7005317;
        Thu, 30 May 2019 10:27:39 +0300
Date:   Thu, 30 May 2019 10:27:38 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jacky Hu <hengqing.hu@gmail.com>
cc:     brouer@redhat.com, horms@verge.net.au, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, jacky.hu@walmart.com,
        jason.niesz@walmart.com
Subject: Re: [PATCH v7 0/2] Allow tunneling with gue encapsulation
In-Reply-To: <20190526150106.18622-1-hengqing.hu@gmail.com>
Message-ID: <alpine.LFD.2.21.1905301015160.4257@ja.home.ssi.bg>
References: <20190526150106.18622-1-hengqing.hu@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Sun, 26 May 2019, Jacky Hu wrote:

> This patchset allows tunneling with gue encapsulation.
> 
> v7->v6:
>   1) fix type of local variable in parse_tun_type
>   2) use up to 4 letters in the comments
>   3) document new options

	May be we should fix some final styling problems:

scripts/checkpatch.pl --strict file.patch

	For patch 1/2: all

	For patch 2/2: some of them:

- "spaces preferred around" ...
- "Please don't use multiple blank lines"

	Also, in the new examples multiple -a lines do not give
much information, one -a would be enough. Or may be we can add
variations with the 3 csum options. If you prefer you can also
use 10.0.0.1 as VIP.

> v6->v5:
>   1) split the patch into two:
>      - ipvsadm: convert options to unsigned long long
>      - ipvsadm: allow tunneling with gue encapsulation
>   2) do not mix static and dynamic allocation in fwd_tun_info
>   3) use correct nla_get/put function for tun_flags
>   4) fixed || style
>   5) use correct return value for parse_tun_type
> 
> v5->v4:
>   1) add checksum support for gue encapsulation
> 
> v4->v3:
>   1) removed changes to setsockopt interface
>   2) use correct nla_get/put function for tun_port
> 
> v3->v2:
>   1) added missing break statements to a few switch cases
> 
> v2->v1:
>   1) pass tun_type and tun_port as new optional parameters
>      instead of a few bits in existing conn_flags parameters
> 
> Jacky Hu (2):
>   ipvsadm: convert options to unsigned long long
>   ipvsadm: allow tunneling with gue encapsulation
> 
>  ipvsadm.8         |  72 ++++++++
>  ipvsadm.c         | 427 +++++++++++++++++++++++++++++++++++++++-------
>  libipvs/ip_vs.h   |  28 +++
>  libipvs/libipvs.c |  15 ++
>  4 files changed, 476 insertions(+), 66 deletions(-)
> 
> -- 
> 2.21.0

Regards

--
Julian Anastasov <ja@ssi.bg>
