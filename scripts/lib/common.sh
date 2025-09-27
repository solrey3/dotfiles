#!/usr/bin/env bash
# Common utility functions for setup scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}→${NC} $*"
}

log_success() {
    echo -e "${GREEN}✅${NC} $*"
}

log_warning() {
    echo -e "${YELLOW}⚠️${NC} $*"
}

log_error() {
    echo -e "${RED}❌${NC} $*" >&2
}

log_step() {
    echo -e "${YELLOW}🔄${NC} $*"
}

# Check if command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Check if package is installed (apt/dpkg)
package_installed() {
    dpkg -s "$1" &>/dev/null
}

# Download with verification
secure_download() {
    local url="$1"
    local output="$2"
    local expected_checksum="${3:-}"

    if [[ ! "$url" =~ ^https:// ]]; then
        log_error "Only HTTPS URLs are allowed: $url"
        return 1
    fi

    log_step "Downloading $url..."
    if ! curl -fsSL --connect-timeout 30 --max-time 300 "$url" -o "$output"; then
        log_error "Failed to download $url"
        return 1
    fi

    if [[ -n "$expected_checksum" ]]; then
        log_step "Verifying checksum..."
        local actual_checksum
        actual_checksum=$(sha256sum "$output" | cut -d' ' -f1)
        if [[ "$actual_checksum" != "$expected_checksum" ]]; then
            log_error "Checksum verification failed"
            log_error "Expected: $expected_checksum"
            log_error "Actual:   $actual_checksum"
            rm -f "$output"
            return 1
        fi
        log_success "Checksum verified"
    fi

    log_success "Downloaded successfully"
}

# Install packages with error handling
install_packages() {
    local packages=("$@")

    log_step "Updating package index..."
    if ! sudo apt update; then
        log_error "Failed to update package index"
        return 1
    fi

    log_step "Installing packages: ${packages[*]}"
    if ! sudo apt install -y "${packages[@]}"; then
        log_error "Failed to install packages"
        return 1
    fi

    log_success "Packages installed successfully"
}

# Create directory with proper permissions
create_dir() {
    local dir="$1"
    local mode="${2:-755}"

    if [[ ! -d "$dir" ]]; then
        log_step "Creating directory: $dir"
        if ! mkdir -p "$dir"; then
            log_error "Failed to create directory: $dir"
            return 1
        fi
        chmod "$mode" "$dir"
        log_success "Directory created: $dir"
    fi
}

# Backup file if it exists
backup_file() {
    local file="$1"
    local backup_suffix="${2:-.backup.$(date +%Y%m%d_%H%M%S)}"

    if [[ -f "$file" ]]; then
        local backup_file="${file}${backup_suffix}"
        log_step "Backing up $file to $backup_file"
        cp "$file" "$backup_file"
        log_success "Backup created: $backup_file"
    fi
}

# Add line to file if not present
add_line_to_file() {
    local line="$1"
    local file="$2"

    if ! grep -Fxq "$line" "$file" 2>/dev/null; then
        log_step "Adding line to $file: $line"
        echo "$line" >> "$file"
        log_success "Line added to $file"
    else
        log_info "Line already present in $file"
    fi
}

# Check if running as root (when it shouldn't be)
check_not_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root"
        exit 1
    fi
}

# Check minimum requirements
check_requirements() {
    local requirements=("$@")
    local missing=()

    for req in "${requirements[@]}"; do
        if ! command_exists "$req"; then
            missing+=("$req")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required commands: ${missing[*]}"
        log_error "Please install them before running this script"
        return 1
    fi

    log_success "All requirements met"
}

# Cleanup function for trap
cleanup_on_exit() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log_error "Script failed with exit code $exit_code"
    fi
}

# Set up error handling and cleanup
setup_error_handling() {
    set -euo pipefail
    trap cleanup_on_exit EXIT
}