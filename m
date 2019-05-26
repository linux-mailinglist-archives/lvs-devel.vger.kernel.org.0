Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6112A957
	for <lists+lvs-devel@lfdr.de>; Sun, 26 May 2019 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfEZLJ5 (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Sun, 26 May 2019 07:09:57 -0400
Received: from ja.ssi.bg ([178.16.129.10]:54718 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbfEZLJ5 (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Sun, 26 May 2019 07:09:57 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x4QB9R0T010742;
        Sun, 26 May 2019 14:09:27 +0300
Date:   Sun, 26 May 2019 14:09:27 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Jacky Hu <hengqing.hu@gmail.com>
cc:     brouer@redhat.com, horms@verge.net.au, lvs-devel@vger.kernel.org,
        lvs-users@linuxvirtualserver.org, jacky.hu@walmart.com,
        jason.niesz@walmart.com
Subject: Re: [PATCH v6 2/2] ipvsadm: allow tunneling with gue encapsulation
In-Reply-To: <20190526065038.17067-2-hengqing.hu@gmail.com>
Message-ID: <alpine.LFD.2.21.1905261242050.6354@ja.home.ssi.bg>
References: <20190526065038.17067-1-hengqing.hu@gmail.com> <20190526065038.17067-2-hengqing.hu@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org


	Hello,

On Sun, 26 May 2019, Jacky Hu wrote:

> Added the following options with adding and editing destinations for
> tunneling servers:
> --tun-type
> --tun-port
> --tun-nocsum
> --tun-csum
> --tun-remcsum
> 
> Added the following options with listing services for tunneling servers:
> --tun-info
> 
> Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>

	Patch v6 1/2 looks ok.

> @@ -259,21 +277,63 @@ static const char* optnames[] = {
>   */
>  static const char commands_v_options[NUMBER_OF_CMD][NUMBER_OF_OPT] =
>  {
> -	/*   -n   -c   svc  -s   -p   -M   -r   fwd  -w   -x   -y   -mc  tot  dmn  -st  -rt  thr  -pc  srt  sid  -ex  ops  -pe  -b   grp  port ttl  size */
> -/*ADD*/     {'x', 'x', '+', ' ', ' ', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ' ', ' ', ' ', 'x', 'x', 'x', 'x'},
> -/*EDIT*/    {'x', 'x', '+', ' ', ' ', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ' ', ' ', ' ', 'x', 'x', 'x', 'x'},
> -/*DEL*/     {'x', 'x', '+', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*FLUSH*/   {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*LIST*/    {' ', '1', '1', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', '1', '1', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*ADDSRV*/  {'x', 'x', '+', 'x', 'x', 'x', '+', ' ', ' ', ' ', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*DELSRV*/  {'x', 'x', '+', 'x', 'x', 'x', '+', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*EDITSRV*/ {'x', 'x', '+', 'x', 'x', 'x', '+', ' ', ' ', ' ', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*TIMEOUT*/ {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*STARTD*/  {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ' ', 'x', 'x', 'x', 'x', ' ', ' ', ' ', ' '},
> -/*STOPD*/   {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*RESTORE*/ {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*SAVE*/    {' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> -/*ZERO*/    {'x', 'x', ' ', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
> +	/*   -n   -c   svc  -s   -p   -M   -r   fwd  -w   -x   -y   -mc  tot  dmn  -st  -rt  thr  -pc  srt  sid  -ex  ops  -pe  -b   grp  port ttl  size  tun-info  tun-type  tun-port  tun-nocsum  tun-csum  tun-remcsum */

	We can use up to 4 letters in the comments, eg:

tinf type tprt nocs csum remc

	Otherwise, we can not match the column names with data

> +		case TAG_TUN_NOCSUM:
> +			set_option(options, OPTC_TUN_NOCSUM);
> +			ce->dest.tun_flags = IP_VS_TUNNEL_ENCAP_FLAG_NOCSUM;

	Lets use |= for the flags, it will help in the future
if new flags are added.

> +			break;
> +		case TAG_TUN_CSUM:
> +			set_option(options, OPTC_TUN_CSUM);
> +			ce->dest.tun_flags |= IP_VS_TUNNEL_ENCAP_FLAG_CSUM;
> +			break;
> +		case TAG_TUN_REMCSUM:
> +			set_option(options, OPTC_TUN_REMCSUM);
> +			ce->dest.tun_flags |= IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM;
> +			break;
>  		default:

> +static int parse_tun_type(const char *tun_type)
> +{
> +	unsigned int type = -1;

	This can be 'int' too

> +
> +	if (!strcmp(tun_type, "ipip"))
> +		type = IP_VS_CONN_F_TUNNEL_TYPE_IPIP;
> +	else if (!strcmp(tun_type, "gue"))
> +		type = IP_VS_CONN_F_TUNNEL_TYPE_GUE;
> +	else
> +		type = -1;
> +
> +	return type;
> +}
> +

	May be we can also add info for the new options in
ipvsadm.8, may be after the --ipip option and before the -m.
It can work this way if you don't have better syntax:

.ti +8
.B --tun-type \fIipip | gue\fP
.ti +16
Info...
.sp
.ti +8
.B --tun-port \fIport\fP
.ti +16
Port used for GUE .....
.sp

	One example below would be helpful too.

	When posting next version always include all patches
in the patchset, also having 0/2 info is recommended.

Regards

--
Julian Anastasov <ja@ssi.bg>
