if [[ ! -f $ZINIT_HOME/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_HOME/zinit" && command chmod g-rwX "$ZINIT_HOME/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$ZINIT_HOME/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load Theme
zi ice pick"async.zsh" src"pure.zsh"
zi light sindresorhus/pure

# Plugins
zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word \
    light-mode \
    pick"async.zsh" \
    src"pure.zsh" \
  sindresorhus/pure

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
zi ice has'zoxide'
zi light z-shell/zsh-zoxide