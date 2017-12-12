function select_pod {
    pod_command=$1
    pod_grep=$2
    pods=`k get pods | awk '{print $1}' | grep $pod_grep`
    pods=($pods)
    num_pods=${#pods[@]}
    pod_selection=${pods[1]}
    if [ "$num_pods" -gt 1 ]; then
        i=0
        echo "--- More than one pod found; please select a pod by number ---\n"
        select option in "${pods[@]}"; do
            if [ "$REPLY" -eq "$num_pods" ];
            then
              break;
            elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $((num_pods-1)) ];
            then
              pod_selection=$option
              break;
            else
              echo "Incorrect Input: Select a number 1-$num_pods"
            fi
        done
    fi
    KUBECTL_NAMESPACE=${KUBECTL_NAMESPACE:-default}
    bold=$(tput bold)
    normal=$(tput sgr0)
    echo "${bold}kubectl $pod_command $pod_selection --namespace $KUBECTL_NAMESPACE${normal}"
    k $pod_command $pod_selection
}
