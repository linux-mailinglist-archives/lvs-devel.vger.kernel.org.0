Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06272A2BD
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Jun 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFITDu (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 9 Jun 2023 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjFITDt (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 9 Jun 2023 15:03:49 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DE35BE;
        Fri,  9 Jun 2023 12:03:45 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 98F1119D35;
        Fri,  9 Jun 2023 22:03:42 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 778FB19D99;
        Fri,  9 Jun 2023 22:03:42 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 232D33C0439;
        Fri,  9 Jun 2023 22:03:41 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 359J3d1t114503;
        Fri, 9 Jun 2023 22:03:40 +0300
Date:   Fri, 9 Jun 2023 22:03:39 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Terin Stock <terin@cloudflare.com>
cc:     horms@verge.net.au, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] ipvs: align inner_mac_header for encapsulation
In-Reply-To: <20230609110714.2015477-1-terin@cloudflare.com>
Message-ID: <98a12cef-2220-3f92-3b6a-0efc2dd3dfba@ssi.bg>
References: <20230609110714.2015477-1-terin@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Fri, 9 Jun 2023, Terin Stock wrote:

> When using encapsulation the original packet's headers are copied to the
> inner headers. This preserves the space for an inner mac header, which
> is not used by the inner payloads for the encapsulation types supported
> by IPVS. If a packet is using GUE or GRE encapsulation and needs to be
> segmented, flow can be passed to __skb_udp_tunnel_segment() which
> calculates a negative tunnel header length. A negative tunnel header
> length causes pskb_may_pull() to fail, dropping the packet.
> 
> This can be observed by attaching probes to ip_vs_in_hook(),
> __dev_queue_xmit(), and __skb_udp_tunnel_segment():
> 
>     perf probe --add '__dev_queue_xmit skb->inner_mac_header \
>     skb->inner_network_header skb->mac_header skb->network_header'
>     perf probe --add '__skb_udp_tunnel_segment:7 tnl_hlen'
>     perf probe -m ip_vs --add 'ip_vs_in_hook skb->inner_mac_header \
>     skb->inner_network_header skb->mac_header skb->network_header'
> 
> These probes the headers and tunnel header length for packets which
> traverse the IPVS encapsulation path. A TCP packet can be forced into
> the segmentation path by being smaller than a calculated clamped MSS,
> but larger than the advertised MSS.
> 
>     probe:ip_vs_in_hook: inner_mac_header=0x0 inner_network_header=0x0 mac_header=0x44 network_header=0x52
>     probe:ip_vs_in_hook: inner_mac_header=0x44 inner_network_header=0x52 mac_header=0x44 network_header=0x32
>     probe:dev_queue_xmit: inner_mac_header=0x44 inner_network_header=0x52 mac_header=0x44 network_header=0x32
>     probe:__skb_udp_tunnel_segment_L7: tnl_hlen=-2
> 
> When using veth-based encapsulation, the interfaces are set to be
> mac-less, which does not preserve space for an inner mac header. This
> prevents this issue from occurring.
> 
> In our real-world testing of sending a 32KB file we observed operation
> time increasing from ~75ms for veth-based encapsulation to over 1.5s
> using IPVS encapsulation due to retries from dropped packets.
> 
> This changeset modifies the packet on the encapsulation path in
> ip_vs_tunnel_xmit() to remove the inner mac header offset. This fixes
> UDP segmentation for both encapsulation types, and corrects the inner
> headers for any IPIP flows that may use it.
> 
> Fixes: 84c0d5e96f3a ("ipvs: allow tunneling with gue encapsulation")
> Signed-off-by: Terin Stock <terin@cloudflare.com>
> ---
>  net/netfilter/ipvs/ip_vs_xmit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
> index c7652da78c88..4d20b89dd765 100644
> --- a/net/netfilter/ipvs/ip_vs_xmit.c
> +++ b/net/netfilter/ipvs/ip_vs_xmit.c
> @@ -1207,6 +1207,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
>  	skb->transport_header = skb->network_header;
>  
>  	skb_set_inner_ipproto(skb, next_protocol);
> +	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));

	Can you send v2 after including the same line also in 
ip_vs_tunnel_xmit_v6?

>  
>  	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
>  		bool check = false;
> -- 
> 2.40.1

Regards

--
Julian Anastasov <ja@ssi.bg>

