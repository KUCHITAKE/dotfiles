export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export XDG_RUNTIME_DIR=/run/user/$UID
mkdir -p $XDG_DATA_HOME $XDG_CONFIG_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_COMPDUMP=$ZSH_CACHE_DIR/.zcompdump
export HISTFILE=$XDG_STATE_HOME/zsh/history

# zinit
export ZINIT_HOME=$XDG_DATA_HOME/zinit


# have cargo
if [ -d "$HOME/.cargo/bin" ]; then
  . "$HOME/.cargo/env"
fi
