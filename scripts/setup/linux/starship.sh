#!/usr/bin/env bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../lib/common.sh
source "$SCRIPT_DIR/../../lib/common.sh"

setup_error_handling
check_not_root
check_requirements curl

ZSHRC="$HOME/.zshrc"
INIT_CMD='eval "$(starship init zsh)"'

# 1. Install Starship if missing
if command_exists starship; then
    log_success "Starship is already installed."
else
    log_step "Installing Starship prompt…"

    # Download and verify the install script
    install_script="/tmp/starship-install.sh"
    secure_download "https://starship.rs/install.sh" "$install_script"

    # Make script executable and run it
    chmod +x "$install_script"
    if ! bash "$install_script" -y; then
        log_error "Starship installation failed"
        rm -f "$install_script"
        exit 1
    fi

    # Cleanup
    rm -f "$install_script"
    log_success "Starship installed."
fi

# 2. Add init line to .zshrc if not present
if [[ -f "$ZSHRC" ]]; then
    if grep -Fxq "$INIT_CMD" "$ZSHRC"; then
        log_success "Starship init already present in $ZSHRC."
    else
        log_step "Adding Starship init to $ZSHRC…"
        {
            echo ""
            echo "# Initialize Starship prompt"
            echo "$INIT_CMD"
        } >> "$ZSHRC"
        log_success "Added Starship init to $ZSHRC."
    fi
else
    log_warning "$ZSHRC not found. You may need to create it and add: $INIT_CMD"
fi

log_success "Starship setup complete! Restart your terminal or run 'source ~/.zshrc' to start using it."
