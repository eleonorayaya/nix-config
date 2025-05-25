function ktls() {
  local W_FLAG=0

  while getopts ":w:" opt; do
    case ${opt} in
      w)
        W_FLAG=$OPTARG
        ;;
      \?)
        echo "Invalid option: -$OPTARG" 1>&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  NS="$(kubectl get ns --no-headers | fzf | awk '{print $1}')"

  if [ $W_FLAG -eq 0 ]; then
    kubectl get pods --no-headers -n $NS
    return
  fi

  while true; do
    clear
    kubectl get pods -n $NS --no-headers
    sleep $W_FLAG
  done
}

func ktld() {
  NS="$(kubectl get ns --no-headers | fzf | awk '{print $1}')"
  POD="$(kubectl get pods --no-headers -n $NS | fzf | awk '{print $1}')"
  kubectl describe pod -n $NS $POD
}

func ktlog() {
  local TAIL=false
  local LABEL=false

  while getopts ":fl" opt; do
    case ${opt} in
      f)
        TAIL=true
        ;;
      l)
        LABEL=true
        ;;
      \?)
        echo "Invalid option: -$OPTARG" 1>&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  NS="$(kubectl get ns --no-headers | fzf | awk '{print $1}')"
  POD="$(kubectl get pods -n $NS --no-headers | fzf | awk '{print $1}')"

  # If label flag is set, get the label value and use it to filter logs
  LABEL_EXP="$POD"
  if [ "$LABEL" = true ]; then
    QUERY='."app.kubernetes.io/name"'
    LABEL_VAL="$(kubectl get pod -n $NS $POD -o jsonpath='{.metadata.labels}' | jq $QUERY | tr -d '"')"
    LABEL_EXP="-l app.kubernetes.io/name=$LABEL_VAL"
  fi

  FOLLOW_EXP=""
  if [ "$TAIL" = true ]; then
    FOLLOW_EXP="-f"
  fi

  kubectl logs -n $NS $FOLLOW_EXP $LABEL_EXP --max-log-requests 500
}

func ktlsh() {
  NS="$(kubectl get ns --no-headers | fzf | awk '{print $1}')"
  POD="$(kubectl get pods --no-headers -n $NS | fzf | awk '{print $1}')"
  kubectl exec -it -n $NS $POD -- sh
}
