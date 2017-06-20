SSH Plugin
==========

Functions
---------

### ssh_config_merge

This function can be used to merge various ssh configurations files together into `~.ssh/config` (since ssh does not have an include file feature). This can be useful to separate personal and work ssh configurations.

```bash
# ~/.zshrc.local
SSH_CONFIGS=(
  "$DOTPATH/secrets/ssh.base.config"
  "$DOTPATH/secrets/ssh.personal.config"
  "$DOTPATH/secrets/ssh.work.config"
)

# merge files defined in SSH_CONFIGS
ssh_config_merge
#   output to -> ~/.ssh/config
```
