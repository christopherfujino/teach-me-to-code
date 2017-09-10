---
title: 'Git, Dotfiles, and the Dream of a Truly Cross-Platform Work Environment'
tags: 'Linux, OS X, git, sysadmin'
date: 2016-06-28 17:24:21
layout: post
---


So last October I started using Git to track my [dotfiles and config files](https://github.com/christopherfujino/dotfiles). Although it makes sense to use version control in case you make a change that breaks your system, to me the biggest appeal of doing this was so that I could easily synchronize all my config files between devices. My [first commit](https://github.com/christopherfujino/dotfiles/commit/041b0d1d845e640d3534f5ebbe73da3315a646f9) included config files for npm and vim, and now it's grown to include bash, window managers, and terminal emulators.

## The Problem

At first I wasn't sure how to track the files. Looking around on Github, a lot of coders, including the eminent [tpope](https://github.com/tpope/tpope), seemed to just `git init` their home directory, and then `git add` each file they wanted to track. This seemed a messy solution, however, and also would not translate well to my different systems (both different software setups and of course different operating systems).

## An Elegant Solution for a More Civilized Age

The solution I came up with was to store all the config files which I wanted to track in a separate directory (I chose `~/git/dotfiles`) tracked by git. I then symlinked from each tracked file to the location on my system the file was supposed to be (e.g. `$ ln -s ~/git/dotfiles/.vimrc ~/.vimrc`). This allowed me to `git clone` the repo safely onto any system, and then choose which individual files I wanted to utilize on that system.

The fact that this solution was cross-platform (I currently use it on my Arch Linux laptop, my OS X desktop, and a headless linux server on the cloud) was very exciting to me. It was a big motivation for me to build up my .vimrc, knowing I could use that setup on any of my systems, including servers I SSH into. I also recently switched to using [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) as my Linux terminal emulator of choice. I would call it the terminal emulator equivalent of Vim: lightweight, seemingly minimal at first, but incredibly customizable (and to topic at hand, all through a single text config file). I need to explore setting it up on OS X, but if I did I could have a consistent terminal experience across all my Unix-like devices. Which would be amazing.

## A Text-Based Operating System?

The more I switch to using text-based (cross-platform) terminal apps, using config files which I sync on Github, the more I am approaching a text-based, platform independent operating system. Especially for coding, my main tools at the moment are tmux, Neovim/Vim, Git, npm. The only GUI tool is Chrome/Chromium. I can see a future where OS X or Linux are just trivial background platforms. I can see the IT world moving in this direction anyway with projects like [Docker](http://docker.com) and [CoreOS](https://coreos.com/).

## Teach Me To Code

The next thing I'd like to learn to level up my dotfiles would be to create a node.js text-based script to automate the symlinking of scripts to new systems. I recently discovered the [GNU Stow](http://savannah.gnu.org/projects/stow) project, which already solves this problem, but I've been meaning to learn how to create node.js terminal apps. Another would be to add in platform-specific (i.e. OS X or Linux) settings to certain config files. In particular it would be great if I could use the same bash config files on both platforms. Please let me know if you have any feedback, ideas, or suggestions for me!
