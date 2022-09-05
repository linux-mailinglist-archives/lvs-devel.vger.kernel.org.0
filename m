Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7D5AD58A
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Sep 2022 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiIEOxm (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Sep 2022 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbiIEOxi (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 5 Sep 2022 10:53:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD14F648
        for <lvs-devel@vger.kernel.org>; Mon,  5 Sep 2022 07:53:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1275233ABE;
        Mon,  5 Sep 2022 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662389614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1UnObJe2ULj6sSrzT5ZONR8Ni84LlugN35MPTGcstU=;
        b=ne73cDajtuXv9Vf3EmqzsfeOm8M2fI+rAdG5nfr/9svgKZe2u2IKMVE8oJ2anU7VgdlnQE
        RLF5ukJFLSW3VNOGbcfIXs356MmuE9EWtfbfVoIVKFTAivfcq43cfzUWLSZl+NaERAahGt
        Hnr0I7dJEssF0kU8KCMhgtoDqvamIns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662389614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1UnObJe2ULj6sSrzT5ZONR8Ni84LlugN35MPTGcstU=;
        b=4OJKTalJCvP+muxjrPN3oROq3uYUseMV36gFMPYqY/SqdYUEoDCBVtk6RrWu/pSDAOIZeb
        aClzdHHkr+NXY2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0531213A66;
        Mon,  5 Sep 2022 14:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vX06AW4NFmOBSQAAMHmgww
        (envelope-from <jwiesner@suse.de>); Mon, 05 Sep 2022 14:53:34 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 9512610919; Mon,  5 Sep 2022 16:53:33 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:53:33 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>, yunhjiang@ebay.com,
        dust.li@linux.alibaba.com, tangyang@zhihu.com
Subject: Re: [RFC PATCH 3/4] ipvs: add est_cpulist and est_nice sysctl vars
Message-ID: <20220905145333.GE18621@incl>
References: <20220827174154.220651-1-ja@ssi.bg>
 <20220827174154.220651-4-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827174154.220651-4-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Sat, Aug 27, 2022 at 08:41:53PM +0300, Julian Anastasov wrote:
> Allow the kthreads for stats to be configured for
> specific cpulist (isolation) and niceness (scheduling
> priority).
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>

I think moving the estimation kthreads to idle CPU core will become necessary for people who want their estimates to be as accurate as possible. Otherwise, scheduling latencies on busy systems may make the estimates inaccurate by delaying the kthreads after they have been woken up.

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

> diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
> index 387fda80f05f..90c7c325421a 100644
> --- a/Documentation/networking/ipvs-sysctl.rst
> +++ b/Documentation/networking/ipvs-sysctl.rst
> @@ -129,6 +129,26 @@ drop_packet - INTEGER
>  	threshold. When the mode 3 is set, the always mode drop rate
>  	is controlled by the /proc/sys/net/ipv4/vs/am_droprate.
>  
> +est_cpulist - CPULIST
> +	Allowed	CPUs for estimation kthreads
> +
> +	Syntax: standard cpulist format
> +	empty list - stop kthread tasks and estimation
> +	default - the system's housekeeping CPUs for kthreads
> +
> +	Example:
> +	"all": all possible CPUs
> +	"0-N": all possible CPUs, N denotes last CPU number
> +	"0,1-N:1/2": first and all CPUs with odd number
> +	"": empty list
> +
> +est_nice - INTEGER
> +	default 0
> +	Valid range: -20 (more favorable) - 19 (less favorable)

How about using dots instead of a hyphen in the range? I guess it will be easier to read.

> +
> +	Niceness value to use for the estimation kthreads (scheduling
> +	priority)
> +
>  expire_nodest_conn - BOOLEAN
>  	- 0 - disabled (default)
>  	- not 0 - enabled

-- 
Jiri Wiesner
SUSE Labs
