Javascript rules
================

These directories define a set of rules for using Please with a
Webpack-based Javascript build, using Yarn for dependencies.
The plan is to build a bundled version of Webpack which is then
used to build other things; bundling it is a little awkward but
helps us maintain build correctness & performance.

TODOS:
 - Incrementality, i.e. having some output for js_library rules
 - Implement a persistent worker
 - Does the yarn_bundle rule really gain us anything?
 - Tests
 - Coverage

Hacky bits:
 - Currently we have to patch webpack and loader-runner because of
   https://github.com/webpack/webpack/issues/1434. If Webpack
   allowed us to pass loader objects (ala Babel presets) that would
   allow us to get rid of the uglier patch and all the hacking with
   require_dynamic etc.
 - Quite a bit of thrashing about is done to avoid some require
   statements for Node things that we won't end up using. It's probably
   possible to do something more cleanly there.
 - We don't support anything like Node's peerDependencies, so we rather
   arbitrarily chop up cycles in yarn_deps.py.
