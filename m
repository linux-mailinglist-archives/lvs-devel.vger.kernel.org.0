Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050AD5AD067
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Sep 2022 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiIEKnl (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Sep 2022 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiIEKnk (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 5 Sep 2022 06:43:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7FC4F185
        for <lvs-devel@vger.kernel.org>; Mon,  5 Sep 2022 03:43:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A24405F988;
        Mon,  5 Sep 2022 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662374617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dALBtuhRkZMjNvySioaM5hFMcYX/TMNiMJYQMT81is=;
        b=Sb9wUDSXrSkhcAiIr5kb9EOsGOXPJfPSs5xs7nJQ7xQGf5jLKzq9vgHsYG8vTKnkSui76p
        Y2aHrt2sxTfTy0B9aWkXKa8RSeInI1EOdAT3wPYKnzudAwBY2Qvx+9/j+PWpLPXJjTmFHL
        Tx5F5Z1LX5U0wPZ/gJsBR1VmA8UJ/wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662374617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dALBtuhRkZMjNvySioaM5hFMcYX/TMNiMJYQMT81is=;
        b=+Uj0yXXpVd4mfaikRDnIt5BSgHJAY4ZK8ru/fw9O/SVQSzaHma4iLJvemUPEbOfTwbot/o
        NCxnJ0jqZG2ECJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9477613A66;
        Mon,  5 Sep 2022 10:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pyg2JNnSFWPxTQAAMHmgww
        (envelope-from <jwiesner@suse.de>); Mon, 05 Sep 2022 10:43:37 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 327CE107D2; Mon,  5 Sep 2022 12:43:37 +0200 (CEST)
Date:   Mon, 5 Sep 2022 12:43:37 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>, yunhjiang@ebay.com,
        dust.li@linux.alibaba.com, tangyang@zhihu.com
Subject: Re: [RFC PATCH 1/4] ipvs: add rcu protection to stats
Message-ID: <20220905104337.GC18621@incl>
References: <20220827174154.220651-1-ja@ssi.bg>
 <20220827174154.220651-2-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827174154.220651-2-ja@ssi.bg>
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

On Sat, Aug 27, 2022 at 08:41:51PM +0300, Julian Anastasov wrote:
> In preparation to using RCU locking for the list
> with estimators, make sure the struct ip_vs_stats
> are released after RCU grace period by using RCU
> callbacks. This affects ipvs->tot_stats where we
> can not use RCU callbacks for ipvs, so we use
> allocated struct ip_vs_stats_rcu. For services
> and dests we force RCU callbacks for all cases.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>
-- 
Jiri Wiesner
SUSE Labs
