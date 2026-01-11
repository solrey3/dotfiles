# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Avahi - Neeeded for my Macs to see my NixOS machines
  services.avahi = {
    enable = true;
    nssmdns4 = true;  # Enables NSS support for .local resolution
    publish = {
      enable = true;  # Publish hostname and services via mDNS
      addresses = true;  # Publish IPv4/IPv6 addresses
      # services = [ "ssh" ];  # Optionally, specify services to be published
    };
  };
  networking.firewall.allowedUDPPorts = [ 5353 ];

}
