---
title: The Certificate Authority Who Used the Key "4"
date: 2026-10-22 00:00:00
draft: true
---

On October 17, 2026, 8 private keys from Certificate Authority eMudhra were
compromised, leading (within the next few days) to the company revoking them
and browsers from Apple, Google, and Microsoft to removing them from their
lists of trusted certificates.

So what do all these words mean and how does it impact ordinary computer
users? Let's break it down...

## How Does This Affect Me?

The worst case scenario from this incident would be that malicious hackers set
up a fake web service impersonating one that you trust. Let's say you want to
initiate a wire transfer from your bank to dealership to purchase a
car. However, when you log on to what you think is your bank's website, it's
actually a scam company's front. It looks like your bank's website; however,
when you put in your banking details, they save it, pretend your wire transfer
went through, and instead wire money into their own account.

Could this happen to you today? It depends on if your browser and/or operating
system has been updated recently enough to have stopped trusting the
compromised certificates.

## What Should I Do?

You should:

1. Update both the operating system and browser of every device you use to
access the internet.
2. On each of these devices, go to the website [https://emudhra.we-have-a-problem.com](https://emudhra.we-have-a-problem.com/#check),
which has a browser test table under the heading "Does your client still trust
the compromised intermediates?" Ensure that the result for each row says "Did
not connect".
3. If any of the rows fail the test, it means that your browser is trusting
these compromised keys, and attackers could fool you on them. You should
**not** use this device for accessing the web until it gets updated and passes
all the tests. If it never passes the tests, stop using the device; it is
**not** secure.

## So What Exactly Are Certificates?

To describe what happened, it is important to establish a little context
around how trust on the internet is intended to work.

What happens when I type "www.my-bank.com" into my browser[^5]? This type of
URL is actually an abbreviation, so the browser will fill in the protocol at
the beginning and navigate to "https://www.my-bank.com". The world wide web
supports two protocols for serving web pages: "http" and "https". The latter
is the "secure" version. Today, most browsers will show scary warnings if you
are using the older "http" protocol.

So how does the "https" protocol make me more secure? It has two different
features to make your connection more secure:

1. It allows the server of the website (e.g. My Bank's server) to prove to you
and your browser they are really the owner of the "www.my-bank.com" domain
name.
1. It encrypts or encodes all the messages that go back and forth between your
browser and the server so that any hackers listening to the connection (say in
a coffee shop, snooping in on your wifi connection) cannot actually see the
data that is being sent in either direction.

It is the first of these features that is relevant to the current incident.

So how can one computer prove to another that it is who it says it is?
The answer is by using a trusted third party. With digital identities, we call
this third party a **Certificate Authority**[^6]. First, the entity who wants to
prove their identity online must prove their identity
to the certificate authority. Then the certificate authority issues a
**certificate** to the entity that "proves" the entity is who it says it is.

For our banking example, "My Bank" will prove to the certificate authority
that it owns and operates "https://www.my-bank.com". When you and your browser
navigate to that URL:

1. The browser requests the certificate from the server.
2. The server provides the certificate that it received from the certificate
authority.
3. Once the it receives the certificate, the client verifies the URL on it,
the expiration date, and the digital signature on it from
the certificate authority.
4. If the browser does not recognize the certificate authority or the
certificate has expired, then the connection fails and the user will be
presented with an error message that it couldn't verify the identity of the
server.
5. If the client *does* recognize the certificate authority, it will check
that signature on the certificate actually came from that authority,
and not some malicious hacker who forged their own certificate.

But how do you *sign* a digital document? And how can someone verify who
signed it?

Digital signatures use a system where entities who want to sign documents
(in our example, a certificate authority) generates two keys:

1. A public key. This is published so that anyone who wants to verify this
entity's signatures can find it. The public key can only **read** signed
documents, it cannot write them.
2. A private key. This is secret, and only accessible to the entity who will
be signing documents, because it can **write** or **sign** documents. The
security of this protocol relies on the private key being a secret.

So a certificate is generated by the certificate authority taking a document
that says:

1. "My Bank" is operating the URL "https://www.my-bank.com"
1. When the certificate will expire
1. Its own identity as the certificate authority who is issuing the certificate

It then signs it with their private key. When the client is verifying this
certificate it looks up the identity of the certificate authority from its list
of authorities it already trusts. Assuming that the certificate authority
*does* appear in their list of trusted authorities, it will then have a copy
of its public key which it uses to verify the signature on the certificate. If
it verifies that the certificate matches the public key it has, it assumes the
server is who it says it is and it loads your banking site, and you are able
to make your wire transfer.

## What Did eMudhra Do?

The company at the center of our current incident, eMudhra, is one of these
certificate authorities that all the major browsers trust. They claim to have
issued over 60 million certificates over the years[^8]. On April 2025 eMudhra
published 24 public keys[^10] to be used by clients to verify the certificates they
would later be signing. On October 17, 2026 a security researcher who goes
only by "Wayne" discovers[^2] that he can **guess** the private keys to 8 of
these public keys. He privately notifies Apple, Google, Mozilla, Microsoft, and
eMudhra of his findings, proving his discovery by signing a message[^11] with the
private keys he discovered.

How did Wayne guess the private keys? A traditional password
system can be broken with enough time by guessing and trying every possible
password. This strategy is called **brute force**[^12]. Similarly, you can
brute force a private key if you have the public key by guessing every
possible private key, signing a document with it, and seeing if it can be
verified with the real public key.

The reason most people don't do this is because private keys are very large
numbers, so it would take a *very long* time to guess the key. The private
keys eMudhra generated were 384 bits which can represent whole numbers up to
3 with 115 zeroes. Using the best modern strategies for guessing private keys,
the average number of guesses would be approximately 3 with 57 zeroes[^13]. To
put this number in context, the approximate number of atoms in the universe is
1 with 50 zeroes[^17], about 10 million times smaller than the average number
of guesses it would take to guess this private key. If you could generate and
test a private key in 1 millisecond (significantly faster than I can on my
desktop), it would take 7 with 36 zeroes times the estimated age of the
universe to find the correct private key matching a given public key[^18].

But Wayne tried to guess these keys anyway, and succeeded because one of them
was the number 4, another the number 56[^14]. This is equivalent to if you
chose the password "a" for your email account. A program that was brute force
guessing passwords would likely guess it very early. We are fortunate that
Wayne is a benevolent researcher and informed the correct parties of his
discovery who were able to quickly respond and do what they can to distrust
the weak keys. We have no way of knowing if any malicious hackers made this
discovery before Wayne and used it to forge certificates and impersonate
legitimate websites. But we can know that many malicious hackers *will* try to
do so now, trying to catch browsers and operating systems that have not been
updated to know not to trust certificates signed with these keys.

To put it plainly, this was a big mistake. This wasn't eMudhra getting
unlucky, they did not follow proper key generation procedures. My guess is
that these were test keys that were generated while they were figuring out how
to use the key generation tools that were accidentally used in production.

## How Did eMudhra Respond?

Given how bad a mistake this was for eMudhra and how big the fallout could
potentially be, how did the company respond?

First, within 4 hours of being contacted by Wayne, they acknowledged that the
report was correct[^15] and by the next day had revoked the 8
certificates.[^16]

Next, their co-founder Kaushik Srinivasan told The Press Trust of India,
"There's no impact to subscribers because we have done all the actions. We are
also working with our customers to notify them that there is no impact because
no certificates were issued."[^4]

This is a misleading statement because, even if (as he claims) eMudhra never
used these bad keys to sign any certificates, all this means is that none of
their clients need to generate new certificates. If their customers also
happen to use the web, they *will* in fact be impacted by this incident,
because the entire trust system of the web has been affected. Even if eMudhra
never signed any certificates with these bad keys, they cannot prove that no
malicious parties ever forged eMudhra certificates.

Finally, on October 22, eMudhra put out a press release announcing "that its
Board has decided to voluntarily withdraw from the global SSL/TLS certificate
business."[^9]

This, at least, is a happy ending to this sad tale.

## What Have We Learned?

What went well was:

1. Wayne is primary hero. He bothered to spend his own time checking the
security of (presumably) random, year old certificate keys, and then promptly
reported his discovery to the right parties.
1. The right parties responded quickly, doing what they could to revoke the bad keys and communicating with each other.
1. eMudhra announced they are withdrawing from the certificate business.[^9]

What went badly was:

1. Obviously the generation and publishing of these keys was a critical mistake that should have never happened.
1. eMudhra's cofounder put out a damage control statement, suggesting that no
one was affected by the incident.[^4]

What was lucky was:

1. Wayne happened to test these bad keys.

In this incident, a certificate authority I'd never heard of had 8 weak keys
that they reportedly never used, and yet their existence and the fact that the
major browsers and operating systems trusted them has troubling implications
both deep and wide.

A system is only as secure as the weakest link in its chain. The digital
certificate and digital signature systems described in this article are
*pretty good*. Where they usually fail--as in this incident--is with human
error.

It is my hope that understanding how these systems work--and thus how they
might fail--demystifies them and better prepares us for when they inevitably
will fail again.



<!--
teams from Google, Microsoft, Apple, Mozilla, and eMudhra that he had
discovered 8 private encryption keys from the aforementioned company eMudhra.

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

- Apr 2025[^10]: eMudhra generates and publishes 8 keys
- Oct 17 2026 18:05[^2]: Wayne discloses to eMudhra, Chrome, Apple, Microsoft, Mozilla
that the keys are compromised
- Oct 17 2026 21:28: "eMudhra acknowledged issue, said there's been no issuance beyond OCSP for G3B, but 'EM DV TLS CA - G3C' was live, disabled now"
- Oct 17 2026 22:59: Mozilla "distrusts" the certs in a [private bug](https://bugzilla.mozilla.org/show_bug.cgi?id=2083382)
- Oct 18 2026 09:38: eMudhra revokes the 8 certificates

### Why?

They did not randomly generate the private keys, but picked very small numbers.

-->


[^5]: For the purposes of this article, references to a "browser" will refer
to one of the big 4: Apple's Safari, Google's Chrome, Microsoft's Edge, or
Mozilla's Firefox. There are many other browsers, and most of them behave the
same way. Some obscure ones may behave differently.
[^6]: https://en.wikipedia.org/wiki/Certificate_authority.
[^8]: "The CA of concern in this case is called eMudhra, which boasts of having issued over 60 million digital certificates to help usher in a world of digital trust," https://www.theregister.com/security/2026/10/20/indian-certification-authority-emudhras-private-keys-compromised-one-of-them-was-the-number-4/5304312
[^10]: https://bugzilla.mozilla.org/show_bug.cgi?id=2083449#c5
[^11]: The message he signed was "We have a problem here - Wayne", https://bugzilla.mozilla.org/attachment.cgi?id=9664066
[^12]: https://en.wikipedia.org/wiki/Brute-force_attack
[^13]: Assuming a key size of 2^384 and
[Pollard's rho algorithm](https://en.wikipedia.org/wiki/Pollard%27s_rho_algorithm#Complexity),
the maximum of guesses would be approximately 2^192. On average, a brute force
attack would succeed after guessing half of these, which is 2^192 / 2 which is approximately 3.1385508676933404e+57.
[^14]: https://scotthelme.co.uk/eight-bits-of-trust-emudhras-ca-keys-cracked-in-milliseconds/
[^15]: https://bugzilla.mozilla.org/show_bug.cgi?id=2083449#c2
[^16]: https://bugzilla.mozilla.org/show_bug.cgi?id=2083449#c1
[^4]: https://www.ptinews.com/story/business/vulnerable-keys-were-created-but-never-put-to-commercial-use-investigation-on-emudhra-co-founder/4187569
[^9]: https://emudhra.com/en/press-release/emudhra-to-exit-global-ssl-tls-certificate-business
[^17]: https://sciencenotes.org/how-many-atoms-are-in-the-world/
[^18]: At 1 millisecond per key, it would take 9.9e+46 years to test 3.1e+57
keys. If the age of the universe is 13.8 billion years (https://www.aanda.org/articles/aa/full_html/2020/09/aa33910-18/aa33910-18.html), it would take 7.2e+36
times the age of the universe to test 3.1e+57 keys. And this is only the
average number of attempts to find the private key, it could take as much as
twice that long.
