# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable the OpenSSH daemon.
  # Enable SSH services
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.checkReversePath = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.budchris = {
    isNormalUser = true;
    description = "Buddha Christ";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "input" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtQcMtGB55jBNuxxvlKXfeYLhy0wsPtIVt2KorpgXhQ budchris@alpha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH46Qt9QJViVBCplguSvAKWdMfRgFIeqpabWNVXnWYY+ budchris@bravo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJyppyDxJZe9hQHLaD4rYi88SfTlEuieUiYbXgwwtr6C budchris@charlie"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNTDemhkFYx8kw6p096XBVp7H2gnONZLMX+4uDgwue/ budchris@delta"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlWwXAozSb4h6jPnhw34P0Niebj5LskgC3DVM76cbQY budchris@juliet"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdNJeN48PBRxNZL85RhQxTLLyDMVWwPf6RGqA4x5egf budchris@oscar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlvFs1iIYAJ4HAM5XZUC9pAhxrcq8Wu2NXH915lXOy8 budchris@ip13"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDx/89ut81frHKmW5LayOQox3FRhT2CHUnBTKgYKZrhVX/G1uXuBhhazE33zcWqX7MDDU+rOe5mWRS3yox8WlQzLO3nzCdfvAdChzyEzJNSP7GgwlM3MDT9AVZ/kSrgczGZDUaHJfjit1pz5y6ipnaMTrKkJo0hXng+bZWOGB1nDk0OBXNcGbfUSDV0N4SdDpqKeGsChWLHtQqF02a5luCpFvXGO3fGUCs3dxPtHv94WDeoBnc5uGtpWlVrUZixoEO8+PSWF6NxnlsrYzocAJLST76TiK0l9kqr1Xo+g3cSCEk7Bm0zpsTwDCu0/slyrPNYr1cKAF7jE4yT2YzF9Cut+ie5fnwOJ8VfCKFh+91SX8jRgvl4msp8sdlntjn0u0mHvYyBisqP4HyHdDDql+0tediiNDu5BGaWyHbq3bN1C2iL7C59uP6glxyQKlolJ1f0mN/MJU213geFP2ku4QADJRbydkZuRhwbdUcBdeSEW2T2P3BgHDThnXUGdJAHSsdFEQXNFBaJ2cTUZ+M89uBOP4JlJE2TNzusz3bDjuFOEFK65BGLmwSR7oBRPia/wT0R7Lq7r6wFcQdoGx5D9iBRpw1uUdKuzpuxJDqX806ICaItvyh/5RFilCGFsF7SWfWUp92kvHsT4xduBRvFrsbCbvZumiua3bkU36zn2Yl0w== ShellFish@iPad-29102025"
    ];
  };

  # make zsh default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   git
   fastfetch
   wget
   curl
   just
   wireguard-tools
   protonvpn-gui
  ];
  # Set the default editor to nvim
  environment.variables.EDITOR = "vim";

}
