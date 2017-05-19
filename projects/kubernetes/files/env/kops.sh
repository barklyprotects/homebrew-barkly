#!/bin/bash

export KOPS_STATE_STORE=s3://barkly-kops
source <(kubectl completion zsh)
source <(kops completion zsh)
source <(helm completion zsh)
