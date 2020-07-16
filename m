Return-Path: <lvs-devel-owner@vger.kernel.org>
X-Original-To: lists+lvs-devel@lfdr.de
Delivered-To: lists+lvs-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90F221A6A
	for <lists+lvs-devel@lfdr.de>; Thu, 16 Jul 2020 04:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGPC7t (ORCPT <rfc822;lists+lvs-devel@lfdr.de>);
        Wed, 15 Jul 2020 22:59:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgGPC7t (ORCPT <rfc822;lvs-devel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:59:49 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 4521F2657A58F676BFDC;
        Thu, 16 Jul 2020 10:59:47 +0800 (CST)
Received: from DGGEMI521-MBX.china.huawei.com ([169.254.6.174]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Thu, 16 Jul 2020 10:59:39 +0800
From:   "Zhouxudong (EulerOS)" <zhouxudong8@huawei.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
CC:     "wensong@linux-vs.org" <wensong@linux-vs.org>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>,
        "Zhaowei (EulerOS)" <zhaowei23@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBpcHZzOiBjbGVhbiBjb2RlIGZvciBpcF92c19z?=
 =?gb2312?Q?ync.c?=
Thread-Topic: [PATCH v2] ipvs: clean code for ip_vs_sync.c
Thread-Index: AQHWWxSOrskhb2r7QUuW/2oKWGRrKakI+lSAgACJVLA=
Date:   Thu, 16 Jul 2020 02:59:37 +0000
Message-ID: <69D1AB391AAC5746B9ECCF192D064D641A7949E1@DGGEMI521-MBX.china.huawei.com>
References: <1594864671-31512-1-git-send-email-zhouxudong8@huawei.com>
 <20200716024627.GC14742@blackclown>
In-Reply-To: <20200716024627.GC14742@blackclown>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.155.96]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: lvs-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <lvs-devel.vger.kernel.org>
X-Mailing-List: lvs-devel@vger.kernel.org

VGhhbmsgeW91IGZvciBzdWdnZXN0aW9uLg0KSSB3aWxsIHNlbmQgdjMgcGF0Y2guDQoNCi0tLS0t
08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTdXJhaiBVcGFkaHlheSBbbWFpbHRvOnVzdXJhajM1QGdt
YWlsLmNvbV0gDQq3osvNyrG85DogMjAyMMTqN9TCMTbI1SAxMDo0Ng0KytW8/sjLOiBaaG91eHVk
b25nIChFdWxlck9TKSA8emhvdXh1ZG9uZzhAaHVhd2VpLmNvbT4NCrOty806IHdlbnNvbmdAbGlu
dXgtdnMub3JnOyBob3Jtc0B2ZXJnZS5uZXQuYXU7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGx2
cy1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7
IENoZW54aWFuZyAoRXVsZXJPUykgPHJvc2UuY2hlbkBodWF3ZWkuY29tPjsgWmhhb3dlaSAoRXVs
ZXJPUykgPHpoYW93ZWkyM0BodWF3ZWkuY29tPg0K1vfM4jogUmU6IFtQQVRDSCB2Ml0gaXB2czog
Y2xlYW4gY29kZSBmb3IgaXBfdnNfc3luYy5jDQoNCk9uIFRodSwgSnVsIDE2LCAyMDIwIGF0IDAx
OjU3OjUxQU0gKzAwMDAsIHpob3V4dWRvbmcxOTkgd3JvdGU6DQo+IHYxIC0+IHYyOg0KPiBhZGQg
bWlzc2luZyBzcGFjZXMgYWZ0ZXIgU2lnbmVkLW9mZi1ieSBhbmQgaXB2czogaW4gdGhlIHN1Ympl
Y3QuIA0KPiBpPTAgY2hhbmdlZCB0byBpID0gMC4gIA0KPg0KDQpZb3Ugc2hvdWxkIHdyaXRlIHRo
ZSB2ZXJzaW9uIGNoYW5nZXMgYWZ0ZXIgIi0tLSIgYW5kIGJlZm9yZSB0aGUgZmlyc3QgZGlmZi4N
Cg0KQWxzbywgbG9va2luZyBhdCB5b3VyIHBhdGNoIEkgdGhpbmsgeW91ciBjb21taXQgbWVzc2Fn
ZSBzaG91bGQgYmUgc29tZXRoaW5nIGxpa2UgdGhpcyA6DQoNCiJVc2UgYXBwcm9wcmlhdGUgc3Bh
Y2VzIGFyb3VuZCBvcGVyYXRvcnMuIg0KDQo+IFNpZ25lZC1vZmYtYnk6IHpob3V4dWRvbmcxOTkg
PHpob3V4dWRvbmc4QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgbmV0L25ldGZpbHRlci9pcHZzL2lw
X3ZzX3N5bmMuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvbmV0
ZmlsdGVyL2lwdnMvaXBfdnNfc3luYy5jIA0KPiBiL25ldC9uZXRmaWx0ZXIvaXB2cy9pcF92c19z
eW5jLmMgaW5kZXggNjA1ZTBmNi4uODg1YmFiNCAxMDA2NDQNCj4gLS0tIGEvbmV0L25ldGZpbHRl
ci9pcHZzL2lwX3ZzX3N5bmMuYw0KPiArKysgYi9uZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfc3lu
Yy5jDQo+IEBAIC0xMDc3LDEwICsxMDc3LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGlwX3ZzX3By
b2Nfc3luY19jb25uKHN0cnVjdCBuZXRuc19pcHZzICppcHZzLCBfX3U4ICpwLCBfX3U4ICptDQo+
ICAJc3RydWN0IGlwX3ZzX3Byb3RvY29sICpwcDsNCj4gIAlzdHJ1Y3QgaXBfdnNfY29ubl9wYXJh
bSBwYXJhbTsNCj4gIAlfX3UzMiBmbGFnczsNCj4gLQl1bnNpZ25lZCBpbnQgYWYsIHN0YXRlLCBw
ZV9kYXRhX2xlbj0wLCBwZV9uYW1lX2xlbj0wOw0KPiAtCV9fdTggKnBlX2RhdGE9TlVMTCwgKnBl
X25hbWU9TlVMTDsNCj4gLQlfX3UzMiBvcHRfZmxhZ3M9MDsNCj4gLQlpbnQgcmV0Yz0wOw0KPiAr
CXVuc2lnbmVkIGludCBhZiwgc3RhdGUsIHBlX2RhdGFfbGVuID0gMCwgcGVfbmFtZV9sZW4gPSAw
Ow0KPiArCV9fdTggKnBlX2RhdGEgPSBOVUxMLCAqcGVfbmFtZSA9IE5VTEw7DQo+ICsJX191MzIg
b3B0X2ZsYWdzID0gMDsNCj4gKwlpbnQgcmV0YyA9IDA7DQo+ICANCj4gIAlzID0gKHVuaW9uIGlw
X3ZzX3N5bmNfY29ubiAqKSBwOw0KPiAgDQo+IEBAIC0xMDg5LDcgKzEwODksNyBAQCBzdGF0aWMg
aW5saW5lIGludCBpcF92c19wcm9jX3N5bmNfY29ubihzdHJ1Y3QgbmV0bnNfaXB2cyAqaXB2cywg
X191OCAqcCwgX191OCAqbQ0KPiAgCQlhZiA9IEFGX0lORVQ2Ow0KPiAgCQlwICs9IHNpemVvZihz
dHJ1Y3QgaXBfdnNfc3luY192Nik7DQo+ICAjZWxzZQ0KPiAtCQlJUF9WU19EQkcoMywiQkFDS1VQ
LCBJUHY2IG1zZyByZWNlaXZlZCwgYW5kIElQVlMgaXMgbm90IGNvbXBpbGVkIGZvciBJUHY2XG4i
KTsNCj4gKwkJSVBfVlNfREJHKDMsICJCQUNLVVAsIElQdjYgbXNnIHJlY2VpdmVkLCBhbmQgSVBW
UyBpcyBub3QgY29tcGlsZWQgDQo+ICtmb3IgSVB2NlxuIik7DQo+ICAJCXJldGMgPSAxMDsNCj4g
IAkJZ290byBvdXQ7DQo+ICAjZW5kaWYNCj4gQEAgLTExMjksNyArMTEyOSw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlwX3ZzX3Byb2Nfc3luY19jb25uKHN0cnVjdCBuZXRuc19pcHZzICppcHZzLCBf
X3U4ICpwLCBfX3U4ICptDQo+ICAJCQlicmVhazsNCj4gIA0KPiAgCQljYXNlIElQVlNfT1BUX1BF
X05BTUU6DQo+IC0JCQlpZiAoaXBfdnNfcHJvY19zdHIocCwgcGxlbiwmcGVfbmFtZV9sZW4sICZw
ZV9uYW1lLA0KPiArCQkJaWYgKGlwX3ZzX3Byb2Nfc3RyKHAsIHBsZW4sICZwZV9uYW1lX2xlbiwg
JnBlX25hbWUsDQo+ICAJCQkJCSAgIElQX1ZTX1BFTkFNRV9NQVhMRU4sICZvcHRfZmxhZ3MsDQo+
ICAJCQkJCSAgIElQVlNfT1BUX0ZfUEVfTkFNRSkpDQo+ICAJCQkJcmV0dXJuIC03MDsNCj4gQEAg
LTExNTUsNyArMTE1NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGlwX3ZzX3Byb2Nfc3luY19jb25u
KHN0cnVjdCBuZXRuc19pcHZzICppcHZzLCBfX3U4ICpwLCBfX3U4ICptDQo+ICAJaWYgKCEoZmxh
Z3MgJiBJUF9WU19DT05OX0ZfVEVNUExBVEUpKSB7DQo+ICAJCXBwID0gaXBfdnNfcHJvdG9fZ2V0
KHMtPnY0LnByb3RvY29sKTsNCj4gIAkJaWYgKCFwcCkgew0KPiAtCQkJSVBfVlNfREJHKDMsIkJB
Q0tVUCwgVW5zdXBwb3J0ZWQgcHJvdG9jb2wgJXVcbiIsDQo+ICsJCQlJUF9WU19EQkcoMywgIkJB
Q0tVUCwgVW5zdXBwb3J0ZWQgcHJvdG9jb2wgJXVcbiIsDQo+ICAJCQkJcy0+djQucHJvdG9jb2wp
Ow0KPiAgCQkJcmV0YyA9IDMwOw0KPiAgCQkJZ290byBvdXQ7DQo+IEBAIC0xMjMyLDcgKzEyMzIs
NyBAQCBzdGF0aWMgdm9pZCBpcF92c19wcm9jZXNzX21lc3NhZ2Uoc3RydWN0IG5ldG5zX2lwdnMg
KmlwdnMsIF9fdTggKmJ1ZmZlciwNCj4gIAkJbXNnX2VuZCA9IGJ1ZmZlciArIHNpemVvZihzdHJ1
Y3QgaXBfdnNfc3luY19tZXNnKTsNCj4gIAkJbnJfY29ubnMgPSBtMi0+bnJfY29ubnM7DQo+ICAN
Cj4gLQkJZm9yIChpPTA7IGk8bnJfY29ubnM7IGkrKykgew0KPiArCQlmb3IgKGkgPSAwOyBpIDwg
bnJfY29ubnM7IGkrKykgew0KPiAgCQkJdW5pb24gaXBfdnNfc3luY19jb25uICpzOw0KPiAgCQkJ
dW5zaWduZWQgaW50IHNpemU7DQo+ICAJCQlpbnQgcmV0YzsNCj4gQEAgLTE0NDQsNyArMTQ0NCw3
IEBAIHN0YXRpYyBpbnQgYmluZF9tY2FzdGlmX2FkZHIoc3RydWN0IHNvY2tldCAqc29jaywgc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIAlzaW4uc2luX2FkZHIuc19hZGRyICA9IGFkZHI7DQo+
ICAJc2luLnNpbl9wb3J0ICAgICAgICAgPSAwOw0KDQpJIHRoaW5rIHlvdSBtaXNzZWQgdGhpcyBv
bmUuDQpzaG91bGQgYmUNCi0gICAgICAgIHNpbi5zaW5fcG9ydCAgICAgICAgID0gMDsNCisJIHNp
bi5zaW5fcG9ydCA9IDANCg0KVGhhbmtzIGFuZCBDaGVlcnMsDQpTdXJhaiBVcGFkaHlheS4NCg0K
PiAtCXJldHVybiBzb2NrLT5vcHMtPmJpbmQoc29jaywgKHN0cnVjdCBzb2NrYWRkciopJnNpbiwg
c2l6ZW9mKHNpbikpOw0KPiArCXJldHVybiBzb2NrLT5vcHMtPmJpbmQoc29jaywgKHN0cnVjdCBz
b2NrYWRkciAqKSZzaW4sIHNpemVvZihzaW4pKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQg
Z2V0X21jYXN0X3NvY2thZGRyKHVuaW9uIGlwdnNfc29ja2FkZHIgKnNhLCBpbnQgKnNhbGVuLA0K
PiAtLQ0KPiAyLjYuMS53aW5kb3dzLjENCj4gDQo+IA0K
