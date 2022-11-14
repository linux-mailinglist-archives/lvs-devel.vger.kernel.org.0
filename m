Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E50627CFE
	for <lists+lvs-devel@lfdr.de>; Mon, 14 Nov 2022 12:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiKNLub (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 14 Nov 2022 06:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiKNLuB (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 14 Nov 2022 06:50:01 -0500
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808ED2180F
        for <lvs-devel@vger.kernel.org>; Mon, 14 Nov 2022 03:46:18 -0800 (PST)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 7D2F025812;
        Mon, 14 Nov 2022 13:46:16 +0200 (EET)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 4A12425811;
        Mon, 14 Nov 2022 13:46:15 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 261763C0437;
        Mon, 14 Nov 2022 13:46:11 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 2AEBk6vR041036;
        Mon, 14 Nov 2022 13:46:08 +0200
Date:   Mon, 14 Nov 2022 13:46:06 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 3/7] ipvs: use u64_stats_t for the per-cpu
 counters
In-Reply-To: <a7bf3435-aa8f-31a5-b93b-f0ad58fdc3a4@ssi.bg>
Message-ID: <96408766-f9d1-f16d-f186-73811b7ce499@ssi.bg>
References: <20221031145647.156930-1-ja@ssi.bg> <20221031145647.156930-4-ja@ssi.bg> <20221112090001.GH3484@incl> <20221112090910.GI3484@incl> <a7bf3435-aa8f-31a5-b93b-f0ad58fdc3a4@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Sat, 12 Nov 2022, Julian Anastasov wrote:

> +			for (;;) {
> +				start += u64_stats_fetch_begin(&c->syncp);

	Hm, this should be assignment and not addition...
Not a problem for 64-bit tests.

> +				kconns += u64_stats_read(&c->cnt.conns);
> +				kinpkts += u64_stats_read(&c->cnt.inpkts);
> +				koutpkts += u64_stats_read(&c->cnt.outpkts);
> +				kinbytes += u64_stats_read(&c->cnt.inbytes);
> +				koutbytes += u64_stats_read(&c->cnt.outbytes);
> +				if (!u64_stats_fetch_retry(&c->syncp, start))
> +					break;
> +#if BITS_PER_LONG == 32
> +				kconns = conns;
> +				kinpkts = inpkts;
> +				koutpkts = outpkts;
> +				kinbytes = inbytes;
> +				koutbytes = outbytes;
> +#endif

Regards

--
Julian Anastasov <ja@ssi.bg>

