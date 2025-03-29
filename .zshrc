

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/463c96f7m0i4k7wrzr4l5ch6bgn9llv1-zsh-5.9/share/zsh/$ZSH_VERSION/help"



export ZPLUG_HOME=/home/elena/.zplug

source /nix/store/k09xcy7n2gvnhkvfqblrw82bvb2kszj1-zplug-2.4.2/share/zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "romkatv/powerlevel10k", as:theme, depth:1




if ! zplug check; then
  zplug install
fi

zplug load

path+="$HOME/.zsh/plugins/zsh-nix-shell"
fpath+="$HOME/.zsh/plugins/zsh-nix-shell"

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit





if [[ -f "$HOME/.zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-nix-shell/nix-shell.plugin.zsh"
fi


# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


if [[ $options[zle] = on ]]; then
  eval "$(/nix/store/y2fbihhpi1ml7m63c723qgh4izdvy1rr-fzf-0.60.2/bin/fzf --zsh)"
fi

unsetopt correct # autocorrect commands

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered

# Autocomplete opts
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name "" # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# bindkey '^I' forward-word         # tab
# bindkey '^[[Z' backward-word      # shift+tab
# bindkey '^ ' autosuggest-accept   # ctrl+space

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}


# Aliases
alias -- cat='/nix/store/swhf1aq2mxyb59ipc7znjvpzh97d7fkz-bat-0.25.0/bin/bat -p'
alias -- dir=/nix/store/zayl3l5p5625fcm24zhgqkaxp340diq7-yazi-25.3.2/bin/yazi
alias -- gd='/nix/store/nj1na0qwqhpd128vr71p70hz9jyhnz5x-git-2.48.1/bin/git diff --name-only --relative --diff-filter=d | /nix/store/lk2sg2yq5jqs9dlx5ini46kvjwk7ffsf-findutils-4.10.0/bin/xargs /nix/store/swhf1aq2mxyb59ipc7znjvpzh97d7fkz-bat-0.25.0/bin/bat --diff'
alias -- ll='/nix/store/26i6s55k89izafslllc9lqy7x17vzgjx-eza-0.20.23/bin/eza -a --long --header --git'
alias -- ls='/nix/store/26i6s55k89izafslllc9lqy7x17vzgjx-eza-0.20.23/bin/eza --header --git'

# Named Directory Hashes




