# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Plugins
zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
zi ice has'zoxide'
zi light z-shell/zsh-zoxide

if  [[ -d $HOME/.rd ]]; then
  export PATH="$HOME/.rd/bin:$PATH"
fi

if [[ -d $HOMEBREW_PREFIX/opt/asdf ]]; then
  . $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

if [[ -d $HOME/.asdf ]]; then
  . $HOME/.asdf/asdf.sh
fi

if [[ -d $HOME/.cargo ]]; then
  . $HOME/.cargo/env
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
