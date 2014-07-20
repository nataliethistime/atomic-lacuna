Goals
=====

There are several ideas behind this project, a lot of them are aimed at improving
the quality of the code so that improvements can be made to important issues such
as performance or usability.

####Implemented
- Use JSHint to check the code for errors and report on possible bugs because
  of various pitfalls in the JavaScript language design.
- Use Browserify to make this code usable in the web browser, so that we're only
  maintaining one code base.

####Working On
- Use the Handlebars template engine to use HTML templates instead of manually
  messing with HTML inside the code. The reasons for this should be obvious.
- More jQuery and Underscore, less YUI. The version of YUI that this project uses
  has been depreciated since 2011. It's now 2014. Rely on YUI as little as possible
  when writing or improving code. Extra notes about this:
    - Don't use the YAHOO.lacuna global for the code.
    - There is nearly always a jQuery/Underscore/jQuery plugin which is more concise
      than the raw DOM manipulation that goes on right now.

####Later
- Because this project is NodeJs based, it's the easiest thing in the world to
  break code out into new modules.
- General cleaning of messy code.

Other possible improvements that could be done later on:
- Fix all the weird method names that aren't camelCased. This is really annoying
  and generally confusing for people new to the code. This could probably be fixed
  earlier rather than later, but because I'm the only person developing this project
  and it doesn't bother me *as much*, it's being delayed.
- Properly document each of the core library methods so that they make more sense.
