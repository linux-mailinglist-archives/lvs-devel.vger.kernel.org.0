Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66F63296B
	for <lists+lvs-devel@lfdr.de>; Mon, 21 Nov 2022 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiKUQ3b (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 21 Nov 2022 11:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKUQ3a (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 21 Nov 2022 11:29:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46FC6BE3
        for <lvs-devel@vger.kernel.org>; Mon, 21 Nov 2022 08:29:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEDF01F8A8;
        Mon, 21 Nov 2022 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669048168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0Y+TOUnn9zUCHI4aa1d3mbhLBqxbWh9x7difBcSH0I=;
        b=bXk3SOCABJ/fVP3wEcyNy3QB+ojVQ8hjjbqB0FcZVy0vltgknc7pnifm0iiHxT2yC/V23W
        jMvb4aXkSaK7WWjcJqIPN/GhslmOWDoBcDUP6k2DVgbToBUt5fykfepfHZ5JbSJ30MtnWM
        Nk8+4mBx2xPCP9b7Lv2G7i7A+c7V+24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669048168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0Y+TOUnn9zUCHI4aa1d3mbhLBqxbWh9x7difBcSH0I=;
        b=f1lHXjthjaSP99QAXp46+NJNYd/EkI8XOtHzU725ZEtk9SGZDjXjV2+2O9W5GgidYV2Kre
        ZyeP2PG9vAnFN/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64701377F;
        Mon, 21 Nov 2022 16:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K7qNKGine2PWYgAAMHmgww
        (envelope-from <jwiesner@suse.de>); Mon, 21 Nov 2022 16:29:28 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id D21552191E; Mon, 21 Nov 2022 17:29:27 +0100 (CET)
Date:   Mon, 21 Nov 2022 17:29:27 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 5/7] ipvs: add est_cpulist and est_nice sysctl vars
Message-ID: <20221121162927.GO3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-6-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031145647.156930-6-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:56:45PM +0200, Julian Anastasov wrote:
> Allow the kthreads for stats to be configured for
> specific cpulist (isolation) and niceness (scheduling
> priority).
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
