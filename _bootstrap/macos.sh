#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Running macOS bootstrap..."

if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

echo "==> Installing packages from Brewfile..."
brew bundle --file="$SCRIPT_DIR/Brewfile"

# Ensure ~/.zshenv points ZDOTDIR to ~/.config/zsh
ZSHENV="$HOME/.zshenv"
ZDOTDIR_LINE='export ZDOTDIR="$HOME/.config/zsh"'
if [[ ! -f "$ZSHENV" ]] || ! grep -qF 'ZDOTDIR' "$ZSHENV"; then
  echo "==> Configuring $ZSHENV to set ZDOTDIR..."
  echo "$ZDOTDIR_LINE" >> "$ZSHENV"
fi

# Install mise via official installer if not present, then install runtimes
MISE_BIN="$HOME/.local/bin/mise"
if ! command -v mise &>/dev/null && [[ ! -x "$MISE_BIN" ]]; then
  echo "==> Installing mise..."
  curl -fsSL https://mise.run | sh
fi

if command -v mise &>/dev/null; then
  echo "==> Installing mise tools..."
  mise install
elif [[ -x "$MISE_BIN" ]]; then
  echo "==> Installing mise tools..."
  "$MISE_BIN" install
fi

echo "==> macOS bootstrap complete!"
