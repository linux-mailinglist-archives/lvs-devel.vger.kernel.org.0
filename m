Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF61249B0
	for <lists+lvs-devel@lfdr.de>; Wed, 18 Dec 2019 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLROan (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 18 Dec 2019 09:30:43 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33989 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLROam (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 18 Dec 2019 09:30:42 -0500
Received: by mail-vk1-f195.google.com with SMTP id w67so690761vkf.1
        for <lvs-devel@vger.kernel.org>; Wed, 18 Dec 2019 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=r1KvxAtdQhustQozNaJYEi20sqrxgumQgyMs2x3s4g3ITZ8eFniU+gd0cQasFCTCbe
         /h/owWL1V2lzQD+49WQrCAOp6B/qmX7MgaQ+9eRZtwqsvrjI51ipT5TG3TEmYzzug/+O
         mP3cYoefkJp0PKwc9f6ZlHEP+WjYcGhUI6eFXxhl0VeGK/h21HgDZt8fQfYxOjSgZ/sx
         yVH91vBeFFjPeZGTqA5Iu/CnKUISIM1++HWB7ikUR/x6WC3izY5QkaltSjoQywSVe6jP
         /6lhSqgGl8GVw4V6Oa6dWMv29WU4wbPFXfVDyBCqpwpb4PuopQ7u8GuiCrOu5IqHfbd+
         PZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=TrkHeQLnWKgbYRd4bGDdUGefHlRhYzR9XURR4I8tx0noKZaI9hNz3iHCW1lMzHFuKN
         X8hNXZGof/tooHXvkD0Si+qi2FRVhu31GLhRIyO1ki4yqEzn8JQg1ySjLkkgNHAkLBIP
         HixhnYuyGeDthEzEg0BUTeB4wl8ZCLfHheiyptIsd33pZOx/V0zpTBDYU55198TpQHmx
         T8WIEmkt4pG8rM1bWGP3MGb4i89fxpgODkanWODoNsqvO/TsM4nTTrJ38QjEO9syFElP
         QXWRUzi3deKViAXugW/hu9xm1tuTJyt9+MqvT78WUiLLUfYYnhdXdVZLvWJ0d+GGwaiz
         sL2g==
X-Gm-Message-State: APjAAAVVDx4x351JMU6DYAuTRxCqWfsokbzFu7N5vJw9nk+/Bz/yn6FS
        LWCenIXLGb+wlUFQm5+Rf56pctJu24SqDS62qWw=
X-Google-Smtp-Source: APXvYqzlRSa2UbT/WiNzF1PYEZWowkSjBgTZxAtNRBHor1mawh7LOtGG4Dttu6ZwEFjPlQOFHLt7ZqYxahEcg717AN4=
X-Received: by 2002:a1f:18cf:: with SMTP id 198mr1868464vky.61.1576679441612;
 Wed, 18 Dec 2019 06:30:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9f:2924:0:0:0:0:0 with HTTP; Wed, 18 Dec 2019 06:30:40
 -0800 (PST)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <mrbid001@gmail.com>
Date:   Wed, 18 Dec 2019 06:30:40 -0800
Message-ID: <CAJbTw5_yVVoMbw=N9s6ezYcB_bosucPbht8d79J+9fALVYkRVw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

RGVhciBGcmllbmQsDQpJIGFtIEJhcnJpc3RlciBBYnJhaGFtIE1vcnJpc29uLCBEaWQgeW91IHJl
Y2VpdmUgbXkgcHJldmlvdXMgbWVzc2FnZQ0KdG8geW91PyBJIGhhdmUgYW4gaW1wb3J0YW50IGlu
Zm9ybWF0aW9uIGZvciB5b3UgYWJvdXQgeW91ciBpbmhlcml0YW5jZQ0KZnVuZCB3b3J0aCBvZiAo
JDIwLDUwMCwwMDAuMDApIE1pbGxpb24gd2hpY2ggd2FzIGxlZnQgZm9yIHlvdSBieSB5b3VyDQps
YXRlIHJlbGF0aXZlLCBNci4gQ2FybG9zLiBTbyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgZ2V0IGJh
Y2sgdG8gbWUgZm9yDQptb3JlIGRldGFpbHMuDQpUaGFuayB5b3UuDQpCYXJyaXN0ZXIgQWJyYWhh
bSBNb3JyaXNvbi4NCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uDQrQlNC+0YDQvtCz0L7QuSDQtNGA0YPQsywNCtCvINCR0LDRgNGA0LjR
gdGC0LXRgCDQkNCy0YDQsNCw0Lwg0JzQvtGA0YDQuNGB0L7QvSwg0JLRiyDQv9C+0LvRg9GH0LjQ
u9C4INC80L7QtSDQv9GA0LXQtNGL0LTRg9GJ0LXQtSDRgdC+0L7QsdGJ0LXQvdC40LUg0LTQu9GP
DQrQstCw0YE/INCjINC80LXQvdGPINC10YHRgtGMINC00LvRjyDQstCw0YEg0LLQsNC20L3QsNGP
INC40L3RhNC+0YDQvNCw0YbQuNGPINC+INCy0LDRiNC10Lwg0L3QsNGB0LvQtdC00YHRgtCy0LXQ
vdC90L7QvA0K0YTQvtC90LTQtSDQvdCwINGB0YPQvNC80YMgKDIwIDUwMCAwMDAsMDAg0LTQvtC7
0LvQsNGA0L7QsiDQodCo0JApLCDQutC+0YLQvtGA0YvQuSDQvtGB0YLQsNCy0LjQuyDQstCw0Lwg
0LLQsNGIDQrQv9C+0LrQvtC50L3Ri9C5INGA0L7QtNGB0YLQstC10L3QvdC40LosINC80LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEuINCi0LDQuiDRh9GC0L4sINC10YHQu9C4INCy0Ysg0LfQsNC40L3R
gtC10YDQtdGB0L7QstCw0L3RiywNCtGB0LLRj9C20LjRgtC10YHRjCDRgdC+INC80L3QvtC5INC0
0LvRjyDQsdC+0LvQtdC1INC/0L7QtNGA0L7QsdC90L7QuSDQuNC90YTQvtGA0LzQsNGG0LjQuC4N
CtCh0L/QsNGB0LjQsdC+Lg0K0JHQsNGA0YDQuNGB0YLQtdGAINCQ0LLRgNCw0LDQvCDQnNC+0YDR
gNC40YHQvtC9Lg0K
