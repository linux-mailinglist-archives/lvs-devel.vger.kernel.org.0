Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA76612BDB
	for <lists+lvs-devel@lfdr.de>; Sun, 30 Oct 2022 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ3RX7 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 30 Oct 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ3RX6 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 30 Oct 2022 13:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D6B1F6
        for <lvs-devel@vger.kernel.org>; Sun, 30 Oct 2022 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667150539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy7b3nRtAL8M7+VedHsmmAKhtOAAl2XLancWVFWUXlg=;
        b=ijJZwgavlu3UqY5RY3rYZbN/sldFbQHt6M4aq6SbYiXHEITHYXuklbYZGrv/CXAQ28+/Gq
        fmkqhStkmal5jIxe+JPQU4q8CrLlWS6Qpg7IxgienJN7XFgs6eOwvG+6EQdJNGgYSpHba8
        G0Hc3ZEJq2s2x54zuMBEIwzFPNeDf+M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-DutdWqrTPQacdb09WfNlAA-1; Sun, 30 Oct 2022 13:22:10 -0400
X-MC-Unique: DutdWqrTPQacdb09WfNlAA-1
Received: by mail-qt1-f197.google.com with SMTP id k9-20020ac85fc9000000b00399e6517f9fso6242553qta.18
        for <lvs-devel@vger.kernel.org>; Sun, 30 Oct 2022 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy7b3nRtAL8M7+VedHsmmAKhtOAAl2XLancWVFWUXlg=;
        b=l35Q2REzSdPzP1+rTLcpfN7+dLnUpirv5iIbkMRkgOWrTTNt/kddljNo1nne/JBGSv
         jQQKepUDVxRQnCgVS39Pn6rdWGlR2DtxTmo0P/P6Ko0NiJ9OG9PDfkEQA0rmxV1Ahh47
         1A81TZ/cuKHdMkAQ1DHfMCrZ1x/qAZbDRUFVK7lNwtjwxunFwsXKE4lBw1Toyc3J+IOy
         nFA45+SUtHuwhMkq4gSk4ro1ReKsameHhrfraYn4sd5iNkjVbPNa+GCT4Sur8aVJpCUd
         9bdV9YNbx3gM9ZrWreLka2GEmS0Kw2KucLB8inO1QkFE2SrfGOCLSlvg0cx4ZSTejwd0
         Or1g==
X-Gm-Message-State: ACrzQf0KyKQbMDdvuvEKDND+gxgO5CDcI0PjJ4Mhd3Qo4zDBnpAmzLy1
        3aJTisn4/jZSFLDTO802iMBjnr0yEBI/+gxdel/CawE8T+TC5PeSc08/4zA4nTbM1wThmXNwk1A
        HprIcYTXxMJ8CHe/lnLj7
X-Received: by 2002:ac8:598b:0:b0:39d:9b6:69b3 with SMTP id e11-20020ac8598b000000b0039d09b669b3mr7692947qte.39.1667150529829;
        Sun, 30 Oct 2022 10:22:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Dk+KkOvrrP3MpVWYtppipjk4B4K/I4Euc13541SOxoveysaouQDittrzMAvU/bssh9bNjNA==
X-Received: by 2002:ac8:598b:0:b0:39d:9b6:69b3 with SMTP id e11-20020ac8598b000000b0039d09b669b3mr7692910qte.39.1667150529468;
        Sun, 30 Oct 2022 10:22:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-170.dyn.eolo.it. [146.241.106.170])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006ee7923c187sm3213642qko.42.2022.10.30.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:22:08 -0700 (PDT)
Message-ID: <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
Date:   Sun, 30 Oct 2022 18:22:03 +0100
In-Reply-To: <20221028154617.3c63ba68@kernel.org>
References: <20221027150525.753064657@goodmis.org>
         <20221027150928.780676863@goodmis.org>
         <20221027155513.60b211e2@gandalf.local.home>
         <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
         <20221027163453.383bbf8e@gandalf.local.home>
         <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
         <20221027170720.31497319@gandalf.local.home>
         <20221027183511.66b058c4@gandalf.local.home>
         <20221028183149.2882a29b@gandalf.local.home>
         <20221028154617.3c63ba68@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

On Fri, 2022-10-28 at 15:46 -0700, Jakub Kicinski wrote:
> On Fri, 28 Oct 2022 18:31:49 -0400 Steven Rostedt wrote:
> > Could someone from networking confirm (or deny) that the timer being
> > removed in sk_stop_timer() will no longer be used even if del_timer()
> > returns false?
> > 
> > net/core/sock.c:
> > 
> > void sk_stop_timer(struct sock *sk, struct timer_list* timer)
> > {
> > 	if (del_timer(timer))
> > 		__sock_put(sk);
> > }
> > 
> > If this is the case, then I'll add the following interface:
> > 
> >    del_timer_sync_shutdown() // the common case which syncs
> > 
> >    del_timer_shutdown() // the uncommon case, that returns immediately
> >                         // used for those cases that add extra code to
> >                         // handle it, like sk_stop_timer()
> 
> Sorry too many bugs at once :)
> 
> FWIW Paolo was saying privately earlier today that he spotted some cases
> of reuse, he gave an example of ccid2_hc_tx_packet_recv()

For the records, there are other cases, e.g. after sk_stop_timer() in 
clear_3rdack_retransmission() (mptcp code) the timer can be-rearmed
without re-initializing. I *think* there are more of such use in the 
in ax25/rose code.

> So we can't convert all cases of sk_stop_timer() in one fell swoop :(

On the positive side, I think converting the sk_stop_timer in 
inet_csk_clear_xmit_timers() should be safe and should cover the issue
reported by Guenter

Cheers,

Paolo

