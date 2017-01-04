#!/bin/bash

alias fd='find . -type d | sort'
alias ff='find . -type f | sort'
alias grep='grep --color=auto'
alias pgen='pwgen -sy 20'
alias k9='kill -9'
alias bandwidth="wget --output-document=/dev/null --report-speed=bits http://speedtest.wdc01.softlayer.com/downloads/test10.zip 2>&1 | grep ') -'"
alias git-saas='~/cylent/dev-tools/master-push/git-all.sh ~/cylent/dev-tools/master-push/saasRepos.txt $@'
alias git-rv='~/cylent/dev-tools/master-push/git-all.sh ~/cylent/dev-tools/master-push/rvRepos.txt $@'
