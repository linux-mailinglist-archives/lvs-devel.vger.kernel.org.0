Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7B61DBDA
	for <lists+lvs-devel@lfdr.de>; Sat,  5 Nov 2022 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKEQFK (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sat, 5 Nov 2022 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiKEQFK (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sat, 5 Nov 2022 12:05:10 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D610068
        for <lvs-devel@vger.kernel.org>; Sat,  5 Nov 2022 09:05:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x21so5038955qkj.0
        for <lvs-devel@vger.kernel.org>; Sat, 05 Nov 2022 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GP8p4dRzNVpyUotOfaypMmYTGE9lsMcq6qB3gjhmc04=;
        b=iIDJL03zNkH0lS9YORaCB4Nnx18G1RT5PAxkqTBkren7bOYLdVGnhhilx+OlS481lw
         gQr71gF/2R0QtX/qOni1Pt9vrqOkIr43rj0MZrH/uG69dzQgSBZeGC3nRHzTa1HEb5Zv
         OhEAlIPPkZmfK8ER3fSUpMd0BmaBeM97bdw94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP8p4dRzNVpyUotOfaypMmYTGE9lsMcq6qB3gjhmc04=;
        b=QcWYX1Pj+fPk7bsJQmpCw2bobdWRYPY5zLdpSF9rIg6zlW3AbMtPfuReLjAfXJx9m9
         ClvTOtUiKbeT84NE+5r5J8/ghx3gl98KNC2kEEGHia7P+NdF2tZKRPph6YcBtujyuHxr
         77BbMzfmVvjNmFUtqZKmdmdcE3H9FGDGcO1d3gpbz1VTqrTmujQyfjufQhnUVWhOMH6k
         mcQnCQn4/kzqxCEwrwBuEJ0M5bJ0r+yIhJiRs4RaIpysiwbef6s4ehHu9WGWtSqPfIDQ
         qTVJtYJ517ygVZ6n+YNqwp3u1AAjSRQOvR8+7MZz1kIW/t6ct5fTGHIduVTtcVG7x9ml
         elTg==
X-Gm-Message-State: ACrzQf0iguORWQeFgEuF0LK6Okep3eZXUaeV+w9/McCKeLh+qgYcZ0mw
        3dBsN8tgJ3fYNw/INe1LT3EJYdOpptJllA==
X-Google-Smtp-Source: AMsMyM49+O/q+o3ALbnOPE8XDD5ksmFvAcpyIkf55Xssv3RpGeLJIO1E2lvPDrOx3KfxNHGNPoKbtg==
X-Received: by 2002:a05:620a:4149:b0:6fa:af6a:e9a3 with SMTP id k9-20020a05620a414900b006faaf6ae9a3mr1944110qko.507.1667664308142;
        Sat, 05 Nov 2022 09:05:08 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id q12-20020ac8734c000000b0039cba52974fsm1963201qtp.94.2022.11.05.09.05.07
        for <lvs-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 09:05:07 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3704852322fso68765477b3.8
        for <lvs-devel@vger.kernel.org>; Sat, 05 Nov 2022 09:05:07 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr40431421ywr.58.1667663992806; Sat, 05
 Nov 2022 08:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221105060024.598488967@goodmis.org>
In-Reply-To: <20221105060024.598488967@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Nov 2022 08:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
Message-ID: <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-edac@vger.kernel.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bluetooth@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-leds@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri, Nov 4, 2022 at 11:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Patch 1 fixes an issue with sunrpc/xprt where it incorrectly uses
> del_singleshot_timer_sync() for something that is not a oneshot timer. As this
> will be converted to shutdown, this needs to be fixed first.

So this is the kind of thing that I would *not* want to get eartly.

I really would want to get just the infrastructure in to let people
start doing conversions.

And then the "mindlessly obvious patches that are done by scripting
and can not possibly matter".

The kinds that do not *need* review, because they are mechanical, and
that just cause pointless noise for the rest of the patches that *do*
want review.

Not this kind of thing that is so subtle that you have to explain it.
That's not a "scripted patch for no semantic change".

So leave the del_singleshot_timer_sync() cases alone, they are
irrelevant for the new infrastructure and for the "mindless scripted
conversion" patches.

> Patches 2-4 changes existing timer_shutdown() functions used locally in ARM and
> some drivers to better namespace names.

Ok, these are relevant.

> Patch 5 implements the new timer_shutdown() and timer_shutdown_sync() functions
> that disable re-arming the timer after they are called.

This is obviously what I'd want early so that people can start doign
this in their trees.

> Patches 6-28 change all the locations where there's a kfree(), kfree_rcu(),
> kmem_cache_free() and one call_rcu() call where the RCU function frees the
> timer (the workqueue patch) in the same function as the del_timer{,_sync}() is
> called on that timer, and there's no extra exit path between the del_timer and
> freeing of the timer.

So honestly, I was literally hoping for a "this is the coccinelle
script" kind of patch.

Now there seems to be a number of patches here that are actualyl
really hard to see that they are "obviously correct" and I can't tell
if they are actually scripted or not.

They don't *look* scripted, but I can't really tell.  I looked at the
patches with ten lines of context, and I didn't see the immediately
following kfree() even in that expanded patch context, so it's fairly
far away.

Others in the series were *definitely* not scripted, doing clearly
manual cleanups:

-    if (dch->timer.function) {
-        del_timer(&dch->timer);
-        dch->timer.function = NULL;
-    }
+    timer_shutdown(&dch->timer);

so no, this does *not* make me feel "ok, this is all trivial".

IOW, I'd really want *just* the infrastructure and *just* the provably
trivial stuff. If it wasn't some scripted really obvious thing that
cannot possibly change anything and that wasn't then edited manually
for some reason, I really don't want it early.

IOW, any early conversions I'd take are literally about removing pure
mindless noise. Not about doing conversions.

And I wouldn't mind it as a single conversion patch that has the
coccinelle script as the explanation.

Really just THAT kind of "100% mindless conversion".

               Linus
