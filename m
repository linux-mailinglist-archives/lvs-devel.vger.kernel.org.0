Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728535B22F5
	for <lists+lvs-devel@lfdr.de>; Thu,  8 Sep 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIHQAt (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 8 Sep 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIHQAs (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 8 Sep 2022 12:00:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C65A00F7
        for <lvs-devel@vger.kernel.org>; Thu,  8 Sep 2022 09:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B6AE1F6E6;
        Thu,  8 Sep 2022 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662652845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCtM9jkq+O2J63ASjaSwLT4QgvR/jlTzd+XIvIaFLoY=;
        b=xDWE90B/e4lTRvcj24AffKNIht/62f1eKdoye5LiYIY/dEnK7OT2saaZ1/IyEpceOpc8gY
        FiCvWu6bVHORFBQo2F5qBsdTZjE+EoTv8WEowBoZ7OUMYjF76nF+yomWD4gLcPDfuhntPd
        3SIqwK0XCWg5SqQVrYSeM1jZ8svfYm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662652845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCtM9jkq+O2J63ASjaSwLT4QgvR/jlTzd+XIvIaFLoY=;
        b=s0vxbHEwH9U5pqanndb40tbL9ZBhnGdkrG9UpZY6o3o3mwwRsAJ5u4GOLvJ3DTouBUntrp
        ipEDxE1+jAGvxHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C1E71322C;
        Thu,  8 Sep 2022 16:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ruxfFq0RGmPMfQAAMHmgww
        (envelope-from <jwiesner@suse.de>); Thu, 08 Sep 2022 16:00:45 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id D7F1610C87; Thu,  8 Sep 2022 18:00:44 +0200 (CEST)
Date:   Thu, 8 Sep 2022 18:00:44 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCH 2/4] ipvs: use kthreads for stats estimation
Message-ID: <20220908160044.GH18621@incl>
References: <20220827174154.220651-1-ja@ssi.bg>
 <20220827174154.220651-3-ja@ssi.bg>
 <20220905131905.GD18621@incl>
 <6a7bec4b-557-298b-b2e9-f3a517a47489@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7bec4b-557-298b-b2e9-f3a517a47489@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:01:27PM +0300, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Mon, 5 Sep 2022, Jiri Wiesner wrote:
> 
> > On Sat, Aug 27, 2022 at 08:41:52PM +0300, Julian Anastasov wrote:
> > >  
> > > +static void est_reload_work_handler(struct work_struct *work)
> > > +{
> > > +	struct netns_ipvs *ipvs =
> > > +		container_of(work, struct netns_ipvs, est_reload_work.work);
> > > +	int genid = atomic_read(&ipvs->est_genid);
> > > +	int genid_done = atomic_read(&ipvs->est_genid_done);
> > > +	unsigned long delay = HZ / 10;	/* repeat startups after failure */
> > > +	bool repeat = false;
> > > +	int id;
> > > +
> > > +	mutex_lock(&ipvs->est_mutex);
> > > +	for (id = 0; id < ipvs->est_kt_count; id++) {
> > > +		struct ip_vs_est_kt_data *kd = ipvs->est_kt_arr[id];
> > > +
> > > +		/* netns clean up started, abort delayed work */
> > > +		if (!ipvs->enable)
> > > +			goto unlock;
> > 
> > It would save some code to move the ipvs->enable check before the critical section and use a return statement right away.
> 
> 	I preferred to react to cleanup_net() faster and
> avoid creating threads if this is what we try to do here.

I meant putting
if (!ipvs->enable)
	return;
right before the mutex_lock() statement.

-- 
Jiri Wiesner
SUSE Labs
