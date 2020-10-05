Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597E284084
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Oct 2020 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgJEURc (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Oct 2020 16:17:32 -0400
Received: from mg.ssi.bg ([178.16.128.9]:39118 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgJEURc (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:17:32 -0400
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id DA8752B1DF;
        Mon,  5 Oct 2020 23:17:30 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id ED2C42B1D9;
        Mon,  5 Oct 2020 23:17:29 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 782323C09B7;
        Mon,  5 Oct 2020 23:17:29 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 095KHQ5F014009;
        Mon, 5 Oct 2020 23:17:27 +0300
Date:   Mon, 5 Oct 2020 23:17:26 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     "longguang.yue" <bigclouds@163.com>
cc:     lvs-devel@vger.kernel.org, yuelongguang@gmail.com
Subject: Re: [PATCH v7] ipvs: inspect reply packets from DR/TUN real
 servers
In-Reply-To: <20201005064943.88541-1-bigclouds@163.com>
Message-ID: <alpine.LFD.2.23.451.2010052316090.13695@ja.home.ssi.bg>
References: <alpine.LFD.2.23.451.2010041409460.5398@ja.home.ssi.bg> <20201005064943.88541-1-bigclouds@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Mon, 5 Oct 2020, longguang.yue wrote:

> Just like for MASQ, inspect the reply packets coming from DR/TUN
> real servers and alter the connection's state and timeout
> according to the protocol.
> 
> It's ipvs's duty to do traffic statistic if packets get hit,
> no matter what mode it is.
> 
> Signed-off-by: longguang.yue <bigclouds@163.com>
> 
> ---
> v1: support DR/TUN mode statistic
> v2: ip_vs_conn_out_get handles DR/TUN mode's conn
> v3: fix checkpatch
> v4, v5: restructure and optimise this feature
> v6: rewrite subject and patch description
> v7: adjust changelogs and order of some local vars

	Thanks! Fixed the patch format and posted it as v8.

> Signed-off-by: longguang.yue <bigclouds@163.com>
> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 18 +++++++++++++++---
>  net/netfilter/ipvs/ip_vs_core.c | 17 ++++++-----------
>  2 files changed, 21 insertions(+), 14 deletions(-)

Regards

--
Julian Anastasov <ja@ssi.bg>

