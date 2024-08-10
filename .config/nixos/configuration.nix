# ./configuration.nix
{ config, pkgs, lib, ... }: {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "the contents of ~/.ssh/id_rsa.pub go here"
    ];
  };

  # You should always have some swap space,
  # This is even more important on VPSs
  # The swapfile will be created automatically.
  swapDevices = [{
    device = "/swap/swapfile";
    size = 1024 * 2; # 2 GB
  }];

  system.stateVersion = "24.05"; # Never change this
}
