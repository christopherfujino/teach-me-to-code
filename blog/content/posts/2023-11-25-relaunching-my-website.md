---
title: Relaunching my Website
date: 2023-12-29 00:09:00
tags:
  - go
  - hexo
  - hugo
  - jekyll
  - node.js
  - JavaScript
  - ruby
---

So, I have been a bad blogger.

It has been over 7 years since my
[last post]({{< relref "/posts/2016-10-13-sfjs.md" >}}). At that time, coding
was a hobby I was interested in growing into my full-time profession. I used
my blog as a journal of what I learned. I called it *Teach Me to Code* because
I saw it as a journal of a learner and I imagined more experienced coders
might interact and offer me insights. It seemed arbitrary to me that bloggers
needed to take the posture of an expert sharing their wisdom with the world.
And even if I agreed with that presupposition, I did not have any wisdom to
share.

Since then, I moved to the San Francisco Bay Area and coding went from being
a hobby to my career (see my [résumé]({{< relref "/resume.md" >}}) for more
details on what I've been up to). It's always been in the back of my mind that
I would like to start blogging again. As often happens to me, however, when I
intend to work on a side project (which in this case would be re-launching my
blog), I start working on the project but I end up getting lost down the rabbit
hole of tooling and frameworks available to build the project with. This
usually ends up with me building my own framework--fortunately this story has
a happier ending.


## Static Site Generators

My initial idea for starting a blog began when I heard about GitHub Pages and
the concept of static site generators. If you're not familiar with static site
generators, let me explain it with a short timeline of blog architecture:

1. Early blogs were made up of hand-written HTML documents. Writing a new post
meant creating a new HTML document, linking to it from some index page, and
syncing both the new post and the updated index to your server, preferably via
ftp. This has the advantage of being incredibly simple and cheap to host (the
entire website is composed of static assets).
2. Needing to author posts as complete HTML documents was both cumbersome and
precluded non-programmers from blogging. Blog platforms were developed that
stored posts in a database and dynamically generated HTML documents from them
when users requested them. This made it easier to author content and publish
it, at the cost of greater demands on the server (both to maintain the
database and to dynamically generate the HTML content).

In summary, completely static websites were simple and cheap to host and
faster to serve while dynamic websites made authoring and publishing new
content easier.

Static site generators take a third approach: like dynamic websites, they
allow content to be authored in a more accessible format (usually markdown);
however, generating the HTML content is happened ahead of time by the author,
with a "build" step (conceptually this can be thought of as "compiling" the
website, where the inputs are configuration files, templates, assets, and the
markdown content files and the outputs are the static HTML, CSS, JavaScript,
and asset files), after which the generated HTML is published to the
server, as with static websites. This combines the ease of authoring content
with the speed of cost efficiency of static websites (GitHub Pages still
offers free static web hosting, and as of December 2023 is the way this
website is hosted).

So what is the catch? The downside of this approach is that there is added
complexity in terms of the tooling used to build the website. Throughout the
years, I've tried Jekyll (in Ruby), Hexo (in JavaScript, detailed in my [first
blog post]({{< relref "/posts/2016-06-15-hello-world" >}})), and Hugo (in Go).
Each of these had the usual problems and complexities associated with using
an application framework in the given ecosystem. Although it is true that
*writing content* is fairly straightforward with a static site generator,
initially bootstrapping and tweaking a Jekyll blog is roughly equivalent to
the amount of work it would take to bootstrap a Ruby on Rails application of
similar complexity. That is to say, a tedious task that could easily kill any
creativity from the author.

As I alluded to earlier, I have considered building my own static site
generator framework in alignment with my own philosophy of software
development. In a moment of clarity, however, I concluded that should I start
working on a static site generator framework, I will most likely never
actually end up building a website. Thus, when I picked up working on this
website again in November of 2023, I decided to just stick with the last
framework that I had set up, which was Hugo.

## Aesthetics

The easiest way to minimize the bootstrapping time with a static site
generator is to use a pre-made theme. While I have used themes before, I have
never been fully satisfied with them because:

1. I have never found a free theme that I felt fully matched my aesthetic; and
2. If I did find one, it would probably bother me that other blogs out there
are likely using the same theme.

I have never been a visual designer and when it comes to programming
front-end development is my biggest weakness. In my current job, I work on a
command line interface tool, which I believe plays to my strengths. And my
aesthetics. Other than a web browser, the rest of the tools that I use daily
are command line tools in my terminal. I've spent a considerable mount of time
styling my terminal environment to be aesthetically pleasing. Given that you
are reading my website now, I think you can see where this is going.

So I hand-wrote my own
[stylesheet]({{< param repo >}}/tree/{{< param gitMainBranch >}}/blog/assets/global.css)
to look as close as possible to my terminal environment, including the
[mononoki](https://github.com/madmalik/mononoki) font and the
base16 [eighties](https://github.com/chriskempson/base16-default-schemes/blob/master/eighties.yaml) colorscheme.
Although writing CSS rules is something I've happily been able to avoid for
the most part in my professional career, I found it to be much more satisfying
within such a strict set of constraints (e.g. only one font size allowed, all
spacing should be in multiples of that single font size, all colors used
should be within the finite set from the colorscheme). I think this aligns
overall with my philosophy of software development, that a strict set of
principled constraints makes writing code simpler, more logical, and safer.
Thus my predilection for statically-typed languages, strict linter rules, and
powerful compilers.

## Continuous Deployment

The simplest solution to manage deployment of a statically-generated website
to GitHub Pages would be to generate the static content locally on my
workstation, commit that to my git repository, and push the commit to the
GitHub repository that had GitHub Pages configured. From there, GitHub would
handle serving the content.

I decided against this because:

1. Committing both source inputs and generated outputs into a repository
wastes storage space in the repository.
1. Likewise, it can lead to surprising cases if I forget to generate the
outputs before committing where the inputs and outputs do not match at that
particular commit.
1. The exact contents of the generated outputs may be dependent on the exact
versions of the generator toolchain I had installed on that particular
computer.

I will likely expand on these ideas in a future post specifically on CI/CD.

For these reasons, I decided to only commit the source inputs to my
repository, and rely on a continuous deployment script to actually publish
the generated static output content. The workflow looks like:

1. Pull the latest version of the source repository from [{{< param repo >}}]({{< param repo >}})
1. Write the post, using Hugo's local development server to preview what it
will look like as the rendered HTML
1. When ready, commit the post and push it back up to [{{< param repo >}}]({{< param repo >}})
1. On pushes to the `{{< param gitMainBranch >}}` branch, a GitHub Action
workflow will trigger, which will then:
1. Pull the pinned Docker image `golang:1.21.4-bookworm`, which is the
official Go docker image, using Debian
1. Use GitHub's official `actions/checkout@4.1.1` to check out the source
repository
1. Build the Hugo framework from source, using a commit pinned as a git
submodule
1. Use newly built Hugo binary to build the website
1. Use the third party GitHub Action
[appleboy/gh-pages-action@v0.0.2](https://github.com/appleboy/gh-pages-action/releases/tag/v0.0.2)
to push the generated static outputs to a *second* GitHub
[repository](https://github.com/teach-me-to-code/teach-me-to-code.github.io),
which then has GitHub pages configured on it (which my domain name points to)

Is this more complicated than is necessary for a publishing a static website?
Probably. However, I was willing to go through the extra time to set up the
CI/CD infrastructure for the assurance that my website builds would be
completely reproducible. In addition, it was an excuse to familiarize myself
with GitHub Actions. More thoughts on this are likely to follow in their own
post, likely with a provocative title like *How I Would Publish a Malicious
GitHub Action*.

## Closing Thoughts

It's now clear to me that I procrastinated on working on my website because
I am a perfectionist with strong ideas about things *should* be and I am
easily discouraged when I fail to achieve this. The idea to fit the design
of the website within constraints of a terminal emulator was able to limit
the scope and also provide the inspiration needed to focus my attention
enough to get the website to a point where I was *reasonable satisfied*
(is a perfectionist ever happy?).

Although this blog post details the technical problems I struggled to
overcome as a perfectionist, I similarly struggled creatively to finish blog
posts. Time will tell if I can break through this barrier.
