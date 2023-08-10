Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115C2777036
	for <lists+lvs-devel@lfdr.de>; Thu, 10 Aug 2023 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjHJGUn (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 10 Aug 2023 02:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHJGUm (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 10 Aug 2023 02:20:42 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142789C;
        Wed,  9 Aug 2023 23:20:41 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id EE5BCDFBC;
        Thu, 10 Aug 2023 09:20:37 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id D5496DFBB;
        Thu, 10 Aug 2023 09:20:37 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 796DA3C0439;
        Thu, 10 Aug 2023 09:20:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1691648437; bh=bYsAcXe+msxmctZkaQSDLKwGaykqzb1Fk6NOmEwpcAM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=cY8M+DWNgIfcrPfCAot1zf5bu/6LmAGxy9zkrhyKtb5IWnwWIHvK9+0bOQfRb3Hy2
         lJ1KzoLnWuf9Vvv6l2+dHrfJr6AO8Id42qh9BrXfs9hN7zukpuq/MkvlRew1+j7SX4
         6MkKOn2FKyRQEmD+XX24qPx9ZpslKX+0ixcjvENU=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37A6KSno013877;
        Thu, 10 Aug 2023 09:20:29 +0300
Date:   Thu, 10 Aug 2023 09:20:28 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Sishuai Gong <sishuai.system@gmail.com>
cc:     horms@verge.net.au,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org
Subject: Re: Race over table->data in proc_do_sync_threshold()
In-Reply-To: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
Message-ID: <b4854287-cb97-27fb-053f-e52179c05e97@ssi.bg>
References: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Wed, 9 Aug 2023, Sishuai Gong wrote:

> Hi,
> 
> We observed races over (struct ctl_table *) table->data when two threads
> are running proc_do_sync_threshold() in parallel, as shown below:
> 
> Thread-1			Thread-2
> memcpy(val, valp, sizeof(val)); memcpy(valp, val, sizeof(val));
> 
> This race probably would mess up table->data. Is it better to add a lock?

	We can put mutex_lock(&ipvs->sync_mutex) before the first
memcpy and to use two WRITE_ONCE instead of the second memcpy. But
this requires extra2 = ipvs in ip_vs_control_net_init_sysctl():

	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;

	Will you provide patch?

Regards

--
Julian Anastasov <ja@ssi.bg>

