Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E27297CF
	for <lists+lvs-devel@lfdr.de>; Fri,  9 Jun 2023 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbjFILH3 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 9 Jun 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjFILHU (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 9 Jun 2023 07:07:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4902720
        for <lvs-devel@vger.kernel.org>; Fri,  9 Jun 2023 04:07:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c8423dccso583951366b.1
        for <lvs-devel@vger.kernel.org>; Fri, 09 Jun 2023 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1686308836; x=1688900836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHu2xBaM4T3PMSp0giSRR9qRkUkZb6FW2kTLysFfPJo=;
        b=PFCUUrFlh5OTF2U4kzlwQ8AA58YczWfGTQoQ2eeOltifSMTClpRNbQAo2kyq+UBare
         gCM1sSzTkpp8/OkDnvs9sqxCjE2ZTxWvTdIe4w5EI34t2Z4tmtTPwczYm3PKmOfgAO+3
         K4jtN9K8U8PBslQ/q0asmpKysoO7+xa3P0kIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308836; x=1688900836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHu2xBaM4T3PMSp0giSRR9qRkUkZb6FW2kTLysFfPJo=;
        b=QGNk+v9012KZeGOU/haWBV0UVpT8XLENc7V7SUyaLGGAKliVCNY/lBolXnyFozBn+8
         Z6LuHsEBBXhec87HVxPdoHbZSTTsHlsyCGgaN6EpoDFr5sMQHlB+sYufMjd8PMXbKn30
         hGIPWHaD0qq8of/FN2Ce/7Yp8Z4zUT7QgzeX066KLfAmwwMRkDHzP2HjgT4InwpJT6m8
         Np5YAjwykmcKd508RhnEc5pKtxig1THqXpubiyqs2FxqLyT+eDTgrxa3QxHwtuJHJBpA
         CXw2U1vrHKV4nSVAGWn2ybz/VTYftdTlE6CTTkBA/PZf9T9GuTWmll5PCmsQ5V6x6bIr
         qK4A==
X-Gm-Message-State: AC+VfDxcnF8YKxXTY+bJOGmy9JNWm1iZEAPihD18yoqa12278prstSXo
        IzFz+J8NRyQ6b14b9j1UFajCLQ==
X-Google-Smtp-Source: ACHHUZ6vDJQ1pygqGe/bfDo0EfxTPltNjTzL21X4N/MCRd0Guafc/nN7PCmoAlANfTEkj2rL00t7OA==
X-Received: by 2002:a17:907:1623:b0:973:87d3:80d4 with SMTP id hb35-20020a170907162300b0097387d380d4mr1436636ejc.18.1686308835977;
        Fri, 09 Jun 2023 04:07:15 -0700 (PDT)
Received: from localhost (2a02-a210-2543-4700-b6b3-6a86-5b72-da13.cable.dynamic.v6.ziggo.nl. [2a02:a210:2543:4700:b6b3:6a86:5b72:da13])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906688400b009788ec81a17sm1150208ejr.57.2023.06.09.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:07:15 -0700 (PDT)
From:   Terin Stock <terin@cloudflare.com>
To:     horms@verge.net.au, ja@ssi.bg
Cc:     netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [PATCH] ipvs: align inner_mac_header for encapsulation
Date:   Fri,  9 Jun 2023 13:07:14 +0200
Message-Id: <20230609110714.2015477-1-terin@cloudflare.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

When using encapsulation the original packet's headers are copied to the
inner headers. This preserves the space for an inner mac header, which
is not used by the inner payloads for the encapsulation types supported
by IPVS. If a packet is using GUE or GRE encapsulation and needs to be
segmented, flow can be passed to __skb_udp_tunnel_segment() which
calculates a negative tunnel header length. A negative tunnel header
length causes pskb_may_pull() to fail, dropping the packet.

This can be observed by attaching probes to ip_vs_in_hook(),
__dev_queue_xmit(), and __skb_udp_tunnel_segment():

    perf probe --add '__dev_queue_xmit skb->inner_mac_header \
    skb->inner_network_header skb->mac_header skb->network_header'
    perf probe --add '__skb_udp_tunnel_segment:7 tnl_hlen'
    perf probe -m ip_vs --add 'ip_vs_in_hook skb->inner_mac_header \
    skb->inner_network_header skb->mac_header skb->network_header'

These probes the headers and tunnel header length for packets which
traverse the IPVS encapsulation path. A TCP packet can be forced into
the segmentation path by being smaller than a calculated clamped MSS,
but larger than the advertised MSS.

    probe:ip_vs_in_hook: inner_mac_header=0x0 inner_network_header=0x0 mac_header=0x44 network_header=0x52
    probe:ip_vs_in_hook: inner_mac_header=0x44 inner_network_header=0x52 mac_header=0x44 network_header=0x32
    probe:dev_queue_xmit: inner_mac_header=0x44 inner_network_header=0x52 mac_header=0x44 network_header=0x32
    probe:__skb_udp_tunnel_segment_L7: tnl_hlen=-2

When using veth-based encapsulation, the interfaces are set to be
mac-less, which does not preserve space for an inner mac header. This
prevents this issue from occurring.

In our real-world testing of sending a 32KB file we observed operation
time increasing from ~75ms for veth-based encapsulation to over 1.5s
using IPVS encapsulation due to retries from dropped packets.

This changeset modifies the packet on the encapsulation path in
ip_vs_tunnel_xmit() to remove the inner mac header offset. This fixes
UDP segmentation for both encapsulation types, and corrects the inner
headers for any IPIP flows that may use it.

Fixes: 84c0d5e96f3a ("ipvs: allow tunneling with gue encapsulation")
Signed-off-by: Terin Stock <terin@cloudflare.com>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index c7652da78c88..4d20b89dd765 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1207,6 +1207,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
-- 
2.40.1

