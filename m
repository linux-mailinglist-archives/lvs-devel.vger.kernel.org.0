Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1259C299714
	for <lists+lvs-devel@lfdr.de>; Mon, 26 Oct 2020 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1737072AbgJZTfM (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 26 Oct 2020 15:35:12 -0400
Received: from mg.ssi.bg ([178.16.128.9]:46254 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444361AbgJZTfM (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:35:12 -0400
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 6369C163CF;
        Mon, 26 Oct 2020 21:35:08 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id 82D4716454;
        Mon, 26 Oct 2020 21:35:06 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 626103C0325;
        Mon, 26 Oct 2020 21:35:06 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 09QJZ4rh008355;
        Mon, 26 Oct 2020 21:35:06 +0200
Date:   Mon, 26 Oct 2020 21:35:04 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     =?UTF-8?Q?Cezar_S=C3=A1_Espinola?= <cezarsa@gmail.com>
cc:     lvs-devel@vger.kernel.org
Subject: Re: Possibility of adding a new netlink command to dump everything
In-Reply-To: <CA++F93g_WfKbVHLMUFYgQbR63o2-s8Ky_W9Z85qsFM77OaweEQ@mail.gmail.com>
Message-ID: <68d574-d213-50-7617-f1d917625362@ssi.bg>
References: <CA++F93g_WfKbVHLMUFYgQbR63o2-s8Ky_W9Z85qsFM77OaweEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1073527054-1603740906=:4529"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1073527054-1603740906=:4529
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Mon, 26 Oct 2020, Cezar Sá Espinola wrote:

> Hi all. This is my first message here and also my first attempt at kernel
> development so I'm a bit nervous and afraid I'm doing something wrong.
> 
> The last few days I've been toying with a patch to IPVS to allow me to use
> netlink to dump all services and all its destinations in a single call.
> 
> The motivation for this came after profiling a kubernetes node machine with a
> few thousand IPVS services each with an average of two destinations. The
> component responsible for ensuring that the IPVS rules are correct always needs
> a fresh dump of all services with all destinations and currently this is
> accomplished by issuing a IPVS_CMD_GET_SERVICE generic netlink dump command
> followed by multiple IPVS_CMD_GET_DEST dump commands.

	This is how ipvsadm -S runs now, list_all() gets all
services and for each gets its destinations.

> The patch in question adds a new netlink command IPVS_CMD_GET_SERVICE_DEST
> which dumps all services where each service is followed by a dump of its
> destinations. It's working now on my machine and some preliminary experiments
> show me that there's a significant performance improvement in switching to a
> single call to dump everything. However, I have some questions that I'd like to
> talk about before trying to submit it.
> 
> 1. First of all is such a patch adding a new command something desirable and
> could it possibly be merged or should I just drop it?

	It depends on its complexity, are you changing
the ipvsadm -S code or just the kernel part?

> 2. I can see that besides the generic netlink interface there's also another
> interface based on getsockopt options, should the patch also add a new socket
> option or is it okay for this new functionality to be exclusive to generic
> netlink?

	No, sockopt is old interface and it is not changed,
it lacks IPv6 support, etc.

> 3. Should this go forward, any advice on my next steps? Should I simply send the
> patch here?

	You can post it with [PATCH RFC] tag, so that we
can see how do you mix services and destinations in same
packet. You can also add speed comparison after the --- line
for more information.

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1073527054-1603740906=:4529--

