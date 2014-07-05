atomic-lacuna
=============

The Lacuna Expanse Web Client inside an atom-shell. All the documentation for
this is viewable on the [documentation index page](https://github.com/Vasari/atomic-lacuna/blob/master/docs/index.md).
If you have any questions or suggestions, please yell at me via the Github Issue tracker.
I'd love to hear from you. :blush:

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
web client) to run in a desktop window and have access to the file system view
NodeJs. This allowed me to streamline the loading of all the JavaScript and assets.
I don't have any performance tests, but the client *seems* faster in the desktop
mode than in the web browser. If any of that doesn't convince you, just look at it.
No silly web browser rubbish in the way! Tadaaa! :dizzy:

![Atomic Lacuna in action!](https://raw.githubusercontent.com/Vasari/atomic-lacuna/master/docs/Screenshot.png)

Badges! :beginner:
=======

| Name         | Status    |
| :----------: | :-------: |
| Code Climate | [![Code Climate](https://codeclimate.com/github/Vasari/atomic-lacuna.png)](https://codeclimate.com/github/Vasari/atomic-lacuna) |
| Travis CI    | [![Build Status](https://travis-ci.org/Vasari/atomic-lacuna.svg?branch=master)](https://travis-ci.org/Vasari/atomic-lacuna)     |

Made with :heart: by Nathan McCallum and contributers under the MIT license! :panda_face:
