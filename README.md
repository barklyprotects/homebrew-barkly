Barkly Homebrew
===============

Requirements
------------
This tap assumes you've already setup homebrew on your mac.  In general, this
should be with strap however it should work without strap.

Installation
------------
This is a [tap](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md). Simply tap it.

``` bash
brew tap barklyprotects/barkly
brew update
```

To learn more about how this works and how to maintain, check out brew [docs.](https://github.com/Homebrew/brew/blob/master/docs/How-to-Create-and-Maintain-a-Tap.md)

Usage
-----
``` bash
# To ensure you have updates:
brew update
# To run barkly config:
brew barkly
```


This tap adds the `brew barkly` function. This simply runs a [shell script](https://github.com/barklyprotects/homebrew-barkly/blob/master/cmd/brew-barkly).

This script currently does the following:
- Sets up ~/cylent && ~/barkly.
- Sets up a [projects file](#projects-file) in the above directory.
- Reads projects in project file, executing for each:
  - brew install of [Brewfile](#brewfile)
  - Clone & pull of repos in [repo file](#repo-file)
  - Execution of setup.sh

#### Projects file
A project file is maintained on a Barkly user's computer in `~/barkly/projects`.
If none exists, we create one with `base` in it.

These projects correspond to the projects directory in this project.
These projects are setup as [described below.](#homebrew-barkly-projects)
In the future this can be expanded to many projects.

## Homebrew Barkly Projects
Projects are created and configured in this repo.  Each project gets it's own folder under `projects/`

A project consists of:
- [Brewfile](#brewfile)
- [Repo file](#repo-file)
- `Setup.sh` file that's executable and sets up any additional dependencies.

#### Repo file
A repo file lists github repos that we'd like to clone with a given project.

Repo files are setup as such:
```
# <repo name> <pull?>
api-keys pull
angalia-api
```

In the above example, api-keys will always be pulled when homebrew Barkly runs.
Angalia-api will not pull after it's initial clone.

#### Brewfile
A brew file lets you setup brew and cask forumla.  It also allows you to install Mac App store apps.
```
tap 'caskroom/cask'

cask 'google-chrome'
brew 'mysql', restart_service: true, conflicts_with: ['homebrew/versions/mysql56']
cask 'firefox', args: { appdir: '~/my-apps/Applications' }
mas '1Password', id: 443987910
```

A detailed explanation of Brew file can be found [here](https://github.com/Homebrew/homebrew-bundle/blob/master/Readme.md).

## Development
Since homebrew barkly just executes bash scripts, it's easy to run locally:
```
cmd/brew-barkly
```

Once changes are pushed to github master, users simply need to run `brew update`.

Long term we should attempt to move any functions to the lib directory to prevent repeating code.
