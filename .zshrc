export LANG=en_US.UTF-8

export EDITOR="nvim"
export VISUAL="$EDITOR"

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-$HOST"

ZSH_THEME="lambda"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

zstyle ":omz:update" mode auto
zstyle ":omz:update" frequency 16

# autoload -U compinit && compinit
# autoload -U colors && colors

plugins=(git zsh-autosuggestions zsh-syntax-highlighting dotenv)

[ -r "$ZSH/oh-my-zsh.sh" ] && . "$ZSH/oh-my-zsh.sh"
[ -r "$HOME/.zsh_aliases" ] && . "$HOME/.zsh_aliases"

path_prepend() { case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac }
path_append()  { case ":$PATH:" in *":$1:"*) ;; *) PATH="$PATH:$1" ;; esac }
typeset -U path PATH

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -r "$HOME/.opam/opam-init/init.zsh" ] && . "$HOME/.opam/opam-init/init.zsh"

path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.local/share/bob/nvim-bin"
path_append "/usr/local/go/bin"
path_append "$HOME/go/bin"
path_append "/usr/local/zig/bin"

command -v uv >/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v uvx >/dev/null && eval "$(uvx --generate-shell-completion zsh)"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
