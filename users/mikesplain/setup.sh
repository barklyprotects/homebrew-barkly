#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh


cat << 'EOF' > "$HOME/.env/splain.sh"
alias prod2='kubectl config use-context prod2.barkly.com'
alias dev1='kubectl config use-context dev1.barkly.com'
alias dev2='kubectl config use-context dev2.barkly.com'
alias dev3='kubectl config use-context dev3.barkly.com'
alias mgmt1='kubectl config use-context mgmt1.barkly.com'
alias researchkube1='kubectl config use-context researchkube1'
alias git-saas='~/cylent/dev-tools/master-push/git-all.sh ~/cylent/dev-tools/master-push/saasRepos.txt $@'
EOF
