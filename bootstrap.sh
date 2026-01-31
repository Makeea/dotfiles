#!/usr/bin/env bash
set -e

echo "Running dotfiles bootstrap"

OS="$(uname -s)"
IS_WSL=false

# Detect WSL
if [ -r /proc/version ] && grep -qi microsoft /proc/version; then
  IS_WSL=true
fi

echo "Operating system: $OS"
echo "WSL detected: $IS_WSL"
echo ""

case "$OS" in
  Linux)
    if [ "$IS_WSL" = true ]; then
      echo "Environment: Linux (WSL)"
    else
      echo "Environment: Linux (native)"
    fi
    ;;
  Darwin)
    echo "Environment: macOS"
    ;;
  *)
    echo "Unsupported operating system: $OS"
    exit 1
    ;;
esac

echo ""
echo "Bootstrap finished (no actions performed)."
