DOTFILES_DIR = $(CURDIR)
SHFMT_FLAGS = -i 2 -ci
PRETTIER_FLAGS = .config/.prettierrc --ignore-path .config/.prettierignore

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
	@shfmt -l $(SHFMT_FLAGS) $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -l $(SHFMT_FLAGS) $$(find . -name '*.sh')

.PHONY: fmt
fmt:
	@deno fmt --quiet
	@shfmt -w $(SHFMT_FLAGS) $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -w $(SHFMT_FLAGS) $$(find . -name '*.sh')
