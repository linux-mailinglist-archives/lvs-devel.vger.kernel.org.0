Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7912786B5
	for <lists+lvs-devel@lfdr.de>; Fri, 25 Sep 2020 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgIYMJn (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Fri, 25 Sep 2020 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYMJn (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Fri, 25 Sep 2020 08:09:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4942EC0613CE
        for <lvs-devel@vger.kernel.org>; Fri, 25 Sep 2020 05:09:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so2257824ljk.8
        for <lvs-devel@vger.kernel.org>; Fri, 25 Sep 2020 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KuEuCrzxDVDfRygUDBAUCymQMtipb7e5y0kfRWS118o=;
        b=PrLIhOjV/Ysvo9D/s4gJeAknBbeqOv5C0zr7mpbfgit0w3HM32RJo/OpqGSPBRRrGP
         mmdSAdQva/GSIARGGx0bscS1ZIaGLNpcEcYtRv/bJbanJzwOlZkLHGdaOP4PoZcj9zkn
         cqHhUQFMauzjeIzRmXkYXVsjl1p18TAj0Q26uQj6SZFWysk6HipW4Q+s3SrXV+ttglze
         Ad05DQD71YW31pC82ykLQhLi84es2hMXY8JT3DN3aZnAfMzS5yyT5oBQqYfjHTHlCJCo
         smj1fj7pR7CndW2btbyfYbhlOYXdD1fKefRCFLmt8mQSnJ/UjWEK0o+6Mv7wrODyaZ8P
         Sr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KuEuCrzxDVDfRygUDBAUCymQMtipb7e5y0kfRWS118o=;
        b=WGH2jQZ6JDvcYuYsqWBK8Uk112s/ufHChHjfcFjNvruIopLFG9NfnvVioD8HHwT27k
         9wGgzwLg8TtIckTZDZ8NwuSNtCy0H2zIkCnnb6CpKvpX16LChtUp6smPf/x1HLL02YKP
         ++icEoZsPkyWo2DbDFdrR81throlo1ghWJQu/72yJHfs6+XjWJMcrtxz0s6whYghC4Up
         v6nHudQdOyx5ufaka06sQIPmrDF8zGRIPHKEUY9MCxMxnxaZFI06ofNjxftvTPp+uMCi
         OXYM3wvxl1Mo1+8qFfFFKveLPsytK4vLOZOXxdp/KLFhVOS2hPpYXHukjoQTAxAFAHe8
         NkIQ==
X-Gm-Message-State: AOAM5338RaGSM3yLRgRc/D3STaSFhw+rWmHztAAHkggDORFpkGjsB3LI
        4SNTT8e0kaI20PAcRgOl3OF52YanFDEVFd1kpeGMJaQHjovVYw==
X-Google-Smtp-Source: ABdhPJzFKdp5pmqNNLsLgyDsfeYrxQd9TLjCjK3kefZbi4nwRgyBdGkN35s9SK9nZuWgfhjrbl8Sksa9a+6HFHOd2E8=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr1172608ljo.89.1601035781353;
 Fri, 25 Sep 2020 05:09:41 -0700 (PDT)
MIME-Version: 1.0
From:   yue longguang <yuelongguang@gmail.com>
Date:   Fri, 25 Sep 2020 20:09:30 +0800
Message-ID: <CAPaK2r8cTOq5rEKZezse+wF0f9NierUabqcr31b46wJx43werQ@mail.gmail.com>
Subject: [PATCH v3] ipvs: adjust the debug info in function set_tcp_state
To:     horms@verge.net.au, Julian Anastasov <ja@ssi.bg>,
        wensong@linux-vs.org, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, David Miller <davem@davemloft.net>, kuba@kernel.org,
        lvs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

From: "longguang.yue" <yuelongguang@gmail.com>

   outputting client,virtual,dst addresses info when tcp state changes,
   which makes the connection debug more clear

Signed-off-by: longguang.yue <yuelongguang@gmail.com>
---
net/netfilter/ipvs/ip_vs_proto_tcp.c | 10 ++++++----
1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c
b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index dc2e7da2742a..7da51390cea6 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -539,8 +539,8 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct
ip_vs_conn *cp,
if (new_state != cp->state) {
struct ip_vs_dest *dest = cp->dest;

- IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] %s:%d->"
-       "%s:%d state: %s->%s conn->refcnt:%d\n",
+ IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] c:%s:%d v:%s:%d "
+       "d:%s:%d state: %s->%s conn->refcnt:%d\n",
      pd->pp->name,
      ((state_off == TCP_DIR_OUTPUT) ?
       "output " : "input "),
@@ -548,10 +548,12 @@ set_tcp_state(struct ip_vs_proto_data *pd,
struct ip_vs_conn *cp,
      th->fin ? 'F' : '.',
      th->ack ? 'A' : '.',
      th->rst ? 'R' : '.',
-       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
-       ntohs(cp->dport),
      IP_VS_DBG_ADDR(cp->af, &cp->caddr),
      ntohs(cp->cport),
+       IP_VS_DBG_ADDR(cp->af, &cp->vaddr),
+       ntohs(cp->vport),
+       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
+       ntohs(cp->dport),
      tcp_state_name(cp->state),
      tcp_state_name(new_state),
      refcount_read(&cp->refcnt));
-- 
2.20.1 (Apple Git-117)
