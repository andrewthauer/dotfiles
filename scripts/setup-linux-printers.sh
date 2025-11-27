#!/usr/bin/env bash

set -e

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

echo "==================================="
echo "Simple Linux Printer Setup"
echo "==================================="
echo ""

# Check if CUPS is installed
if ! command -v cupsd &>/dev/null; then
  read -p "CUPS is not installed. Install it now? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing CUPS..."
    pkg install cups system-config-printer
  else
    echo "CUPS is required. Exiting."
    exit 1
  fi
fi

# Enable and start CUPS service
echo "Starting CUPS service..."
sudo systemctl enable --now cups.service

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open CUPS web interface: http://localhost:631"
echo "  2. Go to Administration > Add Printer"
echo "  3. Or run: system-config-printer"
