SSH Plugin
==========

Functions
---------

### ssh_config_merge

This function can be used to merge various ssh configurations files together into `~.ssh/config` (since ssh does not have an include file feature). This can be useful to separate personal and work ssh configurations.

```bash
# ~/.zshrc.local
SSH_CONFIGS=(
  "$DOTFILES_DIR/secrets/ssh.base.config"
  "$DOTFILES_DIR/secrets/ssh.personal.config"
  "$DOTFILES_DIR/secrets/ssh.work.config"
)

# merge files defined in SSH_CONFIGS
ssh_config_merge
#   output to -> ~/.ssh/config
```
