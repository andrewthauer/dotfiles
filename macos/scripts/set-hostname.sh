#!/usr/bin/env bash
#
# description:
#   Set the various mac hostnames
#
# usage:
#   set-hostname 'my-host-name'
#

# Prompt for admin password upfront
sudo -v

# The variable
hostname="$1"

# Make sure hostname
if ! [ ! -n "$hostname" ]; then
  echo "Hostname was not supplied"
  exit 1
fi

# Set hostname, computer name
sudo scutil --set HostName ${hostname}
sudo scutil --set LocalHostName ${hostname}
sudo scutil --set ComputerName ${hostname}
dscacheutil -flushcache
