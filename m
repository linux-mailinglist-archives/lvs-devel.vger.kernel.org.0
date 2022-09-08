Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7D5B2993
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Sep 2022 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIHWqv (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 8 Sep 2022 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHWqv (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 8 Sep 2022 18:46:51 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26900B9FBD
        for <lvs-devel@vger.kernel.org>; Thu,  8 Sep 2022 15:46:50 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 286C52BF0E;
        Fri,  9 Sep 2022 01:46:49 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 008692BF84;
        Fri,  9 Sep 2022 01:46:48 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id CFCD13C0437;
        Fri,  9 Sep 2022 01:46:47 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 288MkjeC152755;
        Fri, 9 Sep 2022 01:46:45 +0300
Date:   Fri, 9 Sep 2022 01:46:45 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jiri Wiesner <jwiesner@suse.de>
cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv2 2/4] ipvs: use kthreads for stats estimation
In-Reply-To: <20220908222109.147452-3-ja@ssi.bg>
Message-ID: <89135c6a-eb8c-b3c5-2599-306db1f0fb25@ssi.bg>
References: <20220908222109.147452-1-ja@ssi.bg> <20220908222109.147452-3-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Fri, 9 Sep 2022, Julian Anastasov wrote:

> +add_est:
> +	ktid = kd->id;
> +	/* add_row points after the row we should use */
> +	crow = READ_ONCE(kd->add_row) - 1;
> +	if (crow < 0)
> +		crow = IPVS_EST_NTICKS - 1;
> +	row = crow;
> +	if (crow) {

	OK, not fatal but this should be

	if (crow < IPVS_EST_NTICKS - 1) {

> +		crow++;
> +		row = find_last_bit(kd->avail, crow);
> +	}
> +	if (row >= crow)
> +		row = find_last_bit(kd->avail, IPVS_EST_NTICKS);
> +

Regards

--
Julian Anastasov <ja@ssi.bg>

