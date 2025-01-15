Return-Path: <lvs-devel+bounces-303-lists+lvs-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CCA12B01
	for <lists+lvs-devel@lfdr.de>; Wed, 15 Jan 2025 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF02188B658
	for <lists+lvs-devel@lfdr.de>; Wed, 15 Jan 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60351D63EC;
	Wed, 15 Jan 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hlvrMdsI"
X-Original-To: lvs-devel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A41D63F6
	for <lvs-devel@vger.kernel.org>; Wed, 15 Jan 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966029; cv=none; b=Mv+9Vh2X0nSDjwX6tu55a9soUwcvqq0uhqls0cPm5veI0BqzAMianAQ43Z2UUk8AT0fyhqBtfwIEyMhtK5ku99xcd/SDSFDWbzscc7CFJAQZY7ED/pU4F7Yeox/4E0Nt9pOamSne76kI7djsUfDsok9el78mvyApR1bk4ad1i9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966029; c=relaxed/simple;
	bh=Q3Xj0sHElfdapiszIYSNNu9esB62UnMGSf6us1EUExk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp2mRwcf7xZpiqwY2bytj2ZVnWLx3Ymu1KeWBnKhOnp3uncxTVwSw5I3IrOMau4V9+gJnaIxL93fFo2XW3VTYfndNykicmIS3ffqrM8MicnFaUJHIDkAAI/rHGpXFATTU68bPU2wIuLvKaiPJKwchwvdKc2QCjIKB054XQpOOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hlvrMdsI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=j8ulFrmm4rXYuecNpiRGZxeA2cdvMYycNx8jmkTsTsQ=; b=hlvrMdsIvaae/mEZZ4/PP1rBsj
	NxYTlK1nXBlb3pXVgGXWcmEMzcBALNyCguChHDLnheW+1sHVuEHrTtAdTOPIKh/79bY9m8iqd1pVy
	HZhJKVrcGOOhC1rD2xrohfr/i88kYG/Uoq26jrxjg/+VmoJ0tPxt40gJv2z93eYouZNrve8mm9cBB
	q7ZH0Gk2FFLV/XwzBMnIaNubFos5drVt+UnNwrLzNLYYW70s3xMbHeJX8MgbWQ99VrudNzOL4sfjq
	x6Q/IkOycUk4ywi6PWz77v/c2iLyKO8xQoii3suC55BLTFccqG0NTM/v5lVpA2IJ7XTU/We8Vk2wq
	u3ZmYSiQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <azazel@debian.org>)
	id 1tY8Cx-001zdF-R0
	for lvs-devel@vger.kernel.org; Wed, 15 Jan 2025 18:33:39 +0000
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
	by taras.nevrast.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <azazel@debian.org>)
	id 1tY8Cn-000D3I-0f
	for lvs-devel@vger.kernel.org;
	Wed, 15 Jan 2025 18:33:29 +0000
From: Jeremy Sowden <azazel@debian.org>
To: LVS Devel <lvs-devel@vger.kernel.org>
Subject: [PATCH ipvsadm v3 1/5] ipvsadm: increase maximum weight value
Date: Wed, 15 Jan 2025 18:33:07 +0000
Message-ID: <20250115183311.3386192-2-azazel@debian.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115183311.3386192-1-azazel@debian.org>
References: <20250115183311.3386192-1-azazel@debian.org>
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

The IPVS kernel module accepts weight up to 2,147,483,647 (INT_MAX), but
ipvsadm limits it to 65,535.  Raise the user space maximum to match the
kernel.

Link: https://bugs.debian.org/814348
Signed-off-by: Jeremy Sowden <azazel@debian.org>
---
 ipvsadm.8 | 2 +-
 ipvsadm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipvsadm.8 b/ipvsadm.8
index b3bc822aaafc..3d7541a4bf62 100644
--- a/ipvsadm.8
+++ b/ipvsadm.8
@@ -386,7 +386,7 @@ servers are added or modified.
 .B -w, --weight \fIweight\fP
 \fIWeight\fP is an integer specifying the capacity  of a server
 relative to the others in the pool. The valid values of \fIweight\fP
-are 0 through to 65535. The default is 1. Quiescent servers are
+are 0 through to 2147483647. The default is 1. Quiescent servers are
 specified with a weight of zero. A quiescent server will receive no
 new jobs but still serve the existing jobs, for all scheduling
 algorithms distributed with the Linux Virtual Server. Setting a
diff --git a/ipvsadm.c b/ipvsadm.c
index 663d47ab1138..42f31a20e596 100644
--- a/ipvsadm.c
+++ b/ipvsadm.c
@@ -762,7 +762,7 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 		case 'w':
 			set_option(options, OPTC_WEIGHT);
 			if ((ce->dest.weight =
-			     string_to_number(optarg, 0, 65535)) == -1)
+			     string_to_number(optarg, 0, INT_MAX)) == -1)
 				fail(2, "illegal weight specified");
 			break;
 		case 'x':
-- 
2.45.2


