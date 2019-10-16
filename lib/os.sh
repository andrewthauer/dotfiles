# --------------------------------------------------------------
# OS utilities
#
# These functions are used to help with install scripts
# --------------------------------------------------------------

#
# Get the os family
#
get_os_family() {
  # ideally we would use an associative array here
  # but this needs to work in bash < v4 for macos
  os_info=(
    "/etc/auto_master::macos"
    "/etc/debian_version::debian"
    "/etc/fedora-release::fedora"
    "/etc/redhat-release::rhel"
    "/etc/arch-release::arch"
    "/etc/alpine-release::alpine"
  )
  for kv in ${os_info[@]}; do
    key="${kv%%::*}"
    val="${kv##*::}"
    [[ -f "$key" ]] && os_family="${val}"
  done
  echo "${os_family}"
}

#
# Get the package install command
#
package_mgr_install_cmd() {
  os_family="$(get_os_family)"

  case ${os_family} in
    "macos")    cmd="brew install" ;;
    "debian")   cmd="sudo apt-get install -y" ;;
    "fedora")   cmd="sudo dnf install -y" ;;
    "rhel")     cmd="sudo yum install -y" ;;
    "arch")     cmd="sudo pacman -S" ;;
    *)          cmd="" ;;
  esac

  echo "${cmd}"
}
