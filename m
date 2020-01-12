Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C624613854E
	for <lists+lvs-devel@lfdr.de>; Sun, 12 Jan 2020 07:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgALGdA (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 12 Jan 2020 01:33:00 -0500
Received: from mail3.iservicesmail.com ([217.130.24.75]:12794 "EHLO
        mail3.iservicesmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbgALGc7 (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 12 Jan 2020 01:32:59 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 01:32:58 EST
IronPort-SDR: PbrI+3+D+GduPlsbijo2DmXY/lFJjO98x8VGoBvcp0vbvEjeznhFBBLSJlm/K+i+mAzt1OS2hk
 pJi7lHX9IEJQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AYXi+mxy6+gmo5kfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+IRIJqq85mqBkHD//Il1AaPAdyAraga1aGH6OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IRS3oAnessQbj5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxPujysJKiI2/3vSis1wla5WvhWhpwZnw47TeoGaLuZ+cb3EcdwEQ2?=
 =?us-ascii?q?pNR9pcVzBdAoymc4QPD/QOPeNGoIn7u1sCtAWxBQ+1CO3ozT9IgGH53K0j3+?=
 =?us-ascii?q?s/FwHNwQgsEtwSvHjIqdn4MroZX+Kow6nS1TjNYfNY2S3j5obLbx4uru2DU7?=
 =?us-ascii?q?1rfMrNy0QgCx/JgkmMpYD7OT6ey+QDs3Kc7+plTe+hkXAoqx1vrTi128wjio?=
 =?us-ascii?q?7JhoQaylvZ8ih52Jg6JcGmR05hb9+kF51Qty6BOot2WcMtWH1ntDwmxb0BvJ?=
 =?us-ascii?q?63ZigKyJc+yhPZdveJcJCI7wr9WOqMIzp0nm9pdbyjixqo70StxffwW8e03V?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2nV/5jK6SdkU+5Oeo7/jrb7r8qp+CMI97lxvxMqopmsy5H+s0KB?=
 =?us-ascii?q?YBX3OD9eS90r3s41H5Ta1UgvErkKTVqo3WKMoHqqKjHQNY3Zwv5hi/Aju+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIOjmAvejnVusijlqx/fAPr3uGZjNLmPDn6z9cr?=
 =?us-ascii?q?pn90Fczw8zwcpf55JXEr0BOu78WlfttNzECR80Kwi0w/j8CNlky4wRR3yPDb?=
 =?us-ascii?q?GdMK7Jr1+I6fwgI/OWaI8Wpjn9Mf4l6ODqjXMjnl8dZ6apjtMrbyW8AO8jL0?=
 =?us-ascii?q?iHbH7EnNgMCyEJsxA4Qeisj0eNAgRef3KjY6Vp3jwnBZjuMoDFScj5mLGd0T?=
 =?us-ascii?q?2kGZtZZmNGEVqHOXjtfoSAHfwLbXTBDNVml2k8WKSsUcce0heh/FvixqZqNP?=
 =?us-ascii?q?XT/CIwtYnp355+4OiVlRJkpm88NNiUz2zYFjI8pWgPXTJjh/gnrA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GeAgAbvBpelyMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznXoBjQQNDQKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GeAgAbvBpelyMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznXoBj?=
 =?us-ascii?q?QQNDQKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="303983128"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 07:27:56 +0100
Received: (qmail 24519 invoked from network); 12 Jan 2020 05:35:57 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <lvs-devel@vger.kernel.org>; 12 Jan 2020 05:35:57 -0000
Date:   Sun, 12 Jan 2020 06:35:56 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     lvs-devel@vger.kernel.org
Message-ID: <6111917.573495.1578807357635.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

