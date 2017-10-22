#!/usr/bin/env sh
#
# General macos setup
#

# Set hostname, computer name
HOSTNAME="MY-MAC-NAME" && \
   sudo scutil --set HostName ${HOSTNAME} && \
   sudo scutil --set LocalHostName ${HOSTNAME} && \
   sudo scutil --set ComputerName ${HOSTNAME} && \
   dscacheutil -flushcache
