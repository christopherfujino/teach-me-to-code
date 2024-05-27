---
title: The Problem with Dependencies
tags: ['open source']
date: 2024-05-27 13:22:00
layout: post
draft: true
---

Before I outline the concerns that I have with the reliance of modern software
development on third-party, usually open source dependencies, let me start
with benefits of dependencies that the rest of the post will take for granted:

1. Abstracts away from application developers implementation details of solved
problems, allowing them to focus on their business logic.
2. Outsources the ongoing maintenance of that dependency code to maintainers,
who presumably know what is best for the project.
3. Because dependencies are open-source, application developers have the
ability to audit this code security or correctness concerns, upstream bugs
or necessary features, or--as a last resort--to fork the project and take over
maintenance themselves.

I first learned how to program before I had access to the internet or knew
about open source, so I understand how life changing these benefits are. The
thought of building a web server from scratch in C is overwhelming. However,
I could reasonably scaffold a proof of concept Ruby on Rails API with a React
frontend, host it on a serverless function platform with a hosted database in
a weekend. Within a month or two I could probably build something that could
start processing enough payments from real customers to cover expenses and
make my business
[ramen profitable](https://paulgraham.com/ramenprofitable.html).

*Open source dependencies are a super power to builders.*

Software engineering encompasses more than just building things, however. The
problem with dependencies mostly involves the ongoing maintenance of a
software project: fixing bugs, adding new features, and updating dependencies
to get upstream fixes and features.

## The Law of Leaky Abstractions

## The Problem with Semantic Versioning
