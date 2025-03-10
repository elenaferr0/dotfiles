# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
# plugins=(vi-mode)
source $ZSH/oh-my-zsh.sh
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{blue}N %f"
INSERT_MODE_INDICATOR="%F{yellow}I %f"
# PROMPT="%F{175}%n%f%F{224}@%F{175}%M%f %B%F{blue}%~%f%b
# \$(vi_mode_prompt_info)%f➜ %f"
# RPROMPT="%? \$(git_current_branch)"
NO_BEEP=true
AUTO_CD=true
CORRECT=true
CASE_SENSITIVE=true
export EDITOR='nvim'
# export SUDO_EDITOR='nvim'
alias vi=nvim
alias py=python
alias php=php81
alias pdflatex='pdflatex -interaction=batchmode'
eval "$(starship init zsh)"
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME"

#Tools exporting - it can be need in your case
export PATH=~/Android/Sdk/platform-tools:$PATH
export PATH=~/Android/Sdk/tools:$PATH
export PATH=~/Android/ndk-build:$PATH
export PATH=~/.cargo/bin:$PATH

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias dup="docker-compose --profile local up -d"
alias dupb="docker-compose --profile local up --build -d"
alias dst="docker-compose --profile local stop"
alias dwn="docker-compose --profile local down"
alias drm="docker-compose --profile local rm"

eval "$(pyenv init -)"
export LD_LIBRARY_PATH=/usr/lib/ 
