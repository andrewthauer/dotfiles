DOTFILES_HOME = $(CURDIR)
PRETTIER ?= prettier

default: lint

.PHONY: lint
lint: shellcheck fmt-check

.PHONY: shellcheck
shellcheck:
	@shellcheck $$(make --no-print-directory shell-files)

.PHONY: fmt-check
fmt-check:
	@$(PRETTIER) --check --log-level warn .
	@shfmt --list $$(make --no-print-directory shell-files)

.PHONY: fmt
fmt:
	@$(PRETTIER) --write --log-level warn .
	@shfmt --write $$(make --no-print-directory shell-files)

.PHONY: shell-files
shell-files:
	@shfmt -f . | grep -v '^.*.zsh'
