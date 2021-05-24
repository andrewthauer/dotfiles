# fzf

Configuration for [fzf](https://github.com/junegunn/fzf), a general-purpose
command-line fuzzy finder.

## Setup

```bash
stow fzf
```

## Usage

- General
  - `fzf`
  - `cd | fzf`
- Completions `**`
  - `cd **`
  - `export **`
  - `ssh **`
- Keybindings
  - `ctrl-t` - paste the selected files and directories onto the command-line
  - `ctrl-r` - paste the selected command from history onto the command-line
  - `alt-c` - cd into the selected directory
- Commands
  - `fzf-find-path`
  - `fzf-kill-process`
  - `fzf-kill-server`

## Resources

- https://github.com/junegunn/fzf
