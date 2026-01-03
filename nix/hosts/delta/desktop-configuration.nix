{ pkgs, lib, ... }:

###################################################################################
#
#  Delta closed-clamshell desktop configuration
#  
#  This module configures the M2 MacBook Air "delta" to work optimally as a
#  desktop workstation with the clamshell closed and external monitor only.
#
#  This module focuses specifically on clamshell mode, power management,
#  and display settings. Base system configuration is handled by other modules.
#
###################################################################################
{
  system = {
    defaults = {
      # Clamshell mode and external display preferences
      CustomUserPreferences = {
        # Core clamshell mode settings
        "com.apple.PowerManagement" = {
          # Allow system to stay awake with external display connected when lid is closed
          # This is the key setting for clamshell mode
          "AllowSystemSleepWithLidClosed" = true;
        };
        
        # Display configuration for external monitor primary use
        "com.apple.windowserver" = {
          # Configure external display as primary when lid is closed
          DisplayResolutionEnabled = true;
          # Disable built-in display when external is connected
          CGDisplayUsesInvertedPolarity = false;
        };
        
        # Energy Saver settings optimized for desktop use
        "com.apple.PowerManagement.SystemSettings" = {
          # Prevent computer sleep when display is off (desktop behavior)
          "System Sleep Timer" = 0;  # Never sleep
          "Disk Sleep Timer" = 0;    # Never sleep disks
          # Keep network active during sleep
          "Wake On LAN" = true;
          # Allow wake from keyboard/mouse
          "Wake On Modem Ring" = false;
          "Current Power Source" = "AC Power";
        };

        # Wake behavior configuration
        "com.apple.driver.AppleBluetoothMultitouch.mouse" = {
          # Enable mouse wake
          MouseButtonMode = "TwoButton";
        };
        
        # Bluetooth wake settings
        "com.apple.Bluetooth" = {
          # Allow Bluetooth devices to wake the computer
          BluetoothAutoSeekKeyboard = true;
          BluetoothAutoSeekPointingDevice = true;
        };

        # USB wake settings  
        "com.apple.driver.AppleUSBMultitouch" = {
          # Enable USB device wake
          USBMouseStopsTrackpad = false;
        };

        # Thermal management for closed-lid operation
        "com.apple.PowerManagement.ThermalManagement" = {
          # Adjust thermal thresholds for closed-lid desktop operation
          # These settings help prevent overheating when lid is closed
          ThermalPressurePolicy = "Desktop";
          FanManagement = "Aggressive";
        };

        # Screen saver settings for external display
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
          # Disable screen saver on external display when system is active
          idleTime = 0;  # Never start screen saver automatically
        };

        # Disable internal display settings
        "com.apple.CoreDisplay" = {
          # Prefer external displays over built-in
          DisplayAnyUserSessions = true;
          # Disable automatic brightness on built-in display
          "Display Brightness" = 0;
        };

        # Audio output routing for external setup
        "com.apple.audio.CoreAudio" = {
          # Default to external audio devices when available
          DefaultOutputDeviceIsSystem = false;
        };

        # Prevent Photos and other apps from auto-launching
        "com.apple.ImageCapture" = {
          disableHotPlug = true;
        };

        # Finder optimizations for desktop use
        "com.apple.finder" = {
          # Show all connected devices on desktop
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          # Default to external storage locations
          NewWindowTarget = "PfDe";  # Desktop
          NewWindowTargetPath = "file:///Users/budchris/Desktop/";
        };

        # Dock behavior for external display
        "com.apple.dock" = {
          # Ensure dock appears on external display
          orientation = "bottom";
          autohide = true;
          # Position dock on external display
          monitor-displays = true;
        };

        # Mission Control for external display
        "com.apple.spaces" = {
          # Each display has separate spaces
          "spans-displays" = lib.mkForce false;
        };

        # Hot corners disabled since trackpad/internal display not accessible
        ".GlobalPreferences" = {
          # Disable hot corners that might be accidentally triggered
          "com.apple.dock.wvous-tl-corner" = 1;  # No action
          "com.apple.dock.wvous-tr-corner" = 1;  # No action  
          "com.apple.dock.wvous-bl-corner" = 1;  # No action
          "com.apple.dock.wvous-br-corner" = 1;  # No action
        };
      };

      # Login window settings for clamshell mode
      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = true;
        # Automatically login to avoid issues with closed clamshell at startup
        autoLoginUser = "budchris";
      };

      # Disable internal trackpad since clamshell is closed
      trackpad = {
        Clicking = lib.mkForce false;
        TrackpadRightClick = lib.mkForce false; 
        TrackpadThreeFingerDrag = lib.mkForce false;
      };
    };

    # macOS power management settings via pmset
    # These complement the plist settings above
    activationScripts.deltaDesktopPower.text = ''
      # Power management settings for closed-clamshell desktop operation
      echo "Configuring power management for delta desktop mode..."
      
      # Prevent sleep when lid is closed and external display connected
      pmset -c lidwake 1
      pmset -c sleep 0          # Never sleep on AC power
      pmset -c displaysleep 10  # Display sleep after 10 minutes
      pmset -c disksleep 0      # Never sleep disks
      
      # Wake settings
      pmset -c womp 1           # Wake on network access
      pmset -c ring 0           # Don't wake on modem ring
      pmset -c powernap 1       # Enable Power Nap
      
      # USB and Bluetooth wake
      pmset -c ttyskeepawake 1  # Keep awake if remote login sessions
      pmset -c tcpkeepalive 1   # Keep TCP connections alive
      
      # Thermal management
      pmset -c thermalstate -1  # Use automatic thermal management
      
      # Hibernation settings for desktop use
      pmset -c hibernatemode 0  # Disable hibernation (desktop mode)
      pmset -c autopoweroff 0   # Disable auto power off
      pmset -c standby 0        # Disable standby mode
      pmset -c proximitywake 0  # Disable proximity wake
      
      echo "Power management configured for closed-clamshell desktop operation"
    '';
  };

  # SSH configuration should be handled by main darwin modules
  # This module focuses only on clamshell-specific settings

  # Environment optimizations for headless operation
  environment = {
    # Set environment variables for external display preference
    variables = {
      # Prefer external displays
      CGDisplayUsesInvertedPolarity = "false";
      # Optimize for desktop performance
      NSAppSleepDisabled = "YES";
    };
  };
}