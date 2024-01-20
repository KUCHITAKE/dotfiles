#!/usr/bin/env bash
set -ue

helpmsg() {
  echo "Usage: $0 [--help | -h]" 0>&2
  echo ""
}

install_zsh() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # For macOS
    if ! command -v brew &> /dev/null; then
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
  yes N | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

link_zsh_config() {
  echo "Backing up existing zsh configuration..."
  if [ ! -d "$HOME/.dotbackup" ]; then
    echo "$HOME/.dotbackup not found. Creating it..."
    mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local repo_zsh_config="$script_dir/.config/zsh"

  if [ ! -d "$repo_zsh_config" ]; then
    echo "Zsh config directory $repo_zsh_config does not exist in the repository."
    exit 1
  fi

  if [ -L "$HOME/.config/zsh" ]; then
    rm -f "$HOME/.config/zsh"
  fi

  if [ -e "$HOME/.config/zsh" ]; then
    mv "$HOME/.config/zsh" "$HOME/.dotbackup"
  fi

  mkdir -p "$HOME/.config"
  ln -snf $repo_zsh_config "$HOME/.config/zsh"
}

while [ $# -gt 0 ]; do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

install_zsh
install_zinit
link_zsh_config
echo -e "\e[1;36m Zsh configuration linked! \e[m"
