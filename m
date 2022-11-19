Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD81630D02
	for <lists+lvs-devel@lfdr.de>; Sat, 19 Nov 2022 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiKSHqo (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 19 Nov 2022 02:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHqn (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 19 Nov 2022 02:46:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70EA3162
        for <lvs-devel@vger.kernel.org>; Fri, 18 Nov 2022 23:46:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22A6A1F383;
        Sat, 19 Nov 2022 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668844000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGK7OYeTPTB9if68cZg9buicT+kxyUPwJSk9CVJ+mrk=;
        b=Gc4z6KhohCV5YLZk7l+kDyMWOZCg8AeQnZBOqohpiHVAfRj0Tv4Q4g3mG6/8y78Vr+HcE8
        qf+pXIMbRpy16GLrJpMqG+49xhHoTlzr72uBML0KX0hXsdyM2gPbetrcKafWb6SDiwXALx
        OSiz6i4GbPZ4L/cANE6s6UyG5ke4Tv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668844000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGK7OYeTPTB9if68cZg9buicT+kxyUPwJSk9CVJ+mrk=;
        b=47oxONQ9HFll/J2+Utnf44BeV4w+Gq8sy2plWuVLJ3GtqRK/egcFag2Ovirexg5Xr2FBh7
        uaMyrLMvO8CXrZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0875413B08;
        Sat, 19 Nov 2022 07:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dZAHAuCJeGPZcAAAMHmgww
        (envelope-from <jwiesner@suse.de>); Sat, 19 Nov 2022 07:46:40 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 866A52161C; Sat, 19 Nov 2022 08:46:39 +0100 (CET)
Date:   Sat, 19 Nov 2022 08:46:39 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 3/7] ipvs: use u64_stats_t for the per-cpu counters
Message-ID: <20221119074639.GM3484@incl>
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

Tested-by: Jiri Wiesner <jwiesner@suse.de>
Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
