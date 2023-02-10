#
# macOS utils
#

# Flush dns on macos
flush-dns-cache() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}
