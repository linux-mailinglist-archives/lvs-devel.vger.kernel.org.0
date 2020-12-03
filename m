Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490A12CD1B8
	for <lists+lvs-devel@lfdr.de>; Thu,  3 Dec 2020 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgLCItD (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Thu, 3 Dec 2020 03:49:03 -0500
Received: from mg.ssi.bg ([178.16.128.9]:46972 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgLCItC (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:49:02 -0500
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id BCF7E25DC0;
        Thu,  3 Dec 2020 10:48:20 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id A4DB225DB5;
        Thu,  3 Dec 2020 10:48:19 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id CB1CD3C09BA;
        Thu,  3 Dec 2020 10:48:18 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 0B38mGUD005806;
        Thu, 3 Dec 2020 10:48:17 +0200
Date:   Thu, 3 Dec 2020 10:48:16 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     "dust.li" <dust.li@linux.alibaba.com>
cc:     yunhong-cgl jiang <xintian1976@gmail.com>, horms@verge.net.au,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        Yunhong Jiang <yunhjiang@ebay.com>
Subject: Re: Long delay on estimation_timer causes packet latency
In-Reply-To: <d89672f8-a028-8690-0e6a-517631134ef6@linux.alibaba.com>
Message-ID: <2cf7e20-89c0-2a40-d27e-3d663e7080cb@ssi.bg>
References: <D25792C1-1B89-45DE-9F10-EC350DC04ADC@gmail.com> <alpine.LFD.2.21.2004171029240.3962@ja.home.ssi.bg> <F48099A3-ECB3-46AF-8330-B829ED2ADA3F@gmail.com> <d89672f8-a028-8690-0e6a-517631134ef6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1211976290-1606985298=:4387"
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1211976290-1606985298=:4387
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 3 Dec 2020, dust.li wrote:

> Hi Yunhong & Julian, any updates ?
> 
> 
> We've encountered the same problem. With lots of ipvs
> 
> services plus many CPUs, it's easy to reproduce this issue.
> 
> I have a simple script to reproduce:
> 
> First add many ipvs services:
> 
> for((i=0;i<50000;i++)); do
>         ipvsadm -A -t 10.10.10.10:$((2000+$i))
> done
> 
> 
> Then, check the latency of estimation_timer() using bpftrace:
> 
> #!/usr/bin/bpftrace
> 
> kprobe:estimation_timer {
>         @enter = nsecs;
> }
> 
> kretprobe:estimation_timer {
>         $exit = nsecs;
>         printf("latency: %ld us\n", (nsecs - @enter)/1000);
> }
> 
> I observed about 268ms delay on my 104 CPUs test server.
> 
> Attaching 2 probes...
> latency: 268807 us
> latency: 268519 us
> latency: 269263 us
> 
> 
> And I tried moving estimation_timer() into a delayed
> 
> workqueue, this do make things better. But since the
> 
> estimation won't give up CPU, it can run for pretty
> 
> long without scheduling on a server which don't have
> 
> preempt enabled, so tasks on that CPU can't get executed
> 
> during that period.
> 
> 
> Since the estimation repeated every 2s, we can't call
> 
> cond_resched() to give up CPU in the middle of iterating the
> 
> est_list, or the estimation will be quite inaccurate.
> 
> Besides the est_list needs to be protected.
> 
> 
> I haven't found any ideal solution yet, currently, we just
> 
> moved the estimation into kworker and add sysctl to allow
> 
> us to disable the estimation, since we don't need the
> 
> estimation anyway.
> 
> 
> Our patches is pretty simple now, if you think it's useful,
> 
> I can paste them
> 
> 
> Do you guys have any suggestions or solutions ?

	When I saw the report first time, I thought on this
issue and here is what I think:

- single delayed work (slow to stop them if using many)

- the delayed work walks say 64 lists with estimators and
reschedules itself for the next 30ms, as result, 30ms*64=1920ms,
80ms will be idle up to the 2000ms period for estimation
for every list. As result, every list is walked once per 2000ms.
If 30ms is odd for all kind of HZ values, this can be
20ms * 100.

- work will use spin_lock_bh(&s->lock) to protect the
entries, we do not want delays between /proc readers and
the work if using mutex. But _bh locks stop timers and
networking for short time :( Not sure yet if just spin_lock
is safe for both /proc and estimator's work.

- while walking one of the 64 lists we should use just
rcu read locking for the current list, no cond_resched_rcu
because we do not know how to synchronize while entries are
removed at the same time. For now using array with 64 lists
solves this problem.

- the algorith will look like this:

	int row = 0;

	for () {
		rcu_read_lock();
		list_for_each_entry_rcu(e, &ipvs->est_list[row], list) {

		...

			/* Should we stop immediately ? */
			if (!ipvs->enable || stopping delayed work) {
				rcu_read_unlock();
				goto out;
			}
		}
		/* rcu_read_unlock will reschedule if needed
		 * but we know where to start from the next time,
		 * i.e. from next slot
		 */
		rcu_read_unlock();
		reschedule delayed work for +30ms or +110ms if last row
		by using queue_delayed_work*()
		row ++;
		if (row >= 64)
			row = 0;
	}

out:

- the drawback is that without cond_resched_rcu we are not
fair to other processes, solution is needed, we just reduce
the problem by using 64 lists which can be imbalanced.

- next goal: entries should be removed with list_del_rcu,
without any locks, we do not want to delay configurations,
ipvs->est_lock should be removed.

- now the problem is how to spread the entries to 64 lists.
One way is randomly, in this case first estimation may be
for less than 2000ms. In this case, less entries means
less work for all 64 steps. But what if entries are removed
and some slots become empty and others too large?

- if we want to make the work equal for all 64 passes, we
can rebalance the lists, say on every 2000ms move some
entries to neighbour list. As result, one entry can be
estimated after 1970ms or 2030ms. But this is complication
not possible with the RCU locking, we need a safe way
to move entries to neighbour list, say if work walks
row 0 we can rebalance between rows 32 and 33 which are
1 second away of row 0. And not all list primitives allow
it for _rcu.

- next options is to insert entries in some current list,
if their count reaches, say 128, then move to the next list
for inserting. This option tries to provide exact 2000ms
delay for the first estimation for the newly added entry.

	We can start with some implementation and see if
your tests are happy.

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1211976290-1606985298=:4387--

