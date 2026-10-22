---
title: Root Certificate Authority Used Private Key "4"
date: 2026-10-21 00:00:00
draft: true
---

On October 17, 2026, a security researcher who goes only as "Wayne" emailed
teams from Google, Microsoft, Apple, Mozilla, and eMudhra that he had
discovered 8 private encryption keys from the aforementioned company eMudhra.

These were important keys because eMudhra is a TLS certificate authority
(CA); this means that any mainstream browser that allows you to access the
modern web was trusting these keys to verify the identify of web servers you
were connecting to.


## Notes

### What Happened?

The intermediate CA eMudhra had 8 private keys compromised, reported by a
researcher on October 17, 2026. 6 are TLS certificats, the other 2 are for
Windows binary codesigning.

### Timeline

All times in UTC:

- Apr 2025: eMudhra generates and publishes 8 keys
- Oct 17 2026 18:05[^2]: Wayne discloses to eMudhra, Chrome, Apple, Microsoft, Mozilla
that the keys are compromised
- Oct 17 2026 21:28: "eMudhra acknowledged issue, said there's been no issuance beyond OCSP for G3B, but 'EM DV TLS CA - G3C' was live, disabled now"
- Oct 17 2026 22:59: Mozilla "distrusts" the certs in a [private bug](https://bugzilla.mozilla.org/show_bug.cgi?id=2083382)
- Oct 18 2026 09:38: eMudhra revokes the 8 certificates

### Why?

They did not randomly generate the private keys, but picked very small numbers.

[^1]: https://emudhra.we-have-a-problem.com/
[^2]: https://bugzilla.mozilla.org/show_bug.cgi?id=208344a
[^3]: https://bug2083449.bmoattachments.org/attachment.cgi?id=9664786
[^4]: https://www.ptinews.com/story/business/vulnerable-keys-were-created-but-never-put-to-commercial-use-investigation-on-emudhra-co-founder/4187569
