Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A82635324
	for <lists+lvs-devel@lfdr.de>; Wed, 23 Nov 2022 09:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiKWIsm (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 23 Nov 2022 03:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiKWIsU (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Wed, 23 Nov 2022 03:48:20 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 00:48:10 PST
Received: from mail.alsdel.com (mail.alsdel.com [192.121.17.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB6014D0A
        for <lvs-devel@vger.kernel.org>; Wed, 23 Nov 2022 00:48:09 -0800 (PST)
Received: by mail.alsdel.com (Postfix, from userid 1001)
        id F181722A96; Wed, 23 Nov 2022 08:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsdel.com; s=mail;
        t=1669192842; bh=EaccI34atZDi3zI4z+dro7EdezTMN10KG2X0nSBpSo8=;
        h=Date:From:To:Subject:From;
        b=fqcxaRGiL7BiixsqxJOsce3ApIgz+wWd+LjWDxYz1FFPca3wIKa/DF83Aa9Ad6mWs
         ySbFNY5fNZKHuz1JWzc6KXFQ/PhJ1J/aLmMSY5SXfnXmEnsewj0zWktbaWTkVS9IMR
         ChGJs/Cy+YkQPiTyevaN6deK9dgeLHVjWQ1ezHvyGrS6rMjxg2OfocNJCzi7hq1vBe
         h3oCjv0rNESXQa2CgamfZk/gPyS43ZoyXQCasx7/jqO/U42cBcGhHpAPOkw8dGmV7g
         ghZzjbW+Sa6jUoCooCVOl6QV6wRq8EAg3yBiQM9us7rLeEsAkseANyZ3gQX2Plb/UJ
         RpmnMI1SuDV0Q==
Received: by mail.alsdel.com for <lvs-devel@vger.kernel.org>; Wed, 23 Nov 2022 08:40:35 GMT
Message-ID: <20221123074500-0.1.g.vi8.0.uggzl939zo@alsdel.com>
Date:   Wed, 23 Nov 2022 08:40:35 GMT
From:   =?UTF-8?Q? "Vil=C3=A9m_Du=C5=A1ek" ?= <vilem.dusek@alsdel.com>
To:     <lvs-devel@vger.kernel.org>
Subject: =?UTF-8?Q?Tepeln=C3=A9_obr=C3=A1b=C4=9Bn=C3=AD_=E2=80=93_objedn=C3=A1vka?=
X-Mailer: mail.alsdel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Dobr=C3=BD den,

m=C3=A1te z=C3=A1jem o vyu=C5=BEit=C3=AD velmi kvalitn=C3=AD slu=C5=BEby =
tepeln=C3=A9ho obr=C3=A1b=C4=9Bn=C3=AD kov=C5=AF?

M=C5=AF=C5=BEeme v=C3=A1m nab=C3=ADdnout velmi v=C3=BDhodn=C3=A9 podm=C3=AD=
nky spolupr=C3=A1ce, technick=C3=A9 poradenstv=C3=AD,
s=C3=A9riovou v=C3=BDrobu a testov=C3=A1n=C3=AD prototyp=C5=AF.

Specializujeme se na tradi=C4=8Dn=C3=AD a vakuov=C3=A9 technologie: cemen=
tov=C3=A1n=C3=AD,
nitrocementov=C3=A1n=C3=AD, kalen=C3=AD v plynu, zu=C5=A1lecht=C4=9Bn=C3=AD=
, =C5=BE=C3=ADh=C3=A1n=C3=AD, p=C3=A1jen=C3=AD, normaliza=C4=8Dn=C3=AD =C5=
=BE=C3=ADh=C3=A1n=C3=AD (s p=C5=99ekrystalizac=C3=AD).

M=C3=A1me k dispozici rozs=C3=A1hl=C3=A9 strojn=C3=AD vybaven=C3=AD, velk=
=C3=BD t=C3=BDm odborn=C3=ADk=C5=AF, a proto jsme schopni se p=C5=99izp=C5=
=AFsobit va=C5=A1im po=C5=BEadavk=C5=AFm.

Pracujeme v souladu s na=C5=A1imi certifik=C3=A1ty v rozsahu norem platn=C3=
=BDch v oblasti automobilov=C3=A9ho pr=C5=AFmyslu (IATF 16949; CQI 9) a t=
ak=C3=A9 letectv=C3=AD (akreditace NADCAP).

Pokud m=C3=A1te po=C5=BEadavky v t=C3=A9to oblasti, r=C3=A1d v=C3=A1m p=C5=
=99edstav=C3=ADm na=C5=A1e mo=C5=BEnosti.

Mohl bych v=C3=A1m zatelefonovat?


S pozdravem,
Vil=C3=A9m Du=C5=A1ek
