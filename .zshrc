export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

# Plugins
plugins=(zoxide git vi-mode)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Aliases
alias vi=nvim
alias ls=lsd
alias zed="zeditor ."

# Vi mode
set -o vi

# git clone from github
gcr() {
    local user="armando-rios"  # Cambia esto si usas otro usuario

    if [[ -n "$1" ]]; then
        git clone ar:$user/$1
    else
        echo "Uso: gcl <repositorio>"
    fi
}

# nvm setup
source /usr/share/nvm/init-nvm.sh

export PATH=$HOME/.local/bin:$PATH

# bun completions
[ -s "/home/rios/.bun/_bun" ] && source "/home/rios/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
