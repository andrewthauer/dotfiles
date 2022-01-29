#
# Home Assistant helpers
#

hass-list-domains() {
  hass-cli state list | awk '{print $1}' | awk -F"." '{print $1}' | sort | uniq
}
