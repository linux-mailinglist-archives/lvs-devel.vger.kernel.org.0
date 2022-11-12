Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62170626821
	for <lists+lvs-devel@lfdr.de>; Sat, 12 Nov 2022 09:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiKLIWX (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 12 Nov 2022 03:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLIWW (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 12 Nov 2022 03:22:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE783B5
        for <lvs-devel@vger.kernel.org>; Sat, 12 Nov 2022 00:22:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B4B21F8FF;
        Sat, 12 Nov 2022 08:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668241340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLvdR6jCI0+zVXkVUIgE59tJUklMVvsjdiMVkakOItM=;
        b=ffVU0vlIAlw1yFbWZ6r9AutuMPvCY4RNLLHBkMJv6xVPibkveBG7lSn+4ieJ9CFSwO0MCa
        0k4NUDCsS/98QeTYXeiOOBb5daWa557DEUzLfINXb5W9Df6pGl4tOrLlVdeXIz8gEAp9S9
        GkLo4gS0vhhHbsb5aHKMltXugJ2oTMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668241340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLvdR6jCI0+zVXkVUIgE59tJUklMVvsjdiMVkakOItM=;
        b=/vRarqFZjb7rtPqAAF5amoM+x5GgZ0bczXm/Hap539dydc0e7FZhsvrhq7aog1MNdPWX3n
        JttYQyxKe1KLsMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C2E013488;
        Sat, 12 Nov 2022 08:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Ym4CrxXb2PiFQAAMHmgww
        (envelope-from <jwiesner@suse.de>); Sat, 12 Nov 2022 08:22:20 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id B440C1E53A; Sat, 12 Nov 2022 09:22:19 +0100 (CET)
Date:   Sat, 12 Nov 2022 09:22:19 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 2/7] ipvs: use common functions for stats allocation
Message-ID: <20221112082219.GG3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-3-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031145647.156930-3-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:56:42PM +0200, Julian Anastasov wrote:
> Move alloc_percpu/free_percpu logic in new functions
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
