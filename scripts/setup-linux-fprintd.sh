#!/usr/bin/env bash

set -e

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

echo "==================================="
echo "Fingerprint Setup"
echo "==================================="
echo ""

# Install fprintd
if ! command -v fprintd &>/dev/null; then
  read -p "fprintd is not installed. Install it now? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing fprintd..."
    pkg install fprintd
  else
    echo "fprintd is required. Exiting."
    exit 1
  fi
fi

# Enable and start service
echo "Starting fprintd service..."
sudo systemctl enable --now fprintd.service

# Enroll fingerprint
echo ""
echo "Starting fingerprint enrollment..."
fprintd-enroll

# Configure PAM for sudo
echo ""
echo "Configuring fingerprint for sudo..."
if ! grep -q "pam_fprintd.so" /etc/pam.d/sudo 2>/dev/null; then
  sudo sed -i '1i auth sufficient pam_fprintd.so' /etc/pam.d/sudo
  echo "Fingerprint enabled for sudo!"
else
  echo "Already configured for sudo."
fi

# Configure polkit for apps like 1Password
echo ""
echo "Configuring fingerprint for polkit (apps like 1Password)..."
polkit_pam="/etc/pam.d/polkit-1"

if [[ ! -f "$polkit_pam" ]] && [[ -f "/usr/lib/pam.d/polkit-1" ]]; then
  sudo cp /usr/lib/pam.d/polkit-1 "$polkit_pam"
fi

if [[ -f "$polkit_pam" ]]; then
  if ! sudo grep -q "pam_fprintd.so" "$polkit_pam" 2>/dev/null; then
    sudo sed -i '1i auth sufficient pam_fprintd.so' "$polkit_pam"
    echo "Fingerprint enabled for polkit!"
  else
    echo "Already configured for polkit."
  fi
else
  echo "Warning: polkit PAM config not found, skipping."
fi

# Configure login
echo ""
echo "Configuring fingerprint for login..."
if [[ -f /etc/pam.d/login ]]; then
  if ! sudo grep -q "pam_fprintd.so" /etc/pam.d/login 2>/dev/null; then
    sudo sed -i '1i auth sufficient pam_fprintd.so' /etc/pam.d/login
    echo "Fingerprint enabled for login!"
  else
    echo "Already configured for login."
  fi
fi

# Configure greeter/display manager
echo ""
echo "Configuring fingerprint for display manager..."
for greeter in /etc/pam.d/gdm-password /etc/pam.d/sddm /etc/pam.d/lightdm /etc/pam.d/lxdm; do
  if [[ -f "$greeter" ]]; then
    if ! sudo grep -q "pam_fprintd.so" "$greeter" 2>/dev/null; then
      sudo sed -i '1i auth sufficient pam_fprintd.so' "$greeter"
      echo "Fingerprint enabled for $(basename $greeter)!"
    else
      echo "Already configured for $(basename $greeter)."
    fi
  fi
done

echo ""
echo "Setup complete!"
echo ""
echo "Useful commands:"
echo "  fprintd-enroll              Enroll more fingerprints"
echo "  fprintd-list $USER          List enrolled fingerprints"
echo "  fprintd-delete $USER        Delete fingerprints"
