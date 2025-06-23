# Justfile for running common dotfile scripts

# Default recipe lists available recipes
default:
	@just --list

# Run the Ubuntu LTS setup script
setup-ubuntu-lts:
	bash scripts/ubuntu-lts.sh

# Apply dotfiles using GNU Stow
stow:
	bash scripts/stow/dotfiles.sh

# Format all shell scripts
format-sh:
	shfmt -i 2 -w $(git ls-files '*.sh')

# Lint shell scripts with shellcheck
lint-sh:
	shellcheck $(git ls-files '*.sh')

# Format Lua files
format-lua:
	stylua $(git ls-files '*.lua')

# Run nix flake check
nix-check:
	nix flake check
