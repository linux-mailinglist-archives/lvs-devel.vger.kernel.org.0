Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE44D46AF51
	for <lists+lvs-devel@lfdr.de>; Tue,  7 Dec 2021 01:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351468AbhLGAsz (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 6 Dec 2021 19:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhLGAsz (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 6 Dec 2021 19:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC0C061746;
        Mon,  6 Dec 2021 16:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A492AB81644;
        Tue,  7 Dec 2021 00:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FFFC004DD;
        Tue,  7 Dec 2021 00:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638837922;
        bh=SCN5889vVh+mCc+CkiaepdBgwDK/1jikVPzpnl7uoXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e3WCRzoyTZfv7k0J0Rx5q26w57k/JZZt4C8OR2q7/B22q25bq6p1lVhWzCdiwBoty
         A287qgioJl30xM+B1SLQ/LeBKgVByIlU3YIIi8it12f6eYKYEKYXuxQfkrVUL1mI0E
         MecnFGqFqngtDSVQ/M/IEgYyoulFu+5MHyh7h9aYdmTRrb3rhA6WllT0MIi35Gyz+S
         KNWiMDd9QihVQeZzQjQkPn25QvYpeGOBg9LjtCaFcPCYYkU1t88LtaeXgRp6qxlilk
         GPsVUN6e3hY/JpNbAaCFhESkd5U/oV06XozdBD9zz2JhSMeBFzlOhpavKYrUfD/pt1
         bmDIlXRCbf1Uw==
Date:   Mon, 6 Dec 2021 16:45:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     cgel.zte@gmail.com
Cc:     davem@davemloft.net, alex.aring@gmail.com,
        stefan@datenfreihafen.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, horms@verge.net.au, ja@ssi.bg,
        pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        daniel@iogearbox.net, roopa@nvidia.com, yajun.deng@linux.dev,
        chinagar@codeaurora.org, xu.xin16@zte.com.cn,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH net-next] net: Enable some sysctls for the userns root
 with privilege
Message-ID: <20211206164520.51f8a2d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211203032815.339186-1-xu.xin16@zte.com.cn>
References: <20211203032815.339186-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri,  3 Dec 2021 03:28:15 +0000 cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Enabled sysctls include the followings: 
> 1. net/ipv4/neigh/<if>/* 
> 2. net/ipv6/neigh/<if>/* 
> 3. net/ieee802154/6lowpan/* 
> 4. net/ipv6/route/* 
> 5. net/ipv4/vs/* 
> 6. net/unix/* 
> 7. net/core/xfrm_*
> 
> In practical work, some userns with root privilege have needs to adjust
> these sysctls in their own netns, but limited just because they are not
> init user_ns, even if they are given root privilege by docker -privilege.

You need to justify why removing these checks is safe. It sounds like
you're only describing why having the permissions is problematic, which 
is fair but not sufficient to just remove them.

> Reported-by: xu xin <xu.xin16@zte.com.cn>
> Tested-by: xu xin <xu.xin16@zte.com.cn>

These tags are superfluous for the author of the patch.

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  net/core/neighbour.c                | 4 ----
>  net/ieee802154/6lowpan/reassembly.c | 4 ----
>  net/ipv6/route.c                    | 4 ----
>  net/netfilter/ipvs/ip_vs_ctl.c      | 4 ----
>  net/netfilter/ipvs/ip_vs_lblc.c     | 4 ----
>  net/netfilter/ipvs/ip_vs_lblcr.c    | 3 ---
>  net/unix/sysctl_net_unix.c          | 4 ----
>  net/xfrm/xfrm_sysctl.c              | 4 ----
>  8 files changed, 31 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 0cdd4d9ad942..44d90cc341ea 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3771,10 +3771,6 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>  			neigh_proc_base_reachable_time;
>  	}
>  
> -	/* Don't export sysctls to unprivileged users */
> -	if (neigh_parms_net(p)->user_ns != &init_user_ns)
> -		t->neigh_vars[0].procname = NULL;
> -
>  	switch (neigh_parms_family(p)) {
>  	case AF_INET:
>  	      p_name = "ipv4";
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index be6f06adefe0..89cbad6d8368 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -366,10 +366,6 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>  				GFP_KERNEL);
>  		if (table == NULL)
>  			goto err_alloc;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			table[0].procname = NULL;
>  	}
>  
>  	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index f0d29fcb2094..6a0b15d6500e 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6409,10 +6409,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
>  		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
>  		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
>  		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			table[1].procname = NULL;
>  	}
>  
>  	return table;
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 7f645328b47f..a77c8abf2fc7 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -4040,10 +4040,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
>  		if (tbl == NULL)
>  			return -ENOMEM;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			tbl[0].procname = NULL;
>  	} else
>  		tbl = vs_vars;
>  	/* Initialize sysctl defaults */
> diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
> index 7ac7473e3804..567ba33fa5b4 100644
> --- a/net/netfilter/ipvs/ip_vs_lblc.c
> +++ b/net/netfilter/ipvs/ip_vs_lblc.c
> @@ -561,10 +561,6 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
>  		if (ipvs->lblc_ctl_table == NULL)
>  			return -ENOMEM;
>  
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			ipvs->lblc_ctl_table[0].procname = NULL;
> -
>  	} else
>  		ipvs->lblc_ctl_table = vs_vars_table;
>  	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
> diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
> index 77c323c36a88..a58440a7bf9e 100644
> --- a/net/netfilter/ipvs/ip_vs_lblcr.c
> +++ b/net/netfilter/ipvs/ip_vs_lblcr.c
> @@ -747,9 +747,6 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
>  		if (ipvs->lblcr_ctl_table == NULL)
>  			return -ENOMEM;
>  
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			ipvs->lblcr_ctl_table[0].procname = NULL;
>  	} else
>  		ipvs->lblcr_ctl_table = vs_vars_table;
>  	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index c09bea89151b..01d44e2598e2 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -30,10 +30,6 @@ int __net_init unix_sysctl_register(struct net *net)
>  	if (table == NULL)
>  		goto err_alloc;
>  
> -	/* Don't export sysctls to unprivileged users */
> -	if (net->user_ns != &init_user_ns)
> -		table[0].procname = NULL;
> -
>  	table[0].data = &net->unx.sysctl_max_dgram_qlen;
>  	net->unx.ctl = register_net_sysctl(net, "net/unix", table);
>  	if (net->unx.ctl == NULL)
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 0c6c5ef65f9d..a9b7723eb88f 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -55,10 +55,6 @@ int __net_init xfrm_sysctl_init(struct net *net)
>  	table[2].data = &net->xfrm.sysctl_larval_drop;
>  	table[3].data = &net->xfrm.sysctl_acq_expires;
>  
> -	/* Don't export sysctls to unprivileged users */
> -	if (net->user_ns != &init_user_ns)
> -		table[0].procname = NULL;
> -
>  	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table);
>  	if (!net->xfrm.sysctl_hdr)
>  		goto out_register;

