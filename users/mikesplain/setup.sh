#!/bin/bash
THISDIRFILE=$(dirname $0)
cd $THISDIRFILE
THISDIR=$(pwd -P)
. "$HOMEBREWBARKLYDIR/lib/init.sh"

# Start your script below and user any helpsers setup in lib/init.sh


cat << 'EOF' > "$HOME/.env/splain.sh"
alias prod1='kubectl config use-context prod1 && cd ~/cylent/barkly-environments/prod1'
alias prod2='kubectl config use-context prod2 && cd ~/cylent/barkly-environments/prod2'
alias dev1='kubectl config use-context dev1 && cd ~/cylent/barkly-environments/dev1'
alias dev2='kubectl config use-context dev2 && cd ~/cylent/barkly-environments/dev2'
alias stage1='kubectl config use-context stage1 && cd ~/cylent/barkly-environments/stage1'
alias mgmt2='kubectl config use-context mgmt2 && cd ~/cylent/barkly-environments/mgmt2/'
alias researchkube1='kubectl config use-context researchkube1 && cd ~/cylent/barkly-environments/researchkube1/'
alias scale_up_mgmt2='aws autoscaling set-desired-capacity --auto-scaling-group-name mgmt2_minion_spot --desired-capacity 2'
EOF
