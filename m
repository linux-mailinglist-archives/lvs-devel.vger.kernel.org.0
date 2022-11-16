Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7919D62C538
	for <lists+lvs-devel@lfdr.de>; Wed, 16 Nov 2022 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPQqI (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 16 Nov 2022 11:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiKPQpk (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 16 Nov 2022 11:45:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3DF24
        for <lvs-devel@vger.kernel.org>; Wed, 16 Nov 2022 08:41:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C24B1F958;
        Wed, 16 Nov 2022 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668616879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIi4+UOaY0FcnAjfiKJqaX8nGHsgdXcHAsxwUXRUEZ4=;
        b=dSn6iiBYIPE6SsAdHP+drQpmX09YadsOtXHwjAj77aCDRw7QHsg2hQMtzg6gWe6vLCjFFT
        R4O3HcmdWrqXJxBr9P3FYeJuk5Blia3AeaJ3fSs3tKD9/r7Wui1qGAcQWPgKcWTf/e9jJQ
        xdXXFZ/NIRazIQ+zTA2VS6lDWa1bHRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668616879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIi4+UOaY0FcnAjfiKJqaX8nGHsgdXcHAsxwUXRUEZ4=;
        b=9O6Rvg5mXeF9PBwp+hZEiGSgHppNAwDwGq3rjYBrUoFmHTJA6x1l3PZ7Rfog0BDqnievqg
        vS6nS1Wa0aW7o7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AD0E134CE;
        Wed, 16 Nov 2022 16:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bVDjIa8SdWNhEgAAMHmgww
        (envelope-from <jwiesner@suse.de>); Wed, 16 Nov 2022 16:41:19 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 1CECB1EA22; Wed, 16 Nov 2022 17:41:19 +0100 (CET)
Date:   Wed, 16 Nov 2022 17:41:19 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv5 3/6] ipvs: use kthreads for stats estimation
Message-ID: <20221116164119.GK3484@incl>
References: <20221009153710.125919-1-ja@ssi.bg>
 <20221009153710.125919-4-ja@ssi.bg>
 <20221015092158.GA3484@incl>
 <64d2975-357d-75f7-1d34-c43a1b3fc72a@ssi.bg>
 <20221022181513.GB3484@incl>
 <b279182b-58ee-1c76-e194-31539d95982@ssi.bg>
 <20221027180751.GC3484@incl>
 <753051f-655d-bef5-70f-cbc41928adeb@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <753051f-655d-bef5-70f-cbc41928adeb@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Sat, Oct 29, 2022 at 05:12:28PM +0300, Julian Anastasov wrote:
> On Thu, 27 Oct 2022, Jiri Wiesner wrote:
> > On Mon, Oct 24, 2022 at 06:01:32PM +0300, Julian Anastasov wrote:
> > > - fast and safe way to apply a new chain_max or similar
> > > parameter for cond_resched rate. If possible, without
> > > relinking. stop+start can be slow too.
> > 
> > I am still wondering where the requirement for 100 us latency in non-preemtive kernels comes from. Typical time slices assigned by a time-sharing scheduler are measured in milliseconds. A kernel with volutary preemption does not need any cond_resched statements in ip_vs_tick_estimation() because every spin_unlock() in ip_vs_chain_estimation() is a preemption point, which actually puts the accuracy of the computed estimates at risk but nothing can be done about that, I guess.
> 
> 	I'm not sure about the 100us requirements for non-RT
> kernels, this document covers only RT requirements, I think:
> 
> Documentation/RCU/Design/Requirements/Requirements.rst
> 
> 	In fact, I don't worry for the RCU-preemptible
> case where we can be rescheduled at any time. In this
> case cond_resched_rcu() is NOP and chain_max has only
> one purpose of limiting ests in kthread, i.e. not to
> determine period between cond_resched calls which is
> its 2nd purpose for the non-preemptible case.
> 
> 	As for the non-preemptible case,
> rcu_read_lock/rcu_read_unlock are just preempt_disable/preempt_enable 
> which means the spin locking can not preempt us, the only way is
> we to call rcu_read_unlock which is just preempt_count_dec()
> or a simple barrier() but __preempt_schedule() is not
> called as it happens on CONFIG_PREEMPTION. So, only
> cond_resched() can allow rescheduling.
> 
> 	Also, there are some configurations like nohz_full
> that expect cond_resched() to check for any pending
> rcu_urgent_qs condition via rcu_all_qs(). I'm not
> expert in areas such as RCU and scheduling, so I'm
> not sure about the 100us latency budget for the
> non-preemptible cases we cover:
> 
> 1. PREEMPT_NONE "No Forced Preemption (Server)"
> 2. PREEMPT_VOLUNTARY "Voluntary Kernel Preemption (Desktop)"
> 
> 	Where the latency can matter is setups where the
> IPVS kthreads are set to some low priority, as a
> way to work in idle times and to allow app servers
> to react to clients' requests faster. Once request
> is served with short delay, app blocks somewhere and
> our kthreads run again running in idle times.
> 
> 	In short, the IPVS kthreads do not have an
> urgent work, they should do their 4.8ms work in 40ms
> or even more but it is preferred not to delay other
> more-priority tasks such as applications or even other
> kthreads. That is why I think we should stick to some low
> period between cond_resched calls without causing
> it to take large part of our CPU usage.

OK, I agree that volutary preemption without CONFIG_PREEMPT_RCU will need a preemption point in ip_vs_tick_estimation().

> 	If we want to reduce its rate, it can be
> in this way, for example:
> 
> 	int n = 0;
> 
> 	/* 400us for forced cond_resched() but reschedule on demand */
> 	if (!(++n & 3) || need_resched()) {
> 		cond_resched_rcu();
> 		n = 0;
> 	}
> 
> 	This controls both the RCU requirements and
> reacts faster on scheduler's indication. There will be
> an useless need_resched() call for the RCU-preemptible
> case, though, where cond_resched_rcu is NOP.

I do not see that as an improvement as well.

-- 
Jiri Wiesner
SUSE Labs
