Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC8632982
	for <lists+lvs-devel@lfdr.de>; Mon, 21 Nov 2022 17:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKUQcF (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 21 Nov 2022 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKUQcD (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 21 Nov 2022 11:32:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891FBC7211
        for <lvs-devel@vger.kernel.org>; Mon, 21 Nov 2022 08:32:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B6F01F8B4;
        Mon, 21 Nov 2022 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669048321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VpsUVEtyx3mJ/Rw7gmuuRG64splN++CmwE8zJyfiPVM=;
        b=i1ZxbXsId6yZmZScQwxzvJgaCcZ8w4YpM5E14D0sPFqI39TnNCK3CITSDaV8BAikzOj0r4
        Q9udbqv/elWfJfosIrYUBRUytrhE2ozw16mW0ZkYfPNwbMubAVQ9aEtDduE2CKnFA3DwAH
        q+3iO8wsFKOeLRQU4tqnMNdAB4GL4Io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669048321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VpsUVEtyx3mJ/Rw7gmuuRG64splN++CmwE8zJyfiPVM=;
        b=81BpuGLoGB7BItQWwWJZqFHT8eMhu1u8zKD1odkpj33YHhQPuSHqH39WK74UoRO7wK72BK
        s77k5bCVh1zkpzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310551377F;
        Mon, 21 Nov 2022 16:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gcxRCwGoe2NGZAAAMHmgww
        (envelope-from <jwiesner@suse.de>); Mon, 21 Nov 2022 16:32:01 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 9D58421921; Mon, 21 Nov 2022 17:32:00 +0100 (CET)
Date:   Mon, 21 Nov 2022 17:32:00 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 6/7] ipvs: run_estimation should control the
 kthread tasks
Message-ID: <20221121163200.GP3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-7-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031145647.156930-7-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:56:46PM +0200, Julian Anastasov wrote:
> Change the run_estimation flag to start/stop the kthread tasks.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
