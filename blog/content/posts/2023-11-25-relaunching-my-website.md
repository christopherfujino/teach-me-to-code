---
title: Relaunching my Website
date: 2023-11-25 18:47:00
draft: true
tags:
  - go
  - hexo
  - hugo
  - jekyll
  - node.js
  - JavaScript
  - ruby
---

Since my [last post]({{< relref "/posts/2016-10-13-sfjs.md" >}}) over 7 years
ago(!), I have always had it in the back of my mind that I would like to get
back to blogging. In that time, coding went from a hobby I was interested in
growing in to my full-time profession (see my
[résumé]({{< relref "/resume.md" >}}) for more details on what I've been up
to).

## Refreshing the Tech Stack

My [first post]({{< relref "/posts/2016-06-15-hello-world" >}}) was primarily
about the criteria I used to select a static site generator:
[hexo](https://hexo.io). I think this was short-lived however, and can
remember porting this site to Jekyll and Hugo over the years. As the last of
these ports were to Hugo, I decided to stick with that for now and focus on
putting some polish on it.

## Aesthetics

Previously, the presentation was incredibly minimal, with just a link in the
`<head>` tag to the default bootstrap style sheet. However, I decided to go
even more minimal, and hand-write my own [stylesheet](https://github.com/christopherfujino/teach-me-to-code/blob/e17ccd07afa0c0edeb80d4b32fc7454155a42c97/blog/static/global.css).


## Setting up Continuous Deployment

The idea for creating a blog began when I heard about GitHub Pages.

Although I vaguely remember doing so, apparently at one point I set up a CI
workflow for building this site with [netlify](https://www.netlify.com).
