#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)}"
PATH="$DOTFILES_HOME/bin:$PATH"

uninstall_nix_macos() {
  sudo -v

  # open https://gist.github.com/chriselsner/3ebe962a4c4bd1f14d39897fc5619732

  echo "Unload nix daemons"
  sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
  sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-store.plist

  echo "Delete nix volume mount from etc/fstabs"
  sudo vifs

  echo "Listing volumes, look for the nix volume to remove"
  diskutil apfs list

  printf "What is the nix volume id for 'Nix Store' to remove? "
  read -r nix_volume
  [ -n "$nix_volume" ] && diskutil apfs deleteVolume "$nix_volume"

  echo "Remove the synthetic empty directory for mounting at /nix by running"
  sudo vim /etc/synthetic.conf

  printf "You may need to reboot to remove the /nix directory. Do you want to reboot and run this script again? "
  read -r answer
  case "${answer}" in [yY] | [yY][eE][sS])
    sudo reboot
    ;;
  esac

  echo "Removing nix daemons"
  [ -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist ] && sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
  [ -f /Library/LaunchDaemons/org.nixos.nix-store.plist ] && sudo rm /Library/LaunchDaemons/org.nixos.nix-store.plist

  echo "Removing nix daemon created users and groups"
  users=$(sudo dscl . list /Users | grep nixbld)
  if [ -n "$users" ]; then
    for user in $users; do
      echo "Remove user $user"
      sudo /usr/bin/dscl . -delete "/Users/$user"
      # echo "Remove group membership for $user"
      # sudo /usr/bin/dscl . -delete /Groups/staff GroupMembership "$user"
    done
    echo "Remove group nixbld"
    sudo /usr/bin/dscl . -delete "/Groups/nixbld"
  fi

  echo "Reverting system shell configurations"
  [ -f /etc/profile.backup-before-nix ] && sudo mv /etc/profile.backup-before-nix /etc/profile
  [ -f /etc/bashrc.backup-before-nix ] && sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
  [ -f /etc/zshrc.backup-before-nix ] && sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
  if [ -f /etc/bashrc.bashrc.backup-before-nix ]; then
    sudo mv /etc/bashrc.backup-before-nix /etc/bashrc.bashrc
  else
    echo "Backing up /etc/bashrc.bashrc and removing"
    cp /etc/bashrc.bashrc cp /etc/bashrc.bashrc.backup
    rm /etc/bashrc.bashrc
  fi

  echo "Removing nix files"
  sudo rm -rf /nix
  sudo rm -rf /etc/nix /etc/profile/nix.sh
  sudo rm -rf /var/root/{.nix-profile,.nix-defexpr.nix-channels.cache/nix}
  rm -rf ~/{.nix-profile,.nix-defexpr,.nix-channels,.nixpkgs,.config/nixpkgs.cache/nix}
}

main() {
  case "$(os-info --family)" in
    "macos")
      printf "This will completely remove nix. Are you sure you want to continue [y/N]? "
      read -r answer
      case "${answer}" in [yY] | [yY][eE][sS])
        if [ -x "/nix/nix-installer" ]; then
          sudo /nix/nix-installer uninstall
        else
          uninstall_nix
        fi
        ;;
      esac
      ;;
    *)
      echo "Not implemented for this OS"
      ;;
  esac
}

main "$@"
