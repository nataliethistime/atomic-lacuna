Atomic Lacuna
=============

 > The Lacuna Expanse Web Client inside an atom-shell. It's cleaner, sweeter, brighter
 > and includes a scripting console.

In terms of documentation, the isn't much, *yet*. But hey,
if you want the short and sweet of it, see the ROADMAP. Or for more detailed (read: technical)
documentation see the GOALS. Finally if you're a developer and want to help, CHANGES
and HACKING are the places to be.

If you have any questions or suggestions, please yell at me via the Github Issue tracker.
I'd love to hear from you. :blush:

[![Code Climate](https://codeclimate.com/github/1vasari/atomic-lacuna.png)](https://codeclimate.com/github/Vasari/atomic-lacuna)
[![Build Status](https://travis-ci.org/1vasari/atomic-lacuna.svg?branch=master)](https://travis-ci.org/Vasari/atomic-lacuna)
[![Dependency Status](https://david-dm.org/1vasari/atomic-lacuna.svg)](https://david-dm.org/1vasari/atomic-lacuna)
[![Dev Dependency Status](https://david-dm.org/1vasari/atomic-lacuna/dev-status.svg)](https://david-dm.org/1vasari/atomic-lacuna#info=devDependencies)

Why? :octocat:
====

I've been wanting to try and add cool new stuff to the Lacuna Web Client for
quite some time now, however, my plans have been foiled by the inability to load
more JavaScript into the page (Underscore or jQuery to name a few). This was
because the `index.html` couldn't be changed and I didn't want to be inserting
`<script>` elements onto the page at runtime ('cause that's ugly, man).

I came across [Atom](atom.io) some time ago, however I never really looked into it.
Recently I tried to build it on my system and I discovered that it ran on a 'shell'
that could be re-used in other projects.

To make a short story shorter, the `atom-shell` allows a web page (such as the
web client) to run in a desktop window and have access to the file system via
NodeJs. This allowed me to streamline the loading of all the JavaScript and assets.
Several users who have tested Atomic Lacuna have said that it feels faster than
the in-browser client. Here's a sneak peak of what it looks like. Tadaaa! :dizzy:

![Atomic Lacuna in action!](https://raw.githubusercontent.com/Vasari/atomic-lacuna/master/public/Screenshot.png)

License
=======

This project is made with love, under the MIT license, by [@1vasari](https://twitter.com/1vasari). :heart:
