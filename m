Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0662C67A
	for <lists+lvs-devel@lfdr.de>; Wed, 16 Nov 2022 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKPRhR (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 16 Nov 2022 12:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiKPRhR (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 16 Nov 2022 12:37:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF15E3F9
        for <lvs-devel@vger.kernel.org>; Wed, 16 Nov 2022 09:37:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 893B21F948;
        Wed, 16 Nov 2022 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668620233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8S/siVMdegdETGjBApK2ZQn8AXjBXCAVGgYNlpCfdM=;
        b=XnjEFY6nvndbkp7fpjt3tfLmD36miAg97Zzgktu7cTkhjC4CPMUt5FCFfVa09RJUjYOV/+
        KXE5p4oBOgHdmMk92liDPJcAOji0pzyYM3kNg+ENUBps0hakw6OEPwvyDtqcWbQ5t7RIwg
        +rFQy4Gn2e64QDdrh/mM2YYbj4uVepk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668620233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8S/siVMdegdETGjBApK2ZQn8AXjBXCAVGgYNlpCfdM=;
        b=ObxtzHi4FCKFpTSx2jnR0aNH/0UHTF00jHZc5fkU4OALge4S3R7uq1geuPmgPw2xc7osDV
        avpbAjUasLMIhRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AF9913480;
        Wed, 16 Nov 2022 17:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wU78HckfdWM0KAAAMHmgww
        (envelope-from <jwiesner@suse.de>); Wed, 16 Nov 2022 17:37:13 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 0A4971EB17; Wed, 16 Nov 2022 18:37:13 +0100 (CET)
Date:   Wed, 16 Nov 2022 18:37:12 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 3/7] ipvs: use u64_stats_t for the per-cpu counters
Message-ID: <20221116173712.GL3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-4-ja@ssi.bg>
 <20221112090001.GH3484@incl>
 <20221112090910.GI3484@incl>
 <a7bf3435-aa8f-31a5-b93b-f0ad58fdc3a4@ssi.bg>
 <20221115122602.GJ3484@incl>
 <2152a987-19ee-083-d6f8-5ad73d8f83c@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2152a987-19ee-083-d6f8-5ad73d8f83c@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:53:22PM +0200, Julian Anastasov wrote:
> 	Bad, same register RDX used. I guess, this is
> CONFIG_GENERIC_CPU=y kernel which is suitable for different
> CPUs.

Yes, it is. I use SUSE's distro config.

-- 
Jiri Wiesner
SUSE Labs
