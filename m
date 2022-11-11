Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2762605B
	for <lists+lvs-devel@lfdr.de>; Fri, 11 Nov 2022 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKRVp (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 11 Nov 2022 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKRVo (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 11 Nov 2022 12:21:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E524219B
        for <lvs-devel@vger.kernel.org>; Fri, 11 Nov 2022 09:21:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF1012022C;
        Fri, 11 Nov 2022 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668187301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aFLTSeL0J2gWvka5c7AC/LdTyVFsHm6mtGlyovg20E=;
        b=Nhzn38cEGj4tNLZrOvmB9mPW1NqIrcKoNkJ/aybHX3l+i6uYV9hqYC8gUpjjegCddv9TCr
        7tOEQW9voMurTOY9BJXnziWnMqlRuE8edONATmfTnvBJVGJwxVK0gEbXKWU3BkHwGBIHOy
        1QGnx9wtRQG/SQ+bX3QJ3ia6n4nGNJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668187301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aFLTSeL0J2gWvka5c7AC/LdTyVFsHm6mtGlyovg20E=;
        b=xev0Y7x1t7S3wPfeF9az9A1GHQFLtxNnvCoLVY0Hp9hTMaaTvaxNaqMLhYWFPIoP/41mTi
        EVYXZRtNRl7owUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC66513357;
        Fri, 11 Nov 2022 17:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HjcQKqWEbmNUcAAAMHmgww
        (envelope-from <jwiesner@suse.de>); Fri, 11 Nov 2022 17:21:41 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 868071E31B; Fri, 11 Nov 2022 18:21:36 +0100 (CET)
Date:   Fri, 11 Nov 2022 18:21:36 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 4/7] ipvs: use kthreads for stats estimation
Message-ID: <20221111172136.GE3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-5-ja@ssi.bg>
 <20221110153915.GD3484@incl>
 <ff8bf15e-ddf3-76d1-b23b-814133ae5b@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8bf15e-ddf3-76d1-b23b-814133ae5b@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:16:24PM +0200, Julian Anastasov wrote:
> > AMD EPYC 7601 32-Core Processor
> > 128 CPUs, 8 NUMA nodes
> > Zen 1 machines such as this one have a large number of NUMA nodes due to restrictions in the CPU architecture. First, tests with different governors:
> > > cpupower frequency-set -g ondemand
> > > [  653.441325] IPVS: starting estimator thread 0...
> > > [  653.514918] IPVS: calc: chain_max=8, single est=11171ns, diff=11301, loops=1, ntest=12
> > > [  653.523580] IPVS: dequeue: 892ns
> > > [  653.527528] IPVS: using max 384 ests per chain, 19200 per kthread
> > > [  655.349916] IPVS: tick time: 3059313ns for 128 CPUs, 384 ests, 1 chains, chain_max=384
> > > [  685.230016] IPVS: starting estimator thread 1...
> > > [  717.110852] IPVS: starting estimator thread 2...
> > > [  719.349755] IPVS: tick time: 2896668ns for 128 CPUs, 384 ests, 1 chains, chain_max=384
> > > [  750.349974] IPVS: starting estimator thread 3...
> > > [  783.349841] IPVS: tick time: 2942604ns for 128 CPUs, 384 ests, 1 chains, chain_max=384
> > > [  847.349811] IPVS: tick time: 2930872ns for 128 CPUs, 384 ests, 1 chains, chain_max=384
> 
> 	Looks like cache_factor of 4 is good both to
> ondemand which prefers cache_factor 3 (2.9->4ms) and performance
> which prefers cache_factor 5 (5.6->4.3ms):
> 
> gov/cache_factor	chain_max	tick time (goal 4.8ms)
> ondemand/4		8		2.9ms
> ondemand/3		11		4ms
> performance/4		22		5.6ms
> performance/5		17		4.3ms

Yes, a cache factor of 4 happens to be a good compromise on this particular Zen 1 machine.

> > > [ 1578.032593] IPVS: tick time: 5691875ns for 128 CPUs, 1056 ests, 1 chains, chain_max=1056
> > >    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > >  42514 root      20   0       0      0      0 I 14.24 0.000   0:14.96 ipvs-e:0:0
> > >  95356 root      20   0       0      0      0 I 1.987 0.000   0:01.34 ipvs-e:0:1
> > While having the services loaded, I switched to the ondemand governor:
> > > [ 1706.032577] IPVS: tick time: 5666868ns for 128 CPUs, 1056 ests, 1 chains, chain_max=1056
> > > [ 1770.032534] IPVS: tick time: 5638505ns for 128 CPUs, 1056 ests, 1 chains, chain_max=1056
> 
> 	Hm, ondemand governor takes 5.6ms just like
> the above performance result? This is probabllly still
> performance mode?

I am not sure if I copied the right messages from the log. Probably not.

> > Basically, chain_max calculation under gonernors than ramp up CPU frequency more slowly (ondemand on AMD or powersave for intel_pstate) is stabler than before on both AMD and Intel. We know from previous results that even ARM with multiple NUMA nodes is not a complete disaster. Switching CPU frequency gonernors, including the unfavourable switches from performance to ondemand, does not saturate CPUs. When it comes to CPU frequency gonernors, people tend to use either ondemand (or powersave for intel_pstate) or performance consistently - switches between gonernors can be expected to be rare in production.
> > I will need to find out to read through the latest version of the patch set.
> 
> 	OK. Thank you for testing the different cases!
> Let me know if any changes are needed before releasing
> the patchset. We can even include some testing results
> in the commit messages.

Absolutely.

-- 
Jiri Wiesner
SUSE Labs
