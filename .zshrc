export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(zoxide git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Aliases
alias vi=nvim
alias ls=lsd
alias zed="zeditor ."

gcr() {
    local user="armando-rios"  # Cambia esto si usas otro usuario

    if [[ -n "$1" ]]; then
        git clone ar:$user/$1
    else
        echo "Uso: gcl <repositorio>"
    fi
}
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source /usr/share/nvm/init-nvm.sh
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/.local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
