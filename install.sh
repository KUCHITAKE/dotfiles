#!/usr/bin/env bash

set -ue

helpmsg() {
  echo "Usage: $0 [--help | -h]" 0>&2
  echo ""
}

install_zsh() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # For macOS
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Installing Zsh using Homebrew..."
    brew install zsh
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # For Debian/Ubuntu
    echo "Installing Zsh using apt..."
    sudo apt update
    sudo apt install -y zsh
  else
    echo "Unsupported OS."
    exit 1
  fi
}

install_zinit() {
  echo "Installing Zinit..."
  # Using 'yes' to automatically reply 'N' to any y/N prompts
  yes N | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

link_zsh_config() {
  link_config_files ".config/zsh" "$script_dir/.config/zsh"
}

link_tmux_config() {
  link_config_files ".config/tmux" "$script_dir/.config/tmux"
}

link_nvim_config() {
  link_config_files ".config/nvim" "$script_dir/.config/nvim"
}

link_alacritty_config() {
  link_config_files ".config/alacritty" "$script_dir/.config/alacritty"
}

link_config_files() {
  local target_dir="$1"
  local repo_dir="$2"

  if [ ! -d "$repo_dir" ]; then
    echo "Config directory $repo_dir does not exist in the repository."
    return 1
  fi

  find "$repo_dir/" -mindepth 1 -maxdepth 1 | while read entry; do
    entry_name=$(basename "$entry")
    if [ -d "$entry" ]; then
      echo "Copying directory $entry_name..."
      cp -r "$entry" "$HOME/$target_dir/$entry_name"
      link_config_files "$target_dir/$entry_name" "$entry"
    elif [ -f "$entry" ]; then
      echo "Linking file $entry_name..."
      ln -snf "$entry" "$HOME/$target_dir/$entry_name"
    fi
  done
}

while [ $# -gt 0 ]; do
  case ${1} in
  --debug | -d)
    set -uex
    ;;
  --help | -h)
    helpmsg
    exit 1
    ;;
  *) ;;
  esac
  shift
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

install_zsh
install_zinit
link_config_files ".config" "$script_dir/.config"
# link_zsh_config
# link_tmux_config
# link_nvim_config
# link_alacritty_config

echo -e "\e[1;36m Zsh setup completed! \e[m"
