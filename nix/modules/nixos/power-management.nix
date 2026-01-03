{ config, pkgs, ... }:

{
  # Enable power management
  powerManagement.enable = true;

  # Install power management tools
  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];

  # Systemd logind settings for power management
  services.logind.settings.Login = {
    # Lid switch behavior
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "suspend";

    # Power key behavior
    HandlePowerKey = "suspend";
  };

  # UPower settings for battery monitoring and actions
  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "Hibernate";
  };

  # Enable keyboard wake from suspend/hibernate
  powerManagement.powerUpCommands = ''
    # Enable keyboard wakeup
    for i in /sys/bus/usb/devices/*/power/wakeup; do
      echo enabled > $i 2>/dev/null || true
    done
    for i in /sys/bus/pci/devices/*/power/wakeup; do
      echo enabled > $i 2>/dev/null || true
    done
  '';

  # Ensure USB keyboards can wake the system
  services.udev.extraRules = ''
    # Enable wakeup for all USB keyboards
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{bInterfaceClass}=="03", ATTRS{bInterfaceSubClass}=="01", ATTRS{bInterfaceProtocol}=="01", RUN+="${pkgs.bash}/bin/sh -c 'echo enabled > /sys$env{DEVPATH}/../power/wakeup'"
  '';

  # Hypridle configuration for Hyprland screen timeout and sleep
  # This handles:
  # - AC power: screen off after 30 min
  # - Battery: screen off after 10 min, sleep after 20 min
  # - Low battery: screen off after 1 min, immediate sleep
  home-manager.users.budchris = {
    home.enableNixpkgsReleaseCheck = false;

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
        };

        # AC Power: Screen off after 30 minutes
        listener = [
          {
            timeout = 1800; # 30 minutes
            on-timeout = "if cat /sys/class/power_supply/ADP1/online | grep -q 1; then hyprctl dispatch dpms off; fi";
            on-resume = "hyprctl dispatch dpms on";
          }

          # Battery: Screen off after 10 minutes
          {
            timeout = 600; # 10 minutes
            on-timeout = "if cat /sys/class/power_supply/ADP1/online | grep -q 0; then hyprctl dispatch dpms off; fi";
            on-resume = "hyprctl dispatch dpms on";
          }

          # Battery: Sleep after 20 minutes
          {
            timeout = 1200; # 20 minutes
            on-timeout = "if cat /sys/class/power_supply/ADP1/online | grep -q 0; then systemctl suspend; fi";
          }

          # Low battery: Screen off after 1 minute
          {
            timeout = 60; # 1 minute
            on-timeout = "if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 20 ]; then hyprctl dispatch dpms off; fi";
            on-resume = "hyprctl dispatch dpms on";
          }

          # Low battery: Suspend immediately if critical
          {
            timeout = 120; # 2 minutes (gives warning time)
            on-timeout = "if [ $(cat /sys/class/power_supply/BAT0/capacity) -le 20 ]; then systemctl suspend; fi";
          }
        ];
      };
    };
  };
}
