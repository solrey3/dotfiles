# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };
  services.displayManager.defaultSession = "xfce";
  security.pam.services.lightdm.enableGnomeKeyring = true;

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "budchris";

  # RDP
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "i3";
  services.xrdp.openFirewall = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  users.users.budchris = {
    packages = with pkgs; [
      pavucontrol
      pasystray
      barrier
      screen
      pass
      gnome-keyring
      pinentry-all
      tigervnc

    ];
  };


}
