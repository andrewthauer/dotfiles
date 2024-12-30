DOTFILES_DIR = $(CURDIR)

default: lint

.PHONY: lint
lint: shellcheck fmt-check

.PHONY: shellcheck
shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shellcheck $$(find . -name '*.sh')

.PHONY: fmt-check
fmt-check:
	@deno fmt --check --quiet
	@shfmt --list $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt --list $$(find . -name '*.sh')

.PHONY: fmt
fmt:
	@deno fmt --quiet
	@shfmt --write $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt --write $$(find . -name '*.sh')
