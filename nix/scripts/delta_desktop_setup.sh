#!/bin/bash

###################################################################################
#
# Delta Desktop Setup Script
# 
# This script helps configure and manage the M2 MacBook Air "delta" for 
# closed-clamshell desktop operation with external monitor.
#
# Usage: ./delta_desktop_setup.sh [command]
#
# Commands:
#   configure  - Apply nix-darwin configuration and set up power management
#   status     - Show current power management and display settings
#   troubleshoot - Check for common clamshell mode issues
#   reset      - Reset power settings to defaults
#
###################################################################################

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on delta system
check_system() {
    local hostname=$(hostname -s)
    if [[ "$hostname" != "delta" ]]; then
        log_error "This script is designed for the 'delta' system. Current hostname: $hostname"
        exit 1
    fi
    
    # Check if M2 MacBook Air
    local model=$(system_profiler SPHardwareDataType | grep "Model Name" | awk -F': ' '{print $2}')
    if [[ "$model" != *"MacBook Air"* ]]; then
        log_warning "This script is optimized for MacBook Air. Detected: $model"
    fi
}

# Apply nix-darwin configuration
configure_system() {
    log_info "Applying nix-darwin configuration for delta desktop mode..."
    
    # Build and apply the configuration
    if command -v just &> /dev/null; then
        just darwin-delta
    else
        darwin-rebuild switch --flake .#delta
    fi
    
    log_success "nix-darwin configuration applied successfully"
}

# Show current system status
show_status() {
    log_info "Current Delta Desktop Status:"
    echo
    
    log_info "Power Management Settings:"
    echo "System Sleep Timer: $(pmset -g | grep 'sleep' | awk '{print $2}')"
    echo "Display Sleep Timer: $(pmset -g | grep 'displaysleep' | awk '{print $2}')"
    echo "Disk Sleep Timer: $(pmset -g | grep 'disksleep' | awk '{print $2}')"
    echo "Wake on LAN: $(pmset -g | grep 'womp' | awk '{print $2}')"
    echo "Lid Wake: $(pmset -g | grep 'lidwake' | awk '{print $2}')"
    echo "Hibernation Mode: $(pmset -g | grep 'hibernatemode' | awk '{print $2}')"
    echo
    
    log_info "Display Configuration:"
    echo "Connected Displays:"
    system_profiler SPDisplaysDataType | grep -E "(Display Type|Resolution|Connection Type)" | head -10
    echo
    
    log_info "Thermal Status:"
    echo "Thermal State: $(pmset -g therm)"
    echo
    
    log_info "System Load:"
    uptime
    echo "CPU Temperature: $(sudo powermetrics -n 1 -i 1000 --samplers smc -o /dev/stdout 2>/dev/null | grep 'CPU die temperature' | tail -1 || echo 'Unable to read')"
}

# Troubleshoot common issues
troubleshoot() {
    log_info "Troubleshooting Delta Desktop Configuration..."
    echo
    
    # Check if external display is connected
    local displays=$(system_profiler SPDisplaysDataType | grep -c "Display Type" || echo "0")
    if [[ $displays -lt 2 ]]; then
        log_warning "Only $displays display(s) detected. Ensure external monitor is connected."
    else
        log_success "Multiple displays detected ($displays total)"
    fi
    
    # Check clamshell mode settings
    local clamshell_setting=$(defaults read /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.SystemPowerSettings | grep -i "allowsystemsleepwithlidclosed" || echo "not found")
    if [[ "$clamshell_setting" == "not found" ]]; then
        log_warning "Clamshell mode setting not found in system preferences"
    else
        log_success "Clamshell mode setting found: $clamshell_setting"
    fi
    
    # Check if system is running hot
    local thermal_state=$(pmset -g therm | grep -o "No thermal pressure\\|Thermal pressure" || echo "unknown")
    if [[ "$thermal_state" == *"pressure"* ]]; then
        log_warning "System is under thermal pressure - consider improving ventilation"
    else
        log_success "Thermal state: $thermal_state"
    fi
    
    # Check for power source
    local power_source=$(pmset -g ps | head -1)
    if [[ "$power_source" == *"Battery"* ]]; then
        log_warning "Running on battery power. Connect AC adapter for optimal desktop performance."
    else
        log_success "Running on AC power"
    fi
    
    # Check SSH access
    if pgrep -x "sshd" > /dev/null; then
        log_success "SSH daemon is running for remote access"
    else
        log_warning "SSH daemon not running - remote access may not be available"
    fi
}

# Reset power settings to defaults
reset_settings() {
    log_warning "Resetting power management settings to defaults..."
    read -p "Are you sure you want to reset all power settings? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pmset -a sleep 1
        sudo pmset -a displaysleep 10
        sudo pmset -a disksleep 10
        sudo pmset -a womp 0
        sudo pmset -a lidwake 1
        sudo pmset -a hibernatemode 3
        sudo pmset -a autopoweroff 1
        sudo pmset -a standby 1
        log_success "Power settings reset to defaults"
        log_info "You may need to reconfigure for desktop operation"
    else
        log_info "Reset cancelled"
    fi
}

# Main function
main() {
    check_system
    
    case "${1:-}" in
        "configure")
            configure_system
            ;;
        "status")
            show_status
            ;;
        "troubleshoot")
            troubleshoot
            ;;
        "reset")
            reset_settings
            ;;
        *)
            echo "Delta Desktop Setup Script"
            echo
            echo "Usage: $0 [command]"
            echo
            echo "Commands:"
            echo "  configure     Apply nix-darwin configuration and set up power management"
            echo "  status        Show current power management and display settings"
            echo "  troubleshoot  Check for common clamshell mode issues"
            echo "  reset         Reset power settings to defaults"
            echo
            exit 1
            ;;
    esac
}

main "$@"