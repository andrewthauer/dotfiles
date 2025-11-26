#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Function to prompt before performing an action
prompt_for_action() {
  local name="$1"
  local command="$2"
  local check_command="$3"

  # Check if action is required (if check command provided)
  if [[ -n "$check_command" ]]; then
    if eval "$check_command" &>/dev/null; then
      echo "$name is already configured, skipping."
      return 0
    fi
  fi

  if read -p "Do you want to configure $name? (y/N): " -n 1 -r && echo; then
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Configuring $name..."
      eval "$command"
    fi
  fi
}

# Setup fprintd for fingerprint authentication
setup_fprintd() {
  echo "Setting up fprintd for fingerprint authentication..."

  # Install fprintd if not already installed
  if ! command -v fprintd &>/dev/null; then
    echo "Installing fprintd..."
    pkg install fprintd
  fi

  # Enable and start fprintd service
  if command -v systemctl &>/dev/null; then
    sudo systemctl enable fprintd.service
    sudo systemctl start fprintd.service
  fi

  # Enroll fingerprint
  echo "Starting fingerprint enrollment..."
  echo "You can enroll multiple fingers by running: fprintd-enroll"
  fprintd-enroll

  # Configure PAM for sudo with fingerprint
  local pam_sudo="/etc/pam.d/sudo"
  if [[ -f "$pam_sudo" ]]; then
    if ! grep -q "pam_fprintd.so" "$pam_sudo"; then
      echo "Configuring PAM for sudo with fingerprint support..."
      sudo sed -i '1i auth sufficient pam_fprintd.so' "$pam_sudo"
      echo "Fingerprint authentication enabled for sudo!"
    else
      echo "PAM already configured for fingerprint authentication."
    fi
  else
    echo "Warning: $pam_sudo not found. Skipping PAM configuration."
  fi

  # Configure PAM for login (optional)
  local pam_login="/etc/pam.d/login"
  if [[ -f "$pam_login" ]]; then
    if ! grep -q "pam_fprintd.so" "$pam_login"; then
      if read -p "Do you want to enable fingerprint for login as well? (y/N): " -n 1 -r && echo; then
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          sudo sed -i '1i auth sufficient pam_fprintd.so' "$pam_login"
          echo "Fingerprint authentication enabled for login!"
        fi
      fi
    fi
  fi

  # Configure PAM for greeter (display manager)
  local pam_greeter="/etc/pam.d/lightdm-greeter"
  if [[ -f "$pam_greeter" ]]; then
    if ! grep -q "pam_fprintd.so" "$pam_greeter"; then
      if read -p "Do you want to enable fingerprint for the greeter/display manager? (y/N): " -n 1 -r && echo; then
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          sudo sed -i '1i auth sufficient pam_fprintd.so' "$pam_greeter"
          echo "Fingerprint authentication enabled for greeter!"
        fi
      fi
    fi
  else
    # Try other common greeters
    for greeter in "/etc/pam.d/gdm-password" "/etc/pam.d/sddm" "/etc/pam.d/lxdm"; do
      if [[ -f "$greeter" ]]; then
        if ! sudo grep -q "pam_fprintd.so" "$greeter"; then
          if read -p "Do you want to enable fingerprint for $(basename $greeter)? (y/N): " -n 1 -r && echo; then
            if [[ $REPLY =~ ^[Yy]$ ]]; then
              sudo sed -i '1i auth sufficient pam_fprintd.so' "$greeter"
              echo "Fingerprint authentication enabled for $(basename $greeter)!"
            fi
          fi
        fi
      fi
    done
  fi
}

# Setup polkit with fingerprint authentication
setup_polkit_fingerprint() {
  echo "Setting up polkit with fingerprint authentication..."

  local polkit_pam_src="/usr/lib/pam.d/polkit-1"
  local polkit_pam_dst="/etc/pam.d/polkit-1"

  # Copy polkit-1 PAM config if it doesn't exist in /etc
  if [[ ! -f "$polkit_pam_dst" ]]; then
    if [[ -f "$polkit_pam_src" ]]; then
      echo "Copying polkit-1 PAM configuration to /etc/pam.d/..."
      sudo cp "$polkit_pam_src" "$polkit_pam_dst"
    else
      echo "Warning: $polkit_pam_src not found. Creating new PAM config..."
      sudo mkdir -p "$(dirname "$polkit_pam_dst")"
      sudo tee "$polkit_pam_dst" >/dev/null <<'EOF'
#%PAM-1.0
auth       sufficient   pam_fprintd.so
auth       include      system-auth
account    include      system-auth
password   include      system-auth
session    include      system-auth
EOF
    fi
  else
    echo "PAM configuration already exists at $polkit_pam_dst"
  fi

  # Add fingerprint authentication to polkit PAM config
  if ! sudo grep -q "pam_fprintd.so" "$polkit_pam_dst"; then
    echo "Adding fingerprint authentication to polkit PAM configuration..."
    sudo sed -i '1i auth sufficient pam_fprintd.so' "$polkit_pam_dst"
    echo "Fingerprint authentication enabled for polkit!"
  else
    echo "Fingerprint authentication already configured for polkit."
  fi

  echo ""
  echo "Polkit fingerprint authentication setup complete!"
  echo "This allows applications (like 1Password) to use fingerprint authentication via polkit."
  echo "Note: You may need to restart your session for changes to take effect."
}

# Main function
main() {
  echo "==================================="
  echo "Linux Extras Setup"
  echo "==================================="
  echo ""
  echo "This script will help you configure:"
  echo "  1. fprintd - Fingerprint authentication for sudo, login, and greeter"
  echo "  2. polkit - Fingerprint authentication for applications (e.g., 1Password)"
  echo ""

  # Setup fprintd
  prompt_for_action "fprintd (fingerprint authentication)" \
    "setup_fprintd" \
    "command -v fprintd"

  echo ""

  # Setup polkit fingerprint
  prompt_for_action "polkit fingerprint authentication" \
    "setup_polkit_fingerprint" \
    "sudo grep -q pam_fprintd.so /etc/pam.d/polkit-1 2>/dev/null"

  echo ""
  echo "==================================="
  echo "Setup Complete!"
  echo "==================================="
  echo ""
  echo "Additional commands you might find useful:"
  echo "  - List enrolled fingerprints: fprintd-list <username>"
  echo "  - Delete fingerprints: fprintd-delete <username>"
  echo "  - Verify fingerprint: fprintd-verify"
  echo "  - Test 1Password: op vault list"
  echo ""
}

main "$@"
