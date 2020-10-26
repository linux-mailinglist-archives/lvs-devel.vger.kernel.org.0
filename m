Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24E2997E1
	for <lists+lvs-devel@lfdr.de>; Mon, 26 Oct 2020 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgJZUXw (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 26 Oct 2020 16:23:52 -0400
Received: from mg.ssi.bg ([178.16.128.9]:47654 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgJZUXw (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:23:52 -0400
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 3E88F16A90;
        Mon, 26 Oct 2020 22:23:50 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id F29F816A85;
        Mon, 26 Oct 2020 22:23:48 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 5C2C23C09C0;
        Mon, 26 Oct 2020 22:23:47 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 09QKNgoN008874;
        Mon, 26 Oct 2020 22:23:45 +0200
Date:   Mon, 26 Oct 2020 22:23:42 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     "longguang.yue" <bigclouds@163.com>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yuelongguang@gmail.com
Subject: Re: a question about fullnat mode for ipvs
In-Reply-To: <1989ac03.3737.175445ba5f9.Coremail.bigclouds@163.com>
Message-ID: <615db10-72af-2a86-dde2-61af8e6bd80@ssi.bg>
References: <20201005201347.13644-1-ja@ssi.bg> <20201012000223.GA14420@salvia> <1989ac03.3737.175445ba5f9.Coremail.bigclouds@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-345138178-1603743827=:4529"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-345138178-1603743827=:4529
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Tue, 20 Oct 2020, longguang.yue wrote:

> Hi,all:
>     fullnat mode refers to  incoming packet's src:port and dst:port pairs are both changed at the same
> time, vice  versa for outgoing packets.
>     fullnat has existed for many years since 2009, why which is not in kernel.

	Not sure. What I see now is that it adds some complexity
to the code. Open questions are about integration with netfilter
conntracks (when conntrack=1), in the sync protocol, etc.

>     introduction for fullnat    http://kb.linuxvirtualserver.org/wiki/IPVS_FULLNAT_and_SYNPROXY
> 
> could we port or re-implement it in upstream?

	May be I don't fully understand the goals but
is it worth it?

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-345138178-1603743827=:4529--

