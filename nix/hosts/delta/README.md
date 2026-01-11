# Delta Host Configuration

**Host**: M2 MacBook Air (Mac14,2) "delta"  
**Purpose**: Closed-clamshell desktop workstation with external monitor  
**Status**: Broken internal display, optimized for external-only operation

## Overview

The delta configuration transforms an M2 MacBook Air with a broken internal display into a reliable desktop workstation. The system operates with the clamshell closed and external monitor as the primary/only display.

## Hardware Context

- **Model**: 2022 M2 13-inch MacBook Air
- **Issue**: Internal display failed (repair cost $600+)
- **Setup**: External monitor required, AC power recommended
- **Use Cases**: Backup Mac station, scanning station, desktop replacement

## Configuration Files

### `desktop-configuration.nix`
Specialized module for closed-clamshell operation:
- **Clamshell Mode**: Enables `AllowSystemSleepWithLidClosed`
- **Power Management**: Desktop-optimized pmset configurations
- **Display Settings**: External monitor priority and routing
- **Wake Behavior**: Keyboard/mouse wake without clamshell opening
- **Thermal Management**: Closed-lid thermal policies
- **Auto-login**: Prevents startup issues with closed clamshell

## Build and Apply

```bash
# From nix-config repository root
just darwin-delta

# Or directly with darwin-rebuild
darwin-rebuild switch --flake .#delta

# Using management script
./scripts/delta_desktop_setup.sh configure
```

## Key Features

### Power Management
- Never sleep when on AC power
- Display sleep after 10 minutes
- Disk never sleeps
- Hibernation disabled (desktop mode)
- Wake on network and input devices
- Aggressive thermal management

### Display Configuration
- External monitor as primary display
- Internal display routing disabled
- Display preferences optimized for single external monitor
- Dock positioned on external display

### Wake Behavior
- USB keyboard/mouse wake enabled
- Bluetooth device wake supported
- Network wake (Wake on LAN) enabled
- No clamshell opening required

### Thermal Optimization
- Desktop thermal policies instead of laptop policies
- Aggressive fan management for closed-lid operation
- Thermal pressure monitoring and management

## Management and Troubleshooting

Use the included management script for common operations:

```bash
# Check system status
./scripts/delta_desktop_setup.sh status

# Troubleshoot common issues
./scripts/delta_desktop_setup.sh troubleshoot

# Reset power settings if needed
./scripts/delta_desktop_setup.sh reset
```

## Important Notes

1. **External Monitor Required**: System assumes external monitor is always connected
2. **AC Power Recommended**: Optimized for desktop use on AC power
3. **Remote Access**: SSH enabled for management when display issues occur
4. **Auto-login**: Configured to prevent login issues with closed clamshell
5. **No TouchID**: TouchID authentication disabled since not accessible

## Monitoring

Key metrics to monitor:
- CPU temperature (should remain reasonable with closed lid)
- Thermal pressure status
- External display connection status
- Power source (should be AC for optimal performance)
- SSH connectivity for remote access

## Troubleshooting

Common issues and solutions:
- **System won't wake**: Check USB/Bluetooth device connections
- **Overheating**: Ensure adequate ventilation around closed laptop
- **Display issues**: Verify external monitor connection and settings
- **Power management**: Use management script to check pmset configuration
- **Remote access**: Ensure SSH service is running and accessible