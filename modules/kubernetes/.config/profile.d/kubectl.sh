#
# Kubectl profile
#

# make helm more xdg compliant
export KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
export KREW_ROOT="${XDG_CONFIG_HOME}/krew"

# allow krew plugins
append_path "${KREW_ROOT}/bin"
