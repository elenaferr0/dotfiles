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
eval "$(starship init zsh)"
export PATH="$PATH:$HOME/flutter/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
export ANDROID_HOME="/opt/android-sdk/platform-tools"
alias eww=~/eww/target/release/eww
