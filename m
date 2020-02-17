Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7584161708
	for <lists+lvs-devel@lfdr.de>; Mon, 17 Feb 2020 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgBQQLp (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Mon, 17 Feb 2020 11:11:45 -0500
Received: from mail4-bck.iservicesmail.com ([217.130.24.84]:55308 "EHLO
        mail4-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728724AbgBQQLo (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Mon, 17 Feb 2020 11:11:44 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 11:11:44 EST
IronPort-SDR: fd/fLM+7vwImnHWv8kdHT72Y2dpsbZap4zlqrbn4FyjxBaOmDrWo7FTq2KZGZBMFiHxk0wljIa
 os844PEWVa8A==
IronPort-PHdr: =?us-ascii?q?9a23=3AJ24VhRZdArCEBgC2NKcTFov/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMS7bnLW6fgltlLVR4KTs6sC17OK9f++Ejxbqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQbgIRuJ6U/xx?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcF2kalVog+upwZnzoDaYI+VLuRwcKDAc9wVWW?=
 =?us-ascii?q?VPUd1cVzBDD4ygc4cDE/YNMfheooLgp1UOtxy+BQy0Ce311DBImmH53bcn2O?=
 =?us-ascii?q?shFgHG2gMgFM8JvXvJsdX1Lr0dUea6zKnP1jjDavRW2Sv66IfUcxAhvfGNUa?=
 =?us-ascii?q?h1ccve0EQiER7OgFaIqYH9IT+Zy+YAv3KG4+duSe6jkXArpg5rrjWhxsohjJ?=
 =?us-ascii?q?TCiJgPxVDe7yp5xZ44Jdi/SEFmf9GpCIBQtySGN4tuRcMiXn1otD46yrIYvZ?=
 =?us-ascii?q?67ezAHyJE9yB7eb/yHaZaH4hb/WOueOzt4mnVld6+liBa89kigzPPzWtOq31?=
 =?us-ascii?q?ZRtiZFk9/MuW4R1xHL9MSLV/lw8l281TuBywzf8P9ILE8umafVK5Mt2rswmY?=
 =?us-ascii?q?ASsUTHEC/2gkL2jKqOe0o55+io8f7oYrPppp+bLIJ0jwb+MrgpmsOjAOQ4Lg?=
 =?us-ascii?q?gPU3Ke+eWzzLHj51H2QK1Wjv0qlanUqJTaJdoApqKgHgBazJgj5Ai7Dzq9zt?=
 =?us-ascii?q?QYkmcILEhfdBKEkYfpIVfOL+78DfulhFSsijhrlLj6OejlHI6IInXdnbPJY7?=
 =?us-ascii?q?lw8QhfxRA1wNQZ4IhbWYsMOPbiZkikjNHEAwVxDAuyzK6zENhh25kBXmSAAq?=
 =?us-ascii?q?yZK6nZmVCN7+MrZeKLYdlGliz6Lq0d6uLjlzcGnlkSNf2lwIEebn+/NvFhP0?=
 =?us-ascii?q?KSYGb9xNIRRzRZ9jEiRfDn3QXRGQVYYGy/Cvox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HHMwB7uUpeeiMYgtlmgkOBPgIBgUU?=
 =?us-ascii?q?QUiASjGOGbFEBAQEGcx+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBGxoCBAEBhEC?=
 =?us-ascii?q?CByQ8Ag0CAw0BAQYBAQEBAQUEAQECEAEBCwsLBCuFSoI7IoNwIA85SkwBDgG?=
 =?us-ascii?q?GIgEBCimkcIkBDQ0ChR6COgQKgiMjgTYDAQGMIRp5gQeBIyGCKwgBggGCfwE?=
 =?us-ascii?q?SAW6CSIJZBI1SEiGJRZg0gkQElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+?=
 =?us-ascii?q?fZoQUV4Egc3EzGggwgW4agSBPGA2cYgJAgRcQAk+LKYIyAQE?=
X-IPAS-Result: =?us-ascii?q?A2HHMwB7uUpeeiMYgtlmgkOBPgIBgUUQUiASjGOGbFEBA?=
 =?us-ascii?q?QEGcx+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBGxoCBAEBhECCByQ8Ag0CAw0BA?=
 =?us-ascii?q?QYBAQEBAQUEAQECEAEBCwsLBCuFSoI7IoNwIA85SkwBDgGGIgEBCimkcIkBD?=
 =?us-ascii?q?Q0ChR6COgQKgiMjgTYDAQGMIRp5gQeBIyGCKwgBggGCfwESAW6CSIJZBI1SE?=
 =?us-ascii?q?iGJRZg0gkQElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+fZoQUV4Egc3EzG?=
 =?us-ascii?q?ggwgW4agSBPGA2cYgJAgRcQAk+LKYIyAQE?=
X-IronPort-AV: E=Sophos;i="5.70,453,1574118000"; 
   d="scan'208";a="338422212"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 17 Feb 2020 17:06:39 +0100
Received: (qmail 20956 invoked from network); 17 Feb 2020 09:22:11 -0000
Received: from unknown (HELO 192.168.1.163) (mariapazos@[217.217.179.17])
          (envelope-sender <durango@motocity.mx>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <lvs-devel@vger.kernel.org>; 17 Feb 2020 09:22:11 -0000
Date:   Mon, 17 Feb 2020 10:22:10 +0100 (CET)
From:   Peter Wong <durango@motocity.mx>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     lvs-devel@vger.kernel.org
Message-ID: <27231194.588247.1581931331776.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Greetings,
Please check the attached email for a buisness proposal to explore.
Looking forward to hearing from you for more details.
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

