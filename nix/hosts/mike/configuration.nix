# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../modules/nixos/base.nix
    ./../../modules/nixos/plasma.nix
    ./../../modules/nixos/pipewire.nix
    ./../../modules/nixos/bluetooth.nix
    ./../../modules/nixos/avahi.nix
    ./../../modules/nixos/docker.nix
    ./../../modules/nixos/tailscale.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mike"; # Define your hostname.

  system.stateVersion = "25.05"; # Did you read the comment?
}
