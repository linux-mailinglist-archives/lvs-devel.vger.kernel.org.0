Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7810A168
	for <lists+lvs-devel@lfdr.de>; Tue, 26 Nov 2019 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfKZPrC (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Tue, 26 Nov 2019 10:47:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37448 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfKZPrC (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Tue, 26 Nov 2019 10:47:02 -0500
Received: by mail-io1-f71.google.com with SMTP id p2so13646777iof.4
        for <lvs-devel@vger.kernel.org>; Tue, 26 Nov 2019 07:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NMIhDQ1/TzZzQjr2wWUncjr9UXV8W0Q6CWNH9QCoYyc=;
        b=SZAh/Th93oa/8gwaxzjRAiIoqBzjJouQyheuLpXIUAReEzHcyx9A6hlc+IaFH7vnWU
         vJMHpY1PSwRjwlNwf0uxBs4yVdG7E83xs6FxhWWvGix1AzQnoyN57+E24UbdxB+H6Jzi
         JYgQk7mqQ9Wjk9Nl329D7zNEOr6Du9iuPlLIoSoLFPaqSajEfAMf51GA3bA/EsQll4RM
         bOvjKVXqWv/xHf2lA+npCbPKxI6ktSELkSsQtGSJB4wySCj2Ys7gCaab9TC0p67PLKvd
         dt64LMkiDHC+zgtzkx9Jq47x3EF3sSDMMPldlbX2KgTlcWPQxU5LjLVxdtqE1eKBGX+v
         CrZw==
X-Gm-Message-State: APjAAAV0963u3dWeclesKpYHqDkSTiNOl57mANt6fNMBKdClnOXDIJKe
        1GsXpny6rceR6xxPdzVXELVb3NJOI68fNrNIB8tn65afdZiN
X-Google-Smtp-Source: APXvYqwGLVmd6lBzBXRckmAQHo5bBkT8ic7o+qm5KSqWVZbE1t3yqtpg3LGxYvDX6Q2q+YWCGwHbZNwPiZQhQ+pyU2BTIV7K7AFJ
MIME-Version: 1.0
X-Received: by 2002:a6b:3b06:: with SMTP id i6mr14691402ioa.185.1574783220874;
 Tue, 26 Nov 2019 07:47:00 -0800 (PST)
Date:   Tue, 26 Nov 2019 07:47:00 -0800
In-Reply-To: <94eb2c059ce0bca273056940d77d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a85c4059841ca66@google.com>
Subject: Re: INFO: task hung in do_ip_vs_set_ctl (2)
From:   syzbot <syzbot+7810ed2e0cb359580c17@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@blackhole.kfki.hu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvs-devel@vger.kernel.org, mmarek@suse.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        wensong@linux-vs.org, yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

syzbot has bisected this bug to:

commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Jul 2 23:07:02 2017 +0000

     Linux 4.12

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a2b78ce00000
start commit:   17dec0a9 Merge branch 'userns-linus' of git://git.kernel.o..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=da08d02b86752ade
dashboard link: https://syzkaller.appspot.com/bug?extid=7810ed2e0cb359580c17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130abb47800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150a15bb800000

Reported-by: syzbot+7810ed2e0cb359580c17@syzkaller.appspotmail.com
Fixes: 6f7da290413b ("Linux 4.12")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
