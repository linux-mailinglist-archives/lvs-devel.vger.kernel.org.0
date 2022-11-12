Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C76267D4
	for <lists+lvs-devel@lfdr.de>; Sat, 12 Nov 2022 08:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKLHv4 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 12 Nov 2022 02:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKLHvz (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 12 Nov 2022 02:51:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC045EF0
        for <lvs-devel@vger.kernel.org>; Fri, 11 Nov 2022 23:51:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA8CE1F381;
        Sat, 12 Nov 2022 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668239511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hHx63Mh4fJHTWNVdrYBjQx/8WmXU8zhRsEjRgjmryU=;
        b=UjDcjVV2f2oNY4L/3uCTZwnNvINCTX6tyTsxawBAbeIZfnqC53Hr2Clhz7mBt5RmYxTRqW
        ktg+fH5EQTZ65vXve2Zqu5MoWbhpS7DX7gz31zbyflpTxK36RJbSsKxQ0qC+c2RGFfU8l1
        YnvJjuHbK1V8/fPwlwJBfoj2QNJJN6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668239511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hHx63Mh4fJHTWNVdrYBjQx/8WmXU8zhRsEjRgjmryU=;
        b=n5lfvxdTI1d6A7I/ySr1FtmQcDrwLZgr6H84hSHDUWfb2Qumkd38Wg0x3bbhnMArMbnFsl
        eN5BKRm0F6RT9UAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D30E013488;
        Sat, 12 Nov 2022 07:51:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e8IGM5dQb2ONBwAAMHmgww
        (envelope-from <jwiesner@suse.de>); Sat, 12 Nov 2022 07:51:51 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
        id 501F81E530; Sat, 12 Nov 2022 08:51:51 +0100 (CET)
Date:   Sat, 12 Nov 2022 08:51:51 +0100
From:   Jiri Wiesner <jwiesner@suse.de>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [RFC PATCHv6 1/7] ipvs: add rcu protection to stats
Message-ID: <20221112075151.GF3484@incl>
References: <20221031145647.156930-1-ja@ssi.bg>
 <20221031145647.156930-2-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031145647.156930-2-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:56:41PM +0200, Julian Anastasov wrote:
> In preparation to using RCU locking for the list
> with estimators, make sure the struct ip_vs_stats
> are released after RCU grace period by using RCU
> callbacks. This affects ipvs->tot_stats where we
> can not use RCU callbacks for ipvs, so we use
> allocated struct ip_vs_stats_rcu. For services
> and dests we force RCU callbacks for all cases.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---

Reviewed-by: Jiri Wiesner <jwiesner@suse.de>

-- 
Jiri Wiesner
SUSE Labs
