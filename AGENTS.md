# AGENTS Instructions

This repository contains various dotfile configurations and setup scripts.

## Build/Test Commands

Use `just` for common tasks:
- `just format-sh` - Format all shell scripts with shfmt
- `just lint-sh` - Lint all shell scripts with shellcheck
- `just format-lua` - Format Lua files with stylua
- `just nix-check` - Validate nix flake (if modified)

## Code Style

**Shell Scripts:**
- Use `#!/usr/bin/env bash` shebang and `set -euo pipefail`
- Format with `shfmt -i 2` (2-space indentation)
- Use descriptive variable names with underscores: `dotfiles_dir`
- Prefer double quotes for variables: `"$variable"`
- Use emoji indicators: `🔄` for progress, `✅` for success, `→` for actions

**Lua (Neovim):**
- 2-space indentation, 120 column width (stylua.toml)
- Follow existing plugin patterns in `nvim/lua/plugins/`

## Error Handling

Always use `set -euo pipefail` in bash scripts. Check command existence with `command -v tool &>/dev/null`.

## Testing

Before commits, run: `just lint-sh && just format-sh --diff`

## PR Guidelines

- Reference files using repo-relative paths
- Include linting results in PR body
