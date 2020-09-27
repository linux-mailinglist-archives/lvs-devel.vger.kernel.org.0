Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09422279E63
	for <lists+lvs-devel@lfdr.de>; Sun, 27 Sep 2020 07:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgI0FOz (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 27 Sep 2020 01:14:55 -0400
Received: from mg.ssi.bg ([178.16.128.9]:43394 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbgI0FOz (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:14:55 -0400
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id D7CC312860;
        Sun, 27 Sep 2020 08:14:52 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id 300FB12856;
        Sun, 27 Sep 2020 08:14:52 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id F3CAF3C0505;
        Sun, 27 Sep 2020 08:14:50 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 08R5EkNY004815;
        Sun, 27 Sep 2020 08:14:49 +0300
Date:   Sun, 27 Sep 2020 08:14:46 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     yue longguang <yuelongguang@gmail.com>
cc:     Simon Horman <horms@verge.net.au>,
        Wensong Zhang <wensong@linux-vs.org>, pablo@netfilter.org,
        lvs-devel@vger.kernel.org
Subject: Re: [PATCH v3] ipvs: adjust the debug info in function
 set_tcp_state
In-Reply-To: <CAPaK2r9th06OeNvs-1jrOq8a_ayaNL+kNWPddUUJ2GAEEJnZ8A@mail.gmail.com>
Message-ID: <alpine.LFD.2.23.451.2009270807020.3858@ja.home.ssi.bg>
References: <CAPaK2r8cTOq5rEKZezse+wF0f9NierUabqcr31b46wJx43werQ@mail.gmail.com> <CAPaK2r9th06OeNvs-1jrOq8a_ayaNL+kNWPddUUJ2GAEEJnZ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Sun, 27 Sep 2020, yue longguang wrote:

> Hi, could you all give me some feedback?

	Feedback is same, patch is malformed on sending.
Download it from list, apply it and see what happens.

# cat /tmp/file.patch | patch -p1 --dry-run
checking file net/netfilter/ipvs/ip_vs_proto_tcp.c
patch: **** malformed patch at line 17: ip_vs_conn *cp,

	If you can not resolve it, we can fix it...

> thanks
> 
> On Fri, Sep 25, 2020 at 8:09 PM yue longguang <yuelongguang@gmail.com> wrote:
> >
> > From: "longguang.yue" <yuelongguang@gmail.com>
> >
> >    outputting client,virtual,dst addresses info when tcp state changes,
> >    which makes the connection debug more clear
> >
> > Signed-off-by: longguang.yue <yuelongguang@gmail.com>
> > ---
> > net/netfilter/ipvs/ip_vs_proto_tcp.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> > b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> > index dc2e7da2742a..7da51390cea6 100644
> > --- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> > +++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> > @@ -539,8 +539,8 @@ set_tcp_state(struct ip_vs_proto_data *pd, struct
> > ip_vs_conn *cp,
> > if (new_state != cp->state) {
> > struct ip_vs_dest *dest = cp->dest;
> >
> > - IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] %s:%d->"
> > -       "%s:%d state: %s->%s conn->refcnt:%d\n",
> > + IP_VS_DBG_BUF(8, "%s %s [%c%c%c%c] c:%s:%d v:%s:%d "
> > +       "d:%s:%d state: %s->%s conn->refcnt:%d\n",
> >       pd->pp->name,
> >       ((state_off == TCP_DIR_OUTPUT) ?
> >        "output " : "input "),
> > @@ -548,10 +548,12 @@ set_tcp_state(struct ip_vs_proto_data *pd,
> > struct ip_vs_conn *cp,
> >       th->fin ? 'F' : '.',
> >       th->ack ? 'A' : '.',
> >       th->rst ? 'R' : '.',
> > -       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
> > -       ntohs(cp->dport),
> >       IP_VS_DBG_ADDR(cp->af, &cp->caddr),
> >       ntohs(cp->cport),
> > +       IP_VS_DBG_ADDR(cp->af, &cp->vaddr),
> > +       ntohs(cp->vport),
> > +       IP_VS_DBG_ADDR(cp->daf, &cp->daddr),
> > +       ntohs(cp->dport),
> >       tcp_state_name(cp->state),
> >       tcp_state_name(new_state),
> >       refcount_read(&cp->refcnt));
> > --
> > 2.20.1 (Apple Git-117)

Regards

--
Julian Anastasov <ja@ssi.bg>

