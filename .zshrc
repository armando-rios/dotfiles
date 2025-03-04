export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Aliases
alias nvimtest='nvim -u ~/.config/nvim-test/init.lua'
alias vi=nvim
alias ls=lsd
alias ssa='grim -g "$(slurp)" ~/Pictures/$(date +%Y%m%d_%H%M%S).png'
# alias gcr='gcl ar:armando-rios/'
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$HOME/.local/bin:$PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
