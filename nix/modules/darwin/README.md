# Darwin Modules

This directory contains nix-darwin configuration modules for macOS systems.

## Core Modules

- `nix-core.nix` - Core Nix configuration and settings
- `system.nix` - Base macOS system preferences and defaults  
- `apps.nix` - Application installations via Homebrew and nixpkgs
- `apps-aarch64.nix` - ARM64-specific applications
- `host-users.nix` - User account configuration

## Host-Specific Configurations

Host-specific configurations have been moved to the `hosts/` directory for better organization:

### Delta Host Configuration

**Location**: `hosts/delta/`

The delta host configuration for the M2 MacBook Air has been moved to its own directory:
- `hosts/delta/desktop-configuration.nix` - Closed-clamshell desktop settings  
- `hosts/delta/README.md` - Detailed documentation

**Purpose**: Configures the M2 MacBook Air "delta" for closed-clamshell desktop operation.

**Key Features**:
- Enables clamshell mode with `AllowSystemSleepWithLidClosed` 
- Desktop-optimized power management (never sleep, aggressive fan control)
- External display priority and routing configuration
- Wake-on-keyboard/mouse without requiring clamshell opening
- Thermal management optimized for closed-lid operation
- Auto-login to prevent startup issues with closed clamshell
- SSH enabled for remote access

**Usage**: 
The desktop configuration is included in the delta darwinConfiguration in `flake.nix`:

```nix
modules = [
  ./modules/darwin/nix-core.nix
  ./modules/darwin/system.nix
  ./hosts/delta/desktop-configuration.nix  # <-- Closed-clamshell desktop settings
  # ... other modules
];
```

**Management**: Use `scripts/delta_desktop_setup.sh` for configuration management and troubleshooting.

See `hosts/delta/README.md` for detailed documentation on the delta host configuration.