Strap and Homebrew-barkly as a Boxen replacement.
=================================================
Boxen is now deprecated. Read [this issue](https://github.com/boxen/boxen/issues/197) for the reason github deprecated it.

Goals for Strap and Homebrew-barkly
-----------------------------------
- Simplify configuration
- Separate user config into dotfiles and project configuration into this repo.
- Use CI/CD to ensure strap constantly works.

Basics
-------
A user wants to setup a machine with strap.  You'll likely want to [remove boxen](https://github.com/barklyprotects/our-boxen/blob/master/script/nuke) if it's installed.

Strap generates a custom shell script for each user after authenticating against github.  Read more about our strap server [here](https://github.com/barklyprotects/strap).  Our strap app currently runs in Heroku but would eventually migrate to our AWS servers.  You can access it here: https://barkly-strap.herokuapp.com/

At the end of setup, strap with use this custom [tap](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md) and run `brew barkly` to setup barkly configs.  You can find what that does [here](https://github.com/barklyprotects/homebrew-barkly/blob/master/cmd/brew-barkly).
