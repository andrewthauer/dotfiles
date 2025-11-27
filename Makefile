DOTFILES_HOME = $(CURDIR)

default: lint

.PHONY: lint
lint: shellcheck fmt-check

.PHONY: shellcheck
shellcheck:
	@shellcheck $$(make --no-print-directory shell-files)

.PHONY: fmt-check
fmt-check:
	@deno fmt --check --quiet
	@shfmt --list $$(make --no-print-directory shell-files)

.PHONY: fmt
fmt:
	@deno fmt --quiet
	@shfmt --write $$(make --no-print-directory shell-files)

.PHONY: shell-files
shell-files:
	@shfmt -f . | grep -v '^.*.zsh'
