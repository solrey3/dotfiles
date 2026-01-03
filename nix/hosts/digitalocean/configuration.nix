{ modulesPath, config, lib, pkgs, ... }: {

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "ubuntu2nixos";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtQcMtGB55jBNuxxvlKXfeYLhy0wsPtIVt2KorpgXhQ budchris@alpha"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFm804g6IUQO1ELH716hLjTBj3zzzbuOUbL3jCE7Gej8 budchris@bravo"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHDwRpWc0JaniB1yBdKNkS5srLkCE67y+sI4Sn+wL55L budchris@charlie"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNTDemhkFYx8kw6p096XBVp7H2gnONZLMX+4uDgwue/ budchris@delta"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlWwXAozSb4h6jPnhw34P0Niebj5LskgC3DVM76cbQY budchris@juliet"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.budchris = {
    isNormalUser = true;
    description = "Buddha Christ";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtQcMtGB55jBNuxxvlKXfeYLhy0wsPtIVt2KorpgXhQ budchris@alpha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFm804g6IUQO1ELH716hLjTBj3zzzbuOUbL3jCE7Gej8 budchris@bravo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHDwRpWc0JaniB1yBdKNkS5srLkCE67y+sI4Sn+wL55L budchris@charlie"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINNTDemhkFYx8kw6p096XBVp7H2gnONZLMX+4uDgwue/ budchris@delta"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlWwXAozSb4h6jPnhw34P0Niebj5LskgC3DVM76cbQY budchris@juliet"
    ];
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  swapDevices = [{
    device = "/swap/swapfile";
    size = 1024 * 2; # 2 GB
  }];

  system.stateVersion = "24.05";
}
