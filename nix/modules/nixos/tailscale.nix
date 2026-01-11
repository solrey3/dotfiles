# Tailscale VPN configuration

{ config, pkgs, ... }:

{
  # Enable Tailscale service
  services.tailscale.enable = true;

  # Open firewall port for Tailscale
  networking.firewall.allowedUDPPorts = [ 41641 ];

  # Allow traffic from Tailscale network
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
