alias k=kubectl
alias kf='f() { [ "$2" ] && kubectl port-forward $1 $2 || kubectl port-forward $1; } ; f'
alias kp='f() { [ "$1" ] && kubectl get pods $1 || kubectl get pods ; } ; f'
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
