#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh


cat << 'EOF' > "$HOME/.env/splain.sh"
alias git-saas='~/cylent/dev-tools/master-push/git-all.sh ~/cylent/dev-tools/master-push/saasRepos.txt $@'
EOF
