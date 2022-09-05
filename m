Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C75AD596
	for <lists+lvs-devel@lfdr.de>; Mon,  5 Sep 2022 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiIEO6A (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 5 Sep 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiIEO56 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 5 Sep 2022 10:57:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA535464D
        for <lvs-devel@vger.kernel.org>; Mon,  5 Sep 2022 07:57:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E18733D1E;
        Mon,  5 Sep 2022 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662389875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AiSbwvV48dhV9xNM3d1vGzTwYVvEfvPNfSqKQjZUUG0=;
        b=uPFkOv5iKepev4YfNyZjQYOkGj5tl89fSc5A/OYDP5Vzv5PxizmkcmJmNQZ1gp7Mo+C8FL
        JoA4gJlvi/TI0Yqc/cEr13LkniownEdg9h2FsvYMzdIvCOOmfl9aVMsLwkmVJiadIXiI4L
        qn9lM3ukXBd3p6B/QuN46zWzW+p/Ubo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662389875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AiSbwvV48dhV9xNM3d1vGzTwYVvEfvPNfSqKQjZUUG0=;
        b=0tglCboWkIErGdmmjzyNvf0bVSnBXvC2Etah/D9E2jCYOjD05JJc2J4ug2cHd3eW9sCRX7
        V3X6TzMpVkT5fDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E7A813A66;
        Mon,  5 Sep 2022 14:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5J3wGnMOFmNESwAAMHmgww
        (envelope-from <jwiesner@suse.de>); Mon, 05 Sep 2022 14:57:55 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 0575F1091B; Mon,  5 Sep 2022 16:57:54 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:57:54 +0200
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>, yunhjiang@ebay.com,
        dust.li@linux.alibaba.com, tangyang@zhihu.com
Subject: Re: [RFC PATCH 4/4] ipvs: run_estimation should control the kthread
 tasks
Message-ID: <20220905145754.GF18621@incl>
References: <20220827174154.220651-1-ja@ssi.bg>
 <20220827174154.220651-5-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827174154.220651-5-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Sat, Aug 27, 2022 at 08:41:54PM +0300, Julian Anastasov wrote:
> Change the run_estimation flag to start/stop the kthread tasks.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
