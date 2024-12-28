#!/usr/bin/env bash

set -eou pipefail

configure_launch_agent_macos() {
  mkdir -p ~/Library/LaunchAgents

  cat <<EOF >~/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.1password.SSH_AUTH_SOCK</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>-c</string>
    <string>/bin/ln -sf $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock \$SSH_AUTH_SOCK</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

  launchctl load -w ~/Library/LaunchAgents/com.1password.SSH_AUTH_SOCK.plist
}

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      brew install 1password-cli
      configure_launch_agent_macos
      ;;
    *)
      echo "Not implemented for this OS"
      exit 1
      ;;
  esac
}

main "$@"
