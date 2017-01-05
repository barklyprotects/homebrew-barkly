Barkly Homebrew
===============
This is an alternative to Boxen since it is now [deprecated.](https://github.com/boxen/boxen/issues/197)

Read more about Strap and Homebrew-barkly as a [Boxen replacement.](https://github.com/barklyprotects/homebrew-barkly/blob/master/docs/replacing_boxen.md)

Requirements
------------
This tap assumes you've already setup homebrew on your mac.  In general, this
should be with [strap](https://github.com/barklyprotects/strap) however it should work without strap.

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

There is also `brew barkly create ...` described [here](#create), but you should come back to that later.

This script currently does the following:
- Sets up ~/cylent && ~/barkly.
- Sets up a [projects file](#projects-file) in the above directory.
- Reads projects in project file, executing for each:
  - brew install of [Brewfile](#brewfile)
  - Clone & pull of repos in [repo file](#repo-file)
  - Execution of setup.sh
  - Starts apps listed in [startapps file](startapps-file)
- Reads users config from users directory, exactly as we do for projects.

#### Projects file
A project file is maintained on a Barkly user's computer in `~/barkly/projects`.
If none exists, we create one with `base` in it. For details on base, view it's [Readme.](projects/base/README.md)
Put a project on each line:
```
base
ops
saas
```

These projects correspond to the [projects directory](https://github.com/barklyprotects/homebrew-barkly/tree/master/projects) in this repo.
These projects are setup as [described below.](#homebrew-barkly-projects-and-users)
In the future this can be expanded to many projects.

## Homebrew Barkly Projects and Users
Projects and users are created, configured and checked in to this repo.  Each project/user gets it's own folder under `projects/` / `users/`

They consists of:
- [Brewfile](#brewfile)
- [Repo file](#repo-file)
- `Setup.sh` file that's executable and sets up any additional dependencies.
- files/ – directory of other files sourced or used by setup.sh

[What belongs in projects vs user files?](docs/projects_vs_users.md)

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

#### Startapps file
Much like the above Repo file, Startapps starts apps at `brew barkly` runtime.  
Most mac apps that should run at startup or in the background prefer to manage this themselves,
so for now we will auto start apps the user wishes to ensure are running.  

Maybe you want to make sure Docker is already running, simply add a line to your startapps file like:
```
Docker.app
```

We will find any app that exists in /Applications natively. You should be able to also provide a full path if you'd like.

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
When making any changes to homebrew-barkly, you must test using the below commands
rather than `brew barkly` since this points directly to the git repo version of this tap.

Since homebrew barkly just executes bash scripts, it's easy to run locally:
```
cmd/brew-barkly
```

Once changes are pushed to github master, users simply need to run `brew update && brew barkly`.

#### Create
To automatically create a User or Project, you can run something like:
```
brew barkly create user mikesplain
brew barkly create project foo
```
Note, if bootstrapping without a user already created, we will create one for you!

Long term we should attempt to move any functions to the lib directory to prevent repeating code.
