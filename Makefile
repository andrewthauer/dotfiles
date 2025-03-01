DOTFILES_HOME = $(CURDIR)

default: lint

.PHONY: lint
lint: shellcheck fmt-check

.PHONY: shellcheck
shellcheck:
	@shellcheck $$(make shell-files)

.PHONY: fmt-check
fmt-check:
	@deno fmt --check --quiet
	@shfmt --list $$(make shell-files)

.PHONY: fmt
fmt:
	@deno fmt --quiet
	@shfmt --write $$(make shell-files)

.PHONY: shell-files
shell-files:
	@shfmt -f . | grep -v '^.*.zsh'
