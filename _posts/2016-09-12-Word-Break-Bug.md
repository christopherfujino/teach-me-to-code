---
title: A CSS Word-break Bug
tags: 'CSS, bug'
date: 2016-09-12 16:05:11
layout: post
---

So on [my last post](https://teach-me-to-code.github.io/2016/07/21/Teaching-C-To-A-JS-Developer/), I encountered a strange bug on Chrome (but not on Firefox) where some of my text was breaking mid-word, without so much as a hyphen inserted. Here's a screenshot:

I'm using [the Hexo framework](https://hexo.io) for my blog, along with a theme from github called [Apollo](https://github.com/pinggod/hexo-theme-apollo), so I started reading through the SASS files, but couldn't isolate what exactly was causing this strange bug I'd never encountered before.

Several online searches, however, lead me to the `word-break` css property. [According to MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/word-break), "the **word-break** CSS property is used to specify whether to break lines within words." Sure enough, searching the SASS files for the Apollo theme, I found:

```css
a {
  color: #42b983;

  word-break: break-all;
}
```

MDN says that `break-all` specifies that "word breaks may be inserted between any character for non-CJK (Chinese/Japanese/Korean) text." Sure enough, I realized the strange line breaks only occur during long anchor text. I'm guessing this was specified to break up long URLs, however since I use descriptive text as my anchor text, I commented out this attribute and my text rendered as expected.
