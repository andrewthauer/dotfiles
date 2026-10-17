# Dotfiles

Personal dotfiles for macOS and Linux. GNU Stow links each module into `$HOME`.

## Layout

- `bin/` has scripts that go on the `PATH`. `dotfiles` is the main command.
- `lib/` has shell utilities that load at shell startup.
- `modules/<name>/` holds one topic. Its files mirror their paths under `$HOME`.
  - `README.md` describes the module.
  - `install.sh` (optional, executable) installs the packages for the module.
  - Stow does not link `README.md`, `install.sh`, or names that start with `__`.
- `modules.txt` lists the modules for this machine. Git ignores it.
- `scripts/` has OS setup scripts.

## Links

- Do not run `stow` directly. Run `dotfiles sync <module>`. It adds the ignore
  patterns from `bin/dotfiles-module`. Without them, stow links `install.sh` and
  `README.md` into `$HOME`.
- To add a module, make `modules/<name>/` with a `README.md`. Then run
  `dotfiles install <name>`. It runs `install.sh`, adds the module to
  `modules.txt`, and links the module.
- Change files in `modules/`. Do not make real files in `$HOME` for config that
  a module owns.
- If only one module owns a directory, stow links the whole directory. New files
  that a tool writes there then go into the repo. To stop this, call
  `dotfiles noabsorb <dir>` in the module's `install.sh`.
- After a change to links, check the result with `ls -l` or `realpath` on the
  paths in `$HOME`.

## Private Files

- Git ignores `modules/local` and `modules/local-*`. Put secrets, work config,
  and machine-specific config there.
- Do not copy content from those modules into tracked files. Tracked files are
  public.
- Shared agent rules and skills are in `modules/agents`. Local agent rules are
  in `modules/local/.config/agents/AGENTS.local.md`.

## Shell Scripts

- Keep shell startup fast. Check it with `time-zsh` or `time-bash`.
- Write POSIX shell where possible. Files that load at shell startup must work
  in `bash` and `zsh`.
- Use `os-info --family` for OS checks. Use `pkg install` to install packages.
- Use XDG paths (`$XDG_CONFIG_HOME`, `$XDG_DATA_HOME`, `$XDG_CACHE_HOME`)
  instead of new files in `$HOME`.
- Copy the structure of an existing `install.sh` for a new one.

## Format and Lint

- Follow `.editorconfig`: 2 spaces in most files, tabs in Makefiles and git
  config.
- Run `make lint` before you finish. It runs `shellcheck`, `shfmt`, and
  `prettier --check`.
- Run `make fmt` to fix the format.
