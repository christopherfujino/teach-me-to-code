---
title: 'Hello, World!'
date: 2016-06-15 16:11:47
tags: javascript, node.js, markdown, hexo
---

Most programming blogs feature posts from veteran programmers teaching others new concepts and techniques. However, I am a beginning programmer and I plan to blog about the things I'm learning and the difficulties I'm having. Hopefully I can help other beginning programmers, but more importantly I hope people will get involved and teach me to code!

## Why I Chose To Use Hexo

Over the years, I've experimented with many different ways to manage a blog. My very first website, handcoded in HTML in the late '90s had a "news" section which was basically a primitive blog. After a lot of dabbling, I decided to use the [Hexo](http://hexo.io) static website framework to manage this blog. The primary factors in my decision to use Hexo were:

### It uses markdown.

This could be a whole other future post about why rich-text and [WYSIWYG](https://en.wikipedia.org/wiki/WYSIWYG) editors are evil. Ever since I discovered the [Ghost](https://github.com/TryGhost/Ghost) CMS, I've been excited about blogging in [markdown](http://daringfireball.net/projects/markdown/syntax#philosophy). I do almost all of my writing in markdown anyway, so I wanted a system that uses it. With Hexo, blog posts are essentially markdown notes with frontmatter.

### It generates static websites.

This means it can be managed locally offline and then published to a remote server using Git. Using tools that are available offline is important to me, as there are still many situations where I might want to work without internet access.

Another advantage of generating static pages is that the site can be hosted for free on [GitHub Pages](https://pages.github.com). This means I don't have a manage a server and I can focus instead on what's most important, *the content*.

### It's open-source and only depends on Node.js & Git.

In order to use Jekyll, I had to install and configure Ruby, which isn't a part of normal workflow. The only dependencies Hexo requires are Node.js & Git (I'm actually using a lot of other open-source projects for this blog, but they're all managed with npm). I already use Node.js, so getting Hexo up & running was as simple as executing:

```bash
$ npm install -g hexo-cli
$ hexo init project-name
$ cd project-name
$ npm install
$ hexo serve
```

On a more philosophical note, as much as possible I try to use open-source software, and since I am currently focusing on JavaScript, I really wanted to use a tool that was written in JavaScript so that I could understand how it works and possibly even extend it down the line.

### Teach Me To Code

What do you think about my criteria? Is there a better choice I could have made? And any other questions or comments, hit me up on social media.
