# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Base theme for custom prompt config
ZSH_THEME=""

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Enable auto update without prompt
DISABLE_UPDATE_PROMPT="true"

# Startup message
source ~/.motd

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
# Must be set before the kubectl plugin is initialised.
[[ -s "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
# The next line enables shell command completion for gcloud.
[[ -s "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    docker-compose
    npm
    go
    history
    history-substring-search
    httpie
    kubectl
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# Prompt setup

# Pure (https://github.com/sindresorhus/pure)
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure

# Add kube to prompt (https://github.com/jonmosco/kube-ps1)
[[ -s "/usr/local/opt/kube-ps1/share/kube-ps1.sh" ]] && source "/usr/local/opt/kube-ps1/share/kube-ps1.sh" && PROMPT="$(kube_ps1)
"$PROMPT


# User configuration

# Set default Editor to Vim
export EDITOR="vim"

# Golang
[[ -s "/Users/andy/.gvm/scripts/gvm" ]] && source "/Users/andy/.gvm/scripts/gvm"
export GOPATH=$HOME/development/Go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOPRIVATE=gitlab.com

alias athens='kubectl --context soon-dev1 -n athens port-forward $(kubectl --context soon-dev1 -n athens get pods -lapp=athens-athens-proxy -o=jsonpath="{.items[0].metadata.name}") 5500:3000'

# Direnv
if [ "$(command -v direnv)" != "" ]
then
    eval "$(direnv hook zsh)"
fi

# GPG
export GPG_TTY=$(tty)

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Private Aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases

###-tns-completion-start-###
if [ -f /Users/andy/.tnsrc ]; then 
    source /Users/andy/.tnsrc 
fi
###-tns-completion-end-###

# Jenv
export JENV_ROOT="/usr/local/Cellar/jenv/"

if which jenv > /dev/null; 
	then eval "$(jenv init -)"; 
fi

# Android 
export ANDROID_HOME="/Users/$USER/Library/Android/sdk/"
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_AVD_HOME=/Users/$USER/.android/avd
export PATH=/Users/$USER/Library/Android/sdk/platform-tools:$PATH

