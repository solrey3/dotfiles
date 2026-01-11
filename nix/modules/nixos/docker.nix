# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Enabling Docker
  virtualisation.docker.enable = true;
  ## Enable Docker rootless mode
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

}
