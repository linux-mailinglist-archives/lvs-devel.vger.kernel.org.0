Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942462683F
	for <lists+lvs-devel@lfdr.de>; Sat, 12 Nov 2022 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiKLJAF (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 12 Nov 2022 04:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLJAE (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 12 Nov 2022 04:00:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DB205F9
        for <lvs-devel@vger.kernel.org>; Sat, 12 Nov 2022 01:00:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7787533782;
        Sat, 12 Nov 2022 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668243602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfxoVU0vLQ0ii+CeHKSU15zCoKdixp2m8lkCHhaepLY=;
        b=SM0ocMSIpt5y4Kvv8OHzhMUSfLFCoY3sJMTLjqM36JDbLaUZxXZwxrmMNn54G9wYnJ9jrO
        wjiBjUzmOR80n8Qo0+s4sFMbkCdi0jV6qGUtg97ZritPEoCyx5qievbgE8jt5+ZSdaTmOC
        1D+ILelner1M1DsJJmA7Anw5bMQ/Eok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668243602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfxoVU0vLQ0ii+CeHKSU15zCoKdixp2m8lkCHhaepLY=;
        b=w12qftJDGlXIpUdSa+4Tnfl9uZlqdVkRhz+FFLaHlKPi/+ZGeyB6EuNpRXjjexD2zgL36m
        LY+VZQ1JkqvpWXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6821813A08;
        Sat, 12 Nov 2022 09:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QPNhGZJgb2MjJgAAMHmgww
        (envelope-from <jwiesner@suse.de>); Sat, 12 Nov 2022 09:00:02 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 0AA091E548; Sat, 12 Nov 2022 10:00:02 +0100 (CET)
Date:   Sat, 12 Nov 2022 10:00:01 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 3/7] ipvs: use u64_stats_t for the per-cpu counters
Message-ID: <20221112090001.GH3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-4-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031145647.156930-4-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:56:43PM +0200, Julian Anastasov wrote:
> Use the provided u64_stats_t type to avoid
> load/store tearing.
> 
> Fixes: 316580b69d0a ("u64_stats: provide u64_stats_t type")
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---
>  include/net/ip_vs.h             | 10 +++++-----
>  net/netfilter/ipvs/ip_vs_core.c | 30 +++++++++++++++---------------
>  net/netfilter/ipvs/ip_vs_ctl.c  | 10 +++++-----
>  net/netfilter/ipvs/ip_vs_est.c  | 20 ++++++++++----------
>  4 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index e5582c01a4a3..a4d44138c2a8 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -351,11 +351,11 @@ struct ip_vs_seq {
>  
>  /* counters per cpu */
>  struct ip_vs_counters {
> -	__u64		conns;		/* connections scheduled */
> -	__u64		inpkts;		/* incoming packets */
> -	__u64		outpkts;	/* outgoing packets */
> -	__u64		inbytes;	/* incoming bytes */
> -	__u64		outbytes;	/* outgoing bytes */
> +	u64_stats_t	conns;		/* connections scheduled */
> +	u64_stats_t	inpkts;		/* incoming packets */
> +	u64_stats_t	outpkts;	/* outgoing packets */
> +	u64_stats_t	inbytes;	/* incoming bytes */
> +	u64_stats_t	outbytes;	/* outgoing bytes */
>  };
>  /* Stats per cpu */
>  struct ip_vs_cpu_stats {

Converting the per cpu stat to u64_stats_t means that the compiler cannot optimize the memory access and addition on x86_64. Previously, the summation of per cpu counters in ip_vs_chain_estimation() looked like:
15b65:  add    (%rsi),%r14
15b68:  add    0x8(%rsi),%r15
15b6c:  add    0x10(%rsi),%r13
15b70:  add    0x18(%rsi),%r12
15b74:  add    0x20(%rsi),%rbp
The u64_stats_read() calls in ip_vs_chain_estimation() turned it into:
159d5:  mov    (%rcx),%r11
159d8:  mov    0x8(%rcx),%r10
159dc:  mov    0x10(%rcx),%r9
159e0:  mov    0x18(%rcx),%rdi
159e4:  mov    0x20(%rcx),%rdx
159e8:  add    %r11,%r14
159eb:  add    %r10,%r13
159ee:  add    %r9,%r12
159f1:  add    %rdi,%rbp
159f4:  add    %rdx,%rbx
I guess that is not a big deal because the mov should be the instruction taking the most time on account of accessing per cpu regions of other CPUs. The add will be fast.

-- 
Jiri Wiesner
SUSE Labs
