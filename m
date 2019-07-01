Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7C2AA5C
	for <lists+lvs-devel@lfdr.de>; Sun, 26 May 2019 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfEZPDL (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 26 May 2019 11:03:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37498 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZPDL (ORCPT
        <rfc822;lvs-devel@vger.kernel.org>); Sun, 26 May 2019 11:03:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so7636978pgm.4
        for <lvs-devel@vger.kernel.org>; Sun, 26 May 2019 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Dv9F2KoAn2iwPKTWcH+DXxVOcYmbJVa4LvTKxdxW7s=;
        b=lm3AhuaDDsBd836VVYAPJgWuqQCFvjj/rQ2ZxxrR7H9TgGh5y0E1VQkq3C6SXofqbX
         YWQf8dRQGqe+bKFAsXgf37Qp0UPADZdcTETTjv1GqbpaERZ2rMUWoh51rg312ISM2+mm
         oHNZ37H6ZqSkKTurmB/nDZRIdPrs/MPj0hYFdqpa1z5QlGOlRtmQswFtSY7HkM7+UdYf
         tnZSF/uk1zqBCcTcPbAZy9E4TjdNnVDqK+VK97BYFWXzwFldStMiErt+lWqsIwnX7FhW
         yVReQIXH0YIo4m7GenE2PkAW0sHy8qfb8O6VlHPkdidOtT1845fQPVxH7R0B4eIQ/GUT
         2eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Dv9F2KoAn2iwPKTWcH+DXxVOcYmbJVa4LvTKxdxW7s=;
        b=KyDOHssv5ivE2iPKUCe6NeR9S1HdJebkarzEsZbQa0VDpOGkUdzEEFS414yE59Ny3+
         wsNHHckgdPXEzIJgGpdEqM0g1lTdjzmwFL7gEPBjo1Z8RguRsiGsT4YStsrPEsj+t2NC
         G5mFNrs4JOkwtqwy9FmmYOAOKNK6OwC5d3QEem2twwfC88xcUbGOkUTECJjI1x0Aljxn
         nx4mubdSqHVIEQZzq0ZYfiUz5H2BjA0zXEUu9DQzf9h9zXFfc7OyKF8XruH1AZ/xNtW5
         81Jdoenfm+aEng25lx10uNgerHhOx3XBmCilPGsJRDJyM2yEoMLl3tkcr/OlbXDU2Vo6
         26ng==
X-Gm-Message-State: APjAAAWOLIALPbg1hdb35jLokvI6aNXh89YdS6P1J20xEHMVeNg/jX5D
        JLr5qRBf43OHayGjgsYMRg==
X-Google-Smtp-Source: APXvYqyZnBrrbm6KBJfocbCb1Tzr5gbcFUjxkKFYzWvj7ZS4+T8XU+G+v8iQWOinWsvP0lxXZogVOA==
X-Received: by 2002:a65:62c6:: with SMTP id m6mr25913374pgv.306.1558882989899;
        Sun, 26 May 2019 08:03:09 -0700 (PDT)
Received: from localhost ([2001:19f0:7001:54c5:5400:1ff:fec8:7fc2])
        by smtp.gmail.com with ESMTPSA id q28sm3683426pfn.106.2019.05.26.08.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 08:03:09 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     hengqing.hu@gmail.com
Cc:     brouer@redhat.com, horms@verge.net.au, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, jacky.hu@walmart.com,
        jason.niesz@walmart.com
Subject: [PATCH v7 1/2] ipvsadm: convert options to unsigned long long
Date:   Sun, 26 May 2019 23:01:05 +0800
Message-Id: <20190526150106.18622-2-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526150106.18622-1-hengqing.hu@gmail.com>
References: <20190526150106.18622-1-hengqing.hu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

To allow up to 64 options to be specified.
Add calculated logarithm constants for existing options.
Remove opt2name function to avoid recalculation.

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
---
 ipvsadm.c | 117 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 48 deletions(-)

diff --git a/ipvsadm.c b/ipvsadm.c
index 0cb2b68..9e7a448 100644
--- a/ipvsadm.c
+++ b/ipvsadm.c
@@ -189,6 +189,35 @@ static const char* cmdnames[] = {
 #define OPT_SYNC_MAXLEN	0x08000000
 #define NUMBER_OF_OPT		28
 
+#define OPTC_NUMERIC		0
+#define OPTC_CONNECTION		1
+#define OPTC_SERVICE		2
+#define OPTC_SCHEDULER		3
+#define OPTC_PERSISTENT		4
+#define OPTC_NETMASK		5
+#define OPTC_SERVER		6
+#define OPTC_FORWARD		7
+#define OPTC_WEIGHT		8
+#define OPTC_UTHRESHOLD		9
+#define OPTC_LTHRESHOLD		10
+#define OPTC_MCAST		11
+#define OPTC_TIMEOUT		12
+#define OPTC_DAEMON		13
+#define OPTC_STATS		14
+#define OPTC_RATE		15
+#define OPTC_THRESHOLDS		16
+#define OPTC_PERSISTENTCONN	17
+#define OPTC_NOSORT		18
+#define OPTC_SYNCID		19
+#define OPTC_EXACT		20
+#define OPTC_ONEPACKET		21
+#define OPTC_PERSISTENCE_ENGINE	22
+#define OPTC_SCHED_FLAGS	23
+#define OPTC_MCAST_GROUP	24
+#define OPTC_MCAST_PORT		25
+#define OPTC_MCAST_TTL		26
+#define OPTC_SYNC_MAXLEN	27
+
 static const char* optnames[] = {
 	"numeric",
 	"connection",
@@ -320,9 +349,9 @@ static unsigned int parse_fwmark(char *buf);
 static unsigned int parse_sched_flags(const char *sched, char *optarg);
 
 /* check the options based on the commands_v_options table */
-static void generic_opt_check(int command, int options);
+static void generic_opt_check(int command, unsigned long long options);
 static void set_command(int *cmd, const int newcmd);
-static void set_option(unsigned int *options, unsigned int option);
+static void set_option(unsigned long long *options, int optc);
 
 static void tryhelp_exit(const char *program, const int exit_status);
 static void usage_exit(const char *program, const int exit_status);
@@ -416,7 +445,7 @@ static char *protocol_name(int proto)
 
 static int
 parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
-	      unsigned int *options, unsigned int *format)
+	      unsigned long long *options, unsigned int *format)
 {
 	int c, parse;
 	poptContext context;
@@ -575,7 +604,7 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 		case 't':
 		case 'u':
 		case TAG_SCTP_SERVICE:
-			set_option(options, OPT_SERVICE);
+			set_option(options, OPTC_SERVICE);
 			ce->svc.protocol = option_to_protocol(c);
 			parse = parse_service(optarg, &ce->svc);
 			if (!(parse & SERVICE_ADDR))
@@ -583,7 +612,7 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 				     "address[:port] specified");
 			break;
 		case 'f':
-			set_option(options, OPT_SERVICE);
+			set_option(options, OPTC_SERVICE);
 			/*
 			 * Set protocol to a sane values, even
 			 * though it is not used
@@ -593,18 +622,18 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 			ce->svc.fwmark = parse_fwmark(optarg);
 			break;
 		case 's':
-			set_option(options, OPT_SCHEDULER);
+			set_option(options, OPTC_SCHEDULER);
 			strncpy(ce->svc.sched_name,
 				optarg, IP_VS_SCHEDNAME_MAXLEN - 1);
 			break;
 		case 'p':
-			set_option(options, OPT_PERSISTENT);
+			set_option(options, OPTC_PERSISTENT);
 			ce->svc.flags |= IP_VS_SVC_F_PERSISTENT;
 			ce->svc.timeout =
 				parse_timeout(optarg, 1, MAX_TIMEOUT);
 			break;
 		case 'M':
-			set_option(options, OPT_NETMASK);
+			set_option(options, OPTC_NETMASK);
 			if (ce->svc.af != AF_INET6) {
 				parse = parse_netmask(optarg, &ce->svc.netmask);
 				if (parse != 1)
@@ -617,7 +646,7 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 			}
 			break;
 		case 'r':
-			set_option(options, OPT_SERVER);
+			set_option(options, OPTC_SERVER);
 			ipvs_service_t t_dest = ce->svc;
 			parse = parse_service(optarg, &t_dest);
 			ce->dest.af = t_dest.af;
@@ -631,84 +660,84 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 				ce->dest.port = ce->svc.port;
 			break;
 		case 'i':
-			set_option(options, OPT_FORWARD);
+			set_option(options, OPTC_FORWARD);
 			ce->dest.conn_flags = IP_VS_CONN_F_TUNNEL;
 			break;
 		case 'g':
-			set_option(options, OPT_FORWARD);
+			set_option(options, OPTC_FORWARD);
 			ce->dest.conn_flags = IP_VS_CONN_F_DROUTE;
 			break;
 		case 'm':
-			set_option(options, OPT_FORWARD);
+			set_option(options, OPTC_FORWARD);
 			ce->dest.conn_flags = IP_VS_CONN_F_MASQ;
 			break;
 		case 'w':
-			set_option(options, OPT_WEIGHT);
+			set_option(options, OPTC_WEIGHT);
 			if ((ce->dest.weight =
 			     string_to_number(optarg, 0, 65535)) == -1)
 				fail(2, "illegal weight specified");
 			break;
 		case 'x':
-			set_option(options, OPT_UTHRESHOLD);
+			set_option(options, OPTC_UTHRESHOLD);
 			if ((ce->dest.u_threshold =
 			     string_to_number(optarg, 0, INT_MAX)) == -1)
 				fail(2, "illegal u_threshold specified");
 			break;
 		case 'y':
-			set_option(options, OPT_LTHRESHOLD);
+			set_option(options, OPTC_LTHRESHOLD);
 			if ((ce->dest.l_threshold =
 			     string_to_number(optarg, 0, INT_MAX)) == -1)
 				fail(2, "illegal l_threshold specified");
 			break;
 		case 'c':
-			set_option(options, OPT_CONNECTION);
+			set_option(options, OPTC_CONNECTION);
 			break;
 		case 'n':
-			set_option(options, OPT_NUMERIC);
+			set_option(options, OPTC_NUMERIC);
 			*format |= FMT_NUMERIC;
 			break;
 		case TAG_MCAST_INTERFACE:
-			set_option(options, OPT_MCAST);
+			set_option(options, OPTC_MCAST);
 			strncpy(ce->daemon.mcast_ifn,
 				optarg, IP_VS_IFNAME_MAXLEN - 1);
 			break;
 		case 'I':
-			set_option(options, OPT_SYNCID);
+			set_option(options, OPTC_SYNCID);
 			if ((ce->daemon.syncid =
 			     string_to_number(optarg, 0, 255)) == -1)
 				fail(2, "illegal syncid specified");
 			break;
 		case TAG_TIMEOUT:
-			set_option(options, OPT_TIMEOUT);
+			set_option(options, OPTC_TIMEOUT);
 			break;
 		case TAG_DAEMON:
-			set_option(options, OPT_DAEMON);
+			set_option(options, OPTC_DAEMON);
 			break;
 		case TAG_STATS:
-			set_option(options, OPT_STATS);
+			set_option(options, OPTC_STATS);
 			*format |= FMT_STATS;
 			break;
 		case TAG_RATE:
-			set_option(options, OPT_RATE);
+			set_option(options, OPTC_RATE);
 			*format |= FMT_RATE;
 			break;
 		case TAG_THRESHOLDS:
-			set_option(options, OPT_THRESHOLDS);
+			set_option(options, OPTC_THRESHOLDS);
 			*format |= FMT_THRESHOLDS;
 			break;
 		case TAG_PERSISTENTCONN:
-			set_option(options, OPT_PERSISTENTCONN);
+			set_option(options, OPTC_PERSISTENTCONN);
 			*format |= FMT_PERSISTENTCONN;
 			break;
 		case TAG_NO_SORT:
-			set_option(options, OPT_NOSORT	);
+			set_option(options, OPTC_NOSORT);
 			*format |= FMT_NOSORT;
 			break;
 		case TAG_SORT:
 			/* Sort is the default, this is a no-op for compatibility */
 			break;
 		case 'X':
-			set_option(options, OPT_EXACT);
+			set_option(options, OPTC_EXACT);
 			*format |= FMT_EXACT;
 			break;
 		case '6':
@@ -720,20 +749,20 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 			}
 			break;
 		case 'o':
-			set_option(options, OPT_ONEPACKET);
+			set_option(options, OPTC_ONEPACKET);
 			ce->svc.flags |= IP_VS_SVC_F_ONEPACKET;
 			break;
 		case TAG_PERSISTENCE_ENGINE:
-			set_option(options, OPT_PERSISTENCE_ENGINE);
+			set_option(options, OPTC_PERSISTENCE_ENGINE);
 			strncpy(ce->svc.pe_name, optarg, IP_VS_PENAME_MAXLEN);
 			break;
 		case 'b':
-			set_option(options, OPT_SCHED_FLAGS);
+			set_option(options, OPTC_SCHED_FLAGS);
 			snprintf(sched_flags_arg, sizeof(sched_flags_arg),
 				"%s", optarg);
 			break;
 		case TAG_MCAST_GROUP:
-			set_option(options, OPT_MCAST_GROUP);
+			set_option(options, OPTC_MCAST_GROUP);
 			if (strchr(optarg, ':')) {
 				if (inet_pton(AF_INET6, optarg,
 					      &ce->daemon.mcast_group) <= 0 ||
@@ -753,21 +782,21 @@ parse_options(int argc, char **argv, struct ipvs_command_entry *ce,
 			}
 			break;
 		case TAG_MCAST_PORT:
-			set_option(options, OPT_MCAST_PORT);
+			set_option(options, OPTC_MCAST_PORT);
 			parse = string_to_number(optarg, 1, 65535);
 			if (parse == -1)
 				fail(2, "illegal mcast-port specified");
 			ce->daemon.mcast_port = parse;
 			break;
 		case TAG_MCAST_TTL:
-			set_option(options, OPT_MCAST_TTL);
+			set_option(options, OPTC_MCAST_TTL);
 			parse = string_to_number(optarg, 1, 255);
 			if (parse == -1)
 				fail(2, "illegal mcast-ttl specified");
 			ce->daemon.mcast_ttl = parse;
 			break;
 		case TAG_SYNC_MAXLEN:
-			set_option(options, OPT_SYNC_MAXLEN);
+			set_option(options, OPTC_SYNC_MAXLEN);
 			parse = string_to_number(optarg, 1, 65535 - 20 - 8);
 			if (parse == -1)
 				fail(2, "illegal sync-maxlen specified");
@@ -845,7 +874,7 @@ static int restore_table(int argc, char **argv, int reading_stdin)
 static int process_options(int argc, char **argv, int reading_stdin)
 {
 	struct ipvs_command_entry ce;
-	unsigned int options = OPT_NONE;
+	unsigned long long options = OPT_NONE;
 	unsigned int format = FMT_NONE;
 	int result = 0;
 
@@ -1164,7 +1193,7 @@ static unsigned int parse_sched_flags(const char *sched, char *optarg)
 }
 
 static void
-generic_opt_check(int command, int options)
+generic_opt_check(int command, unsigned long long options)
 {
 	int i, j;
 	int last = 0, count = 0;
@@ -1173,7 +1202,7 @@ generic_opt_check(int command, int options)
 	i = command - CMD_NONE -1;
 
 	for (j = 0; j < NUMBER_OF_OPT; j++) {
-		if (!(options & (1<<j))) {
+		if (!(options & (1ULL<<j))) {
 			if (commands_v_options[i][j] == '+')
 				fail(2, "You need to supply the '%s' "
 				     "option for the '%s' command",
@@ -1197,15 +1226,6 @@ generic_opt_check(int command, int options)
 	}
 }
 
-static inline const char *
-opt2name(int option)
-{
-	const char **ptr;
-	for (ptr = optnames; option > 1; option >>= 1, ptr++);
-
-	return *ptr;
-}
-
 static void
 set_command(int *cmd, const int newcmd)
 {
@@ -1215,10 +1235,11 @@ set_command(int *cmd, const int newcmd)
 }
 
 static void
-set_option(unsigned int *options, unsigned int option)
+set_option(unsigned long long *options, int optc)
 {
+	unsigned long long option = 1ULL<<optc;
 	if (*options & option)
-		fail(2, "multiple '%s' options specified", opt2name(option));
+		fail(2, "multiple '%s' options specified", optnames[optc]);
 	*options |= option;
 }
 
-- 
2.21.0

