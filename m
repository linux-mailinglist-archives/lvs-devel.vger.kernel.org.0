Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54261038A
	for <lists+lvs-devel@lfdr.de>; Thu, 27 Oct 2022 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiJ0U5J (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 27 Oct 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiJ0U4x (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Thu, 27 Oct 2022 16:56:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ECDB3B10
        for <lvs-devel@vger.kernel.org>; Thu, 27 Oct 2022 13:49:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t25so2063390qkm.2
        for <lvs-devel@vger.kernel.org>; Thu, 27 Oct 2022 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oSQGNRMEvUKfx6go8ULfblA0p1pLNMVNwBSwzmOAVIQ=;
        b=KiOYl6oYgVWmVt5yfOwXFbg2uqh6VMRSaNrvgwmuxSGJROVhF0gOA1n6rrYx8VRW6R
         VVZ63rmL9pY6OoKE9oUm6undU4L2Zw1Drahl+CZCyz+M4M06l6JRo9sMPUn+pAaD9PiI
         Dk7dgLCKUTOIMkWDgv7w/+2Fdi4C07XO5WJgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSQGNRMEvUKfx6go8ULfblA0p1pLNMVNwBSwzmOAVIQ=;
        b=N+bbotzKstU0IghFT+56+3NSraykAgXstm32IxgpPsFxPcoYYR0H2wZCeOZXXVy9W/
         hFk2JMEebdy+73koRNTWVEsLSCYiLR+kPLMnK96VNaAHbSBZjSH3mky0YS7SValftDt+
         uTpM3kCV7SzNX+7OU+LC37OgylmD3ob3juLIL1w5nzdKZWxE1BprAqb2ryv97+eyY/S2
         WhuNtJ4ODJI+V9GaYf74P1Fb6SrNJbG1cq8T0b8j81M5wOIFtJZqVZOzKi7KsyYsFOil
         ndwLK6yn2I6SyR3qpNuBzZ29DUTuBrCAgJ0If3zO0YYDrwO8/gwPX3u3qUnck13an6hZ
         lJ9g==
X-Gm-Message-State: ACrzQf0wyQI+J5wy0tsUBif5mQuRxj/DpOYvO1Vi6PDvJ5Cflqtsy7GY
        JW36F9IyMWXuAwtFq0c4kYO+Z8zsWOnoBg==
X-Google-Smtp-Source: AMsMyM4m8HyTt5lWBsNWiCa99Za6zlvYY5lOWUOgPHzANcFdDxdSQo5OATBCgNqaO524pYZc/iNvuA==
X-Received: by 2002:a05:620a:2697:b0:6f6:7a3:aba5 with SMTP id c23-20020a05620a269700b006f607a3aba5mr14861129qkp.316.1666903762341;
        Thu, 27 Oct 2022 13:49:22 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a409200b006cbe3be300esm1665200qko.12.2022.10.27.13.49.21
        for <lvs-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:49:21 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id t186so3756622yba.12
        for <lvs-devel@vger.kernel.org>; Thu, 27 Oct 2022 13:49:21 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr49547816ybu.310.1666903751005; Thu, 27
 Oct 2022 13:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home> <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
 <20221027163453.383bbf8e@gandalf.local.home>
In-Reply-To: <20221027163453.383bbf8e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 13:48:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
Message-ID: <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
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

On Thu, Oct 27, 2022 at 1:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> What about del_timer_try_shutdown(), that if it removes the timer, it sets
> the function to NULL (making it equivalent to a successful shutdown),
> otherwise it does nothing. Allowing the the timer to be rearmed.

Sounds sane to me and should work, but as mentioned, I think the
networking people need to say "yeah" too.

And maybe that function can also disallow any future re-arming even
for the case where the timer couldn't be actively removed.

So any *currently* active timer wouldn't be waited for (either because
locking may make that a deadlock situation, or simply due to
performance issues), but at least it would guarantee that no new timer
activations can happen.

Because I do like the whole notion of "timer has been shutdown and
cannot be used as a timer any more without re-initializing it" being a
real state - even for a timer that may be "currently in flight".

So this all sounds very worthwhile to me, but I'm not surprised that
we have code that then knows about all the subtleties of "del_timer()
might still have a running timer" and actually take advantage of it
(where "advantage" is likely more of a "deal with the complexities"
rather than anything really positive ;)

And those existing subtle users might want particular semantics to at
least make said complexities easier.

               Linus
