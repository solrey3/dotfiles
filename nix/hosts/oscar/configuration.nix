# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/nixos/base.nix
      ./../../modules/nixos/hyprland.nix
      ./../../modules/nixos/pipewire.nix
      ./../../modules/nixos/bluetooth.nix
      ./../../modules/nixos/avahi.nix
      ./../../modules/nixos/docker.nix
      ./../../modules/nixos/steam.nix
      ./../../modules/nixos/tailscale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "oscar"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Auto-login configuration
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "budchris";

  # Power management
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      # Battery care
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # USB autosuspend
      USB_AUTOSUSPEND = 1;

      # Display power management
      INTEL_GPU_MIN_FREQ_ON_AC = 300;
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_AC = 1200;
      INTEL_GPU_MAX_FREQ_ON_BAT = 800;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1200;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 800;

      # Runtime power management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # PCI device power management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # WiFi power saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
    };
  };

  # Suspend on lid close
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=suspend
      IdleActionSec=15min
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?


}
