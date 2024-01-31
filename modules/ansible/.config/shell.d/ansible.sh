#
# Initialize ansible environment
#

if ! command_exists "ansible"; then
  return 1
fi

# XDG specifications
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
