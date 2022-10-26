Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5460E47C
	for <lists+lvs-devel@lfdr.de>; Wed, 26 Oct 2022 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiJZP3u (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 26 Oct 2022 11:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiJZP3t (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 26 Oct 2022 11:29:49 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD50EE19
        for <lvs-devel@vger.kernel.org>; Wed, 26 Oct 2022 08:29:46 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 4D9BD120AA;
        Wed, 26 Oct 2022 18:29:45 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 1F6BD120A9;
        Wed, 26 Oct 2022 18:29:44 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id CA06D3C07E1;
        Wed, 26 Oct 2022 18:29:43 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 29QFTdZh103583;
        Wed, 26 Oct 2022 18:29:42 +0300
Date:   Wed, 26 Oct 2022 18:29:39 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv5 3/6] ipvs: use kthreads for stats estimation
In-Reply-To: <b279182b-58ee-1c76-e194-31539d95982@ssi.bg>
Message-ID: <bc1d5e15-9c1f-4f4a-152f-2e49e472963@ssi.bg>
References: <20221009153710.125919-1-ja@ssi.bg> <20221009153710.125919-4-ja@ssi.bg> <20221015092158.GA3484@incl> <64d2975-357d-75f7-1d34-c43a1b3fc72a@ssi.bg> <20221022181513.GB3484@incl> <b279182b-58ee-1c76-e194-31539d95982@ssi.bg>
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

On Mon, 24 Oct 2022, Julian Anastasov wrote:

> 	While finishing this posting, I'm investigating
> the idea to use structures without chains (no relinking),
> without chain_len, tick_len, etc. But let me first see
> if such idea can work...

	Hm, I tried some ideas but result is not good at all.
chain_max looks like a good implicit way to apply cond_resched
rate and to return to some safe position on return. Other methods
with arrays will (1) allocate more memory or (2) slowdown searching
for free slot while adding or (3) slowdown while walking during
estimation. Now we benefit from long chains (33/38 as in your
setup) to (1) use less memory to store ests in chains and (2) to
reduce the cost from for_each_set_bit() operation.

	So, for now I don't have any better idea to change
the data structures.

	After your feedback I can prepare next version by adding
wait_event_idle_timeout() calls as pause between tests.

Regards

--
Julian Anastasov <ja@ssi.bg>

