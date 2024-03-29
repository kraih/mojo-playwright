# Playwright and Mojolicious [![](https://github.com/kraih/mojo-playwright/workflows/linux/badge.svg)](https://github.com/kraih/mojo-playwright/actions)

  This is a companion repo to my blog post
  [Playwright and Mojolicious](https://dev.to/kraih/playwright-and-mojolicious-21hn). Here you can find a few examples
  for how to use [Playwright](https://playwright.dev) to test the sample [Mojolicious](https://mojolicious.org)
  WebSocket application `chat.pl`. Tests are written in a mix of Perl and JavaScript. Thanks to
  [Node Tap](https://node-tap.org) you can run them all with `prove` at the same time. Even in parallel with `-j 3`!

## How to run?

    $ npm i
    ...
    $ cpanm -n --installdeps .
    ...
    $ prove t/*.t t/*/t.js
    t/just_js.t.js ..... ok   
    t/just_perl.t ...... ok   
    t/wrapper_js.t.js .. ok   
    All tests successful.
    Files=3, Tests=12,  4 wallclock secs ( 0.02 usr  0.01 sys +  2.23 cusr  0.60 csys =  2.86 CPU)
    Result: PASS
