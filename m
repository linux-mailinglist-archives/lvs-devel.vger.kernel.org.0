Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A15B4028
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Sep 2022 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIITuI (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 9 Sep 2022 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiIITuA (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 9 Sep 2022 15:50:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B93ECD9
        for <lvs-devel@vger.kernel.org>; Fri,  9 Sep 2022 12:49:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA35B21AE5;
        Fri,  9 Sep 2022 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662752996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=93x2FGMhKDCjdJW8gP4Vee6+dZxLNQ6LeV54w/hdlWQ=;
        b=EAfTlUxG1qzZ2cm4hrvgn/KOSgQW7x/KjG6qGm2VL+AbUgxfveysABcvVhTnyWz9rVbWSD
        u/KaKodS2T2/vmZ4MHbbp5zv5Afwq9KSzooAfo4F6wpCz8E7+fwSu13gZVLFVzDxd5853f
        RnA/oF0OhIiGeqfgmPBE4vMedH2Y+5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662752996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=93x2FGMhKDCjdJW8gP4Vee6+dZxLNQ6LeV54w/hdlWQ=;
        b=tPDn8imAHKTsrM63rWB/vRVXh6SvrfXNmGY4pBM/RVt1ACBeYy0e7JcOQzgOL8rOcBsWPV
        Qr72BrkUPw6pPBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2F86139D5;
        Fri,  9 Sep 2022 19:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kddJJ+SYG2P+PgAAMHmgww
        (envelope-from <jwiesner@suse.de>); Fri, 09 Sep 2022 19:49:56 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 269EA10DA1; Fri,  9 Sep 2022 21:49:56 +0200 (CEST)
Date:   Fri, 9 Sep 2022 21:49:56 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv2 0/4] ipvs: Use kthreads for stats
Message-ID: <20220909194956.GJ18621@incl>
References: <20220908222109.147452-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908222109.147452-1-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:21:05AM +0300, Julian Anastasov wrote:
> It is interesting to know what value for
> IPVS_EST_TICK_CHAINS to use, it is used for the
> IPVS_EST_MAX_COUNT calculation. We should determine
> it from tests once the loops are in final form.
> Now the limit increased a little bit to 38400.
> Tomorrow I'll check again the patches for possible
> problems.

I couldn't wait so I have run tests on various machines and used the sched_switch tracepoint to measure the time needed to process one chain. The table contains a median time for processing one chain, the maximum time measured, the median divided by the number of CPUs and the time needed to process one chain if there were 1024 CPUs of that type in a machine:
> NR         CPU                       Time(ms)  Max(ms)  Time/CPU(ms)  1024 CPUs(ms)
> 48 Intel Xeon CPU E5-2670 v3, 2 nodes   1.220    1.343         0.025     26.027
> 64 Intel Xeon Gold 6326, 2 nodes        0.920    1.494         0.014     14.720
> 192 Intel Xeon Gold 6330H, 4 nodes      3.957    4.153         0.021     21.104
> 256 AMD EPYC 7713, 2 NUMA nodes         3.927    5.464         0.015     15.708
>  80 ARM Neoverse-N1, 1 NUMA node        1.833    2.502         0.023     23.462
> 128 ARM Kunpeng 920, 4 NUMA nodes       3.822    4.635         0.030     30.576
I have to admit I was hoping the current IPVS_EST_CHAIN_DEPTH would work on machines with more than 1024 CPUs. If the max time values are used the time needed to process one chain on a 1024 CPU machine gets even closer to 40 ms, which it must not reach lest the estimates become inaccurate. I also have profiling data so I intend to look at the disassembly of ip_vs_estimation_kthread() to see which instructions take the most time. I will take a look at the v2 of the code on Monday.
-- 
Jiri Wiesner
SUSE Labs
