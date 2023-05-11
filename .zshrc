export ZSH="$HOME/.oh-my-zsh"
#ZSH_THEME="spaceship"
ZSH_THEME="gnzh"
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{blue}N %f"
INSERT_MODE_INDICATOR="%F{yellow}I %f"
PROMPT="%F{175}%n%f%F{224}@%F{175}%M%f %B%F{blue}%~%f%b $(git_prompt_info)
\$(vi_mode_prompt_info)%f➜ %f"
RPROMPT=""
NO_BEEP=true
AUTO_CD=true
CORRECT=true
export EDITOR='nvim'
# export SUDO_EDITOR='nvim'
alias vi=nvim
