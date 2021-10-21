Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12E8436AE0
	for <lists+lvs-devel@lfdr.de>; Thu, 21 Oct 2021 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJUStw (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 21 Oct 2021 14:49:52 -0400
Received: from ink.ssi.bg ([178.16.128.7]:36883 "EHLO ink.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJUStw (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:49:52 -0400
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 0107C3C09B8;
        Thu, 21 Oct 2021 21:47:34 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.16.1/8.16.1) with ESMTP id 19LIlXG0027227;
        Thu, 21 Oct 2021 21:47:34 +0300
Date:   Thu, 21 Oct 2021 21:47:33 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Alexis Vachette <avachette@deezer.com>
cc:     lvs-devel@vger.kernel.org
Subject: Re: netfilter: ipvs: using maglev scheduler algorithm
In-Reply-To: <CAP962rShHbVtXNONwRWda6xAZ_L8kVWTSNZc_bC=gCetUMpNHw@mail.gmail.com>
Message-ID: <2bb21c12-d8fa-acf1-73f1-67a996e6b98@ssi.bg>
References: <CAP962rShHbVtXNONwRWda6xAZ_L8kVWTSNZc_bC=gCetUMpNHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1216637008-1634842054=:8245"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1216637008-1634842054=:8245
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 21 Oct 2021, Alexis Vachette wrote:

> Hello everyone,
> 
> If this is not the correct list to address my issue feel free to tell me.
> 
> We are heavily using Netfilter/IPVS with maglev scheduler algorithm
> and it's working great on most use case.
> 
> The only case when we face issue is when inhibit_on_failure option is enabled.
> 
> Here is our setup:
> 
> - 2 LVS director in active/passive mode
> - 2 backend node
> 
> Exposed service is SSH using port 2222.
> 
> You can find below the LVS state when issue is occurring:
> 
> root@dev-lvstest-01 ~ ❱ ipvsadm -L -n
> IP Virtual Server version 1.2.1 (size=1048576)
> Prot LocalAddress:Port Scheduler Flags
>   -> RemoteAddress:Port           Forward Weight ActiveConn InActConn
> TCP  172.16.42.170:2222 mh (mh-port)

	If inhibit_on_failure sets weight to 0 you may need
to add the mh-fallback scheduler flag to allow traffic to
use fallback server(s).

>   -> 172.16.42.168:2222            Route   100    0          0
>   -> 172.16.42.169:2222            Route   0      0          0
> 
> Here is a working example output:
> 
> root@dev-lvstest-01 ~ ❱ tail -f /var/log/kern.20211021 | grep "172.16.42.170"

...

> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590633] IPVS: lookup
> service: fwm 0 TCP 172.16.42.170:2222 hit
> Oct 21 09:17:34 dev-lvstest-01 kernel: [   75.590637] IPVS: mh: TCP
> 172.16.42.170:2222 - no destination available

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1216637008-1634842054=:8245--
