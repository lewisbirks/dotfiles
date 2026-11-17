#!/usr/bin/env bash
set -euo pipefail

echo "==> Running PikaOS bootstrap..."

echo "==> Installing packages with pikman..."
pikman install bat eza fastfetch fzf gh git ghostty zsh

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

echo "==> PikaOS bootstrap complete!"
