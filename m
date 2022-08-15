Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C155933F7
	for <lists+lvs-devel@lfdr.de>; Mon, 15 Aug 2022 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiHORWg (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 15 Aug 2022 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiHORWf (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 15 Aug 2022 13:22:35 -0400
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01051CE0C
        for <lvs-devel@vger.kernel.org>; Mon, 15 Aug 2022 10:22:35 -0700 (PDT)
Received: from madeliefje.horms.nl (86-88-72-229.fixed.kpn.net [86.88.72.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id B5B4520119;
        Mon, 15 Aug 2022 17:22:03 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 7570CD3C; Mon, 15 Aug 2022 18:22:03 +0100 (BST)
Date:   Mon, 15 Aug 2022 18:22:03 +0100
From:   Simon Horman <horms@kernel.org>
To:     Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>
Cc:     lvs-devel@vger.kernel.org, ceo@teo-en-ming-corp.com
Subject: Re: How many physical machines do I need for running the Linux
 Virtual Server?
Message-ID: <YvqAu4kafE2bElT6@vergenet.net>
References: <CACsrZYY6aWpVOdZ5SOhDPdU+_=P0LX4=q4xCht+E-+PHRwEhGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsrZYY6aWpVOdZ5SOhDPdU+_=P0LX4=q4xCht+E-+PHRwEhGw@mail.gmail.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Wed, Aug 10, 2022 at 05:43:09PM +0800, Turritopsis Dohrnii Teo En Ming wrote:
> Subject: How many physical machines do I need for running the Linux
> Virtual Server?
> 
> Good day from Singapore,
> 
> How many physical machines do I need for running the Linux Virtual Server?

Hi,

typically you would want one or two load balances, running IPVS.
And two or more real servers running your application, f.e. a web server.

It is, however possible, to make a minimal configuration with
only one of each. Or to use VMs to run the entire system
on one physical server.
