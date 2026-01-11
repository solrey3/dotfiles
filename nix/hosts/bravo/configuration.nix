# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/nixos/base.nix
      ./../../modules/nixos/nvidia-stable.nix
      # ./../../modules/nixos/plasma.nix
      # ./../../modules/nixos/xfce4.nix
      ./../../modules/nixos/hyprland.nix
      ./../../modules/nixos/bluetooth.nix
      ./../../modules/nixos/avahi.nix
      ./../../modules/nixos/jellyfin.nix
      ./../../modules/nixos/navidrome.nix
      ./../../modules/nixos/ollama.nix
      ./../../modules/nixos/steam.nix
      ./../../modules/nixos/tailscale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bravo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  fileSystems."/mnt/sata8tb" = {
    device = "/dev/disk/by-partuuid/45a1ac4d-c1fd-4754-ba0a-1b77a6990517";
    fsType = "ext4";
    options = [ "defaults" "rw" "user" ];
  };

  fileSystems."/mnt/files2" = {
    device = "/dev/disk/by-partuuid/564a218e-f527-47e2-924f-124f983bb9d2";
    fsType = "ntfs";
    options = [ "defaults" "rw" "user" ];
  };

  services.samba = {
    enable = true; # Enables the Samba service
    settings = {
      "SolReyDio" = {
        "path" = "/mnt/sata8tb/SolReyDio";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0777";
        "directory mask" = "0777";
      };
    };
  };
  # Samba file sharing ports
  networking.firewall.allowedTCPPorts = [ 137 138 139 445 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

  }
