#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

case "$OS" in
  Darwin)
    exec "$CONFIG_DIR/_bootstrap/macos.sh"
    ;;

  Linux)
    if [[ -f /etc/os-release ]] && grep -q '^ID=pika$' /etc/os-release; then
      exec "$CONFIG_DIR/_bootstrap/pikaos.sh"
    else
      echo "Error: Unsupported Linux distribution. Only PikaOS is supported." >&2
      exit 1
    fi
    ;;

  *)
    echo "Error: Unsupported operating system: $OS" >&2
    exit 1
    ;;
esac
