Return-Path: <lvs-devel+bounces-286-lists+lvs-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5FA0ABBB
	for <lists+lvs-devel@lfdr.de>; Sun, 12 Jan 2025 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A2F3A7391
	for <lists+lvs-devel@lfdr.de>; Sun, 12 Jan 2025 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF215383B;
	Sun, 12 Jan 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qp1QZGJg"
X-Original-To: lvs-devel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB314A4D1
	for <lvs-devel@vger.kernel.org>; Sun, 12 Jan 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736712286; cv=none; b=CD3HsDKBrNU3JMKPlU9wnC0xLD6B4vHdPAPc12CX5GOdaOOPxsuTJhsu0i7xOYtnHZg11qciKSnWHUoLiHDYn4FfGW1NTiCh5WYpTHnuaU1Ogu2VIAbszjgpUIr4vn20vT/pU3+5gTQ/3ZU6mAjOq95gbfQbKDb0c99dThlSdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736712286; c=relaxed/simple;
	bh=Mmzd/Qs/6PMLmyl6rAemU14Pbu8UQrnl5P2kH97dC/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDxkfmTv/Ce+7JWNWW0kiyVjfv91CzRujNlnqrYUt/CvfhFMVQLArdKNiOb5hXW+UDPzCNc1qQIqzrGqyAz7y8C8PGdBqY6ivz95Mczjq4A4G2s3xwhhCpXpNLM9UyfRN7UzDg8Y2c5pBNHScE3QFR/58fxLTUoWdZASw3b8UIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qp1QZGJg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=ewv8G3kcFGkD6EdxHcr5N72+DovT78ZIeujWS9V24p4=; b=qp1QZGJgjeLrdTlFz3Dg3mjGVy
	U1dtOZMLbotUDJYEva1ly25sFpPpZaSBWcTxW5vcoFIANm7bxNkgBcZ8S7IVw7hzsWIAaL+ZNq0ts
	OdKyqPXn7Rfk/H5ei+D0QArfaVkd+qu2VeQ0SjEUHvPm+TmRNz2MNns0YS4r5feP9Z084MpBdZeLB
	13jXmConKnonmSmWQ0gIXYTLoCJNyb5NpgBVwCg72s4Xo51iA0prfhKthz9tQOUig2MXXm9GQvoFx
	yrCjG5OLONafn7xFHwDgg7eKiSd3ghqr7Iy1U8wxJNdZpziRu/sMvix42Wrk3w8801XLwOlV8lXmw
	V9RH3+EA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <azazel@debian.org>)
	id 1tX4CK-00H6mk-CF
	for lvs-devel@vger.kernel.org; Sun, 12 Jan 2025 20:04:36 +0000
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
	by taras.nevrast.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <azazel@debian.org>)
	id 1tX4CJ-000H3S-15
	for lvs-devel@vger.kernel.org;
	Sun, 12 Jan 2025 20:04:35 +0000
From: Jeremy Sowden <azazel@debian.org>
To: LVS Devel <lvs-devel@vger.kernel.org>
Subject: [PATCH ipvsadm 4/5] Support environmental and command-line `*FLAGS` variable in Makefiles
Date: Sun, 12 Jan 2025 20:03:32 +0000
Message-ID: <20250112200333.3180808-5-azazel@debian.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250112200333.3180808-1-azazel@debian.org>
References: <20250112200333.3180808-1-azazel@debian.org>
Precedence: bulk
X-Mailing-List: lvs-devel@vger.kernel.org
List-Id: <lvs-devel.vger.kernel.org>
List-Subscribe: <mailto:lvs-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lvs-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: azazel@debian.org
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false
X-Debian-User: azazel

The Makefiles don't use `CPPFLAGS` or `LDFLAGS`, and set `CFLAGS`
unconditionally.  Rename `CFLAGS`, and add `CPPFLAGS` and `LDFLAGS` to the
compilation and linking recipes in order to support the common patterns of
providing these flags via the command-line and the environment.

Signed-off-by: Jeremy Sowden <azazel@debian.org>
---
 Makefile         |  8 ++++----
 libipvs/Makefile | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index d247d4075160..d79f72496000 100644
--- a/Makefile
+++ b/Makefile
@@ -47,9 +47,9 @@ INSTALL		= install
 STATIC_LIBS	= libipvs/libipvs.a
 
 ifeq "${ARCH}" "sparc64"
-    CFLAGS = -Wall -Wunused -Wstrict-prototypes -g -m64 -pipe -mcpu=ultrasparc -mcmodel=medlow
+    DEFAULT_CFLAGS = -Wall -Wunused -Wstrict-prototypes -g -m64 -pipe -mcpu=ultrasparc -mcmodel=medlow
 else
-    CFLAGS = -Wall -Wunused -Wstrict-prototypes -g
+    DEFAULT_CFLAGS = -Wall -Wunused -Wstrict-prototypes -g
 endif
 
 
@@ -88,7 +88,7 @@ libs:
 		make -C libipvs
 
 ipvsadm:	$(OBJS) $(STATIC_LIBS)
-		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+		$(CC) $(DEFAULT_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
 install:        all
 		if [ ! -d $(SBIN) ]; then $(MKDIR) -p $(SBIN); fi
@@ -140,4 +140,4 @@ debs:
 		dpkg-buildpackage
 
 %.o:	%.c
-		$(CC) $(CFLAGS) $(INCLUDE) $(DEFINES) -c -o $@ $<
+		$(CC) $(DEFAULT_CFLAGS) $(CFLAGS) $(INCLUDE) $(DEFINES) $(CPPFLAGS) -c -o $@ $<
diff --git a/libipvs/Makefile b/libipvs/Makefile
index b31c8eac514d..f29671178422 100644
--- a/libipvs/Makefile
+++ b/libipvs/Makefile
@@ -2,10 +2,10 @@
 
 CC		= gcc
 PKG_CONFIG	?= pkg-config
-CFLAGS		= -Wall -Wunused -Wstrict-prototypes -g -fPIC
+DEFAULT_CFLAGS	= -Wall -Wunused -Wstrict-prototypes -g -fPIC
 ifneq (0,$(HAVE_NL))
-CFLAGS		+= -DLIBIPVS_USE_NL
-CFLAGS		+= $(shell \
+DEFINES		+= -DLIBIPVS_USE_NL
+DEFAULT_CFLAGS	+= $(shell \
 		if which $(PKG_CONFIG) > /dev/null 2>&1; then \
 		  if   $(PKG_CONFIG) --cflags libnl-3.0  2> /dev/null; then :; \
 		  elif $(PKG_CONFIG) --cflags libnl-2.0  2> /dev/null; then :; \
@@ -16,7 +16,7 @@ endif
 
 INCLUDE		+= $(shell if [ -f ../../ip_vs.h ]; then	\
 		     echo "-I../../."; fi;)
-DEFINES		= $(shell if [ ! -f ../../ip_vs.h ]; then	\
+DEFINES		+= $(shell if [ ! -f ../../ip_vs.h ]; then	\
 		    echo "-DHAVE_NET_IP_VS_H"; fi;)
 DEFINES		+= $(shell if which $(PKG_CONFIG) > /dev/null 2>&1; then \
 			 if   $(PKG_CONFIG) --exists libnl-3.0; then :; \
@@ -34,10 +34,10 @@ $(STATIC_LIB):	libipvs.o ip_vs_nl_policy.o
 		ar rv $@ $^
 
 $(SHARED_LIB):	libipvs.o ip_vs_nl_policy.o
-		$(CC) -shared -Wl,-soname,$@ -o $@ $^
+		$(CC) $(DEFAULT_CFLAGS) $(CFLAGS) -shared -Wl,-soname,$@ $(LDFLAGS) -o $@ $^
 
 %.o:		%.c
-		$(CC) $(CFLAGS) $(INCLUDE) $(DEFINES) -c -o $@ $<
+		$(CC) $(DEFAULT_CFLAGS) $(CFLAGS) $(INCLUDE) $(DEFINES) $(CPPFLAGS) -c -o $@ $<
 
 clean:
 		rm -f *.[ao] *~ *.orig *.rej core *.so
-- 
2.45.2


