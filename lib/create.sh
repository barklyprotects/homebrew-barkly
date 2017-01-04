#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$THISDIR/init.sh"

if [ $# -eq 0 ]; then
  abort "This script should only be run from the 'brew barkly create' command line!"
fi

if ! [ -d "$BARKLYDIR" ] || ! [ -d "$BARKLYDIR/homebrew-barkly" ]; then
  abort "This script should only be run after this machine is strapped and 'brew barkly' is run."
fi

ACTION=$1
NAME=$2
USER_GITHUB=$(git config --global github.user)

ACTIONDIR="$1s"
FULLPATH="$BARKLYDIR/homebrew-barkly/$ACTIONDIR/$NAME"

logn "Setting up $ACTION for $NAME:"

mkdir -p "$FULLPATH" 2> /dev/null
mkdir -p "$FULLPATH/files" 2> /dev/null
logk

logn "Creating Brewfile for $NAME:"
cat << EOF > $FULLPATH/Brewfile
# Sample Brewfile data
# cask_args appdir: '/Applications'
# tap 'caskroom/cask'
# tap 'telemachus/brew', 'https://telemachus@bitbucket.org/telemachus/brew.git'
# brew 'imagemagick'
# brew 'mysql', restart_service: true, conflicts_with: ['homebrew/versions/mysql56']
# brew 'emacs', args: ['with-cocoa', 'with-gnutls']
# cask 'google-chrome'
# cask 'java' unless system '/usr/libexec/java_home --failfast'
# cask 'firefox', args: { appdir: '~/my-apps/Applications' }
# mas '1Password', id: 443987910
EOF
logk

logn "Creating repos file for $NAME:"
cat << 'EOF' > $FULLPATH/repos
# List of repos to setup.
# Format:
# <github repo name> <pull on each `brew barkly`?>
# angalia-api pull
# angalia-test
EOF
logk

logn "Creating setup file for $NAME:"
cat << 'EOF' > $FULLPATH/setup.sh
#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh
EOF
logk

logn "Setting permissions on setup file:"
chmod +x $FULLPATH/setup.sh
logk
