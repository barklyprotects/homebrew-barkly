#!/bin/bash

export KOPS_STATE_STORE=s3://barkly-kops
# NOTE: These were slow and kubectl seemed to autoload for me. Removing for now.
#source <(kubectl completion zsh)
source <(kops completion zsh)
#source <(helm completion zsh)

alias prod2='kubectl config use-context prod2.barkly.com'
alias dev1='kubectl config use-context dev1.barkly.com'
alias dev2='kubectl config use-context dev2.barkly.com'
alias dev3='kubectl config use-context dev3.barkly.com'
alias dev4='kubectl config use-context dev4.barkly.com'
alias mgmt1='kubectl config use-context mgmt1.barkly.com'
alias researchkube1='kubectl config use-context researchkube1'
alias researchkube2='kubectl config use-context researchkube2.barkly.com'

alias k='kubectl "--context=${KUBECTL_CONTEXT:-$(kubectl config current-context)}" ${KUBECTL_NAMESPACE/[[:alnum:]-]*/--namespace=${KUBECTL_NAMESPACE}}'
