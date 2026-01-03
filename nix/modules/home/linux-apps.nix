{ pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in

{
  home.packages = with pkgs; [

    nodejs
    yarn
    inputs.zen-browser.packages."${system}".default
    ## Remote Desktop Protocol
    freerdp
    remmina
    ## GUI Applications
    obsidian
    librewolf
    thunderbird
    pkgs-unstable._1password-gui
    pkgs-unstable.opencode
    pkgs-unstable.claude-code
    protonmail-bridge-gui
    quodlibet
    picard
    transmission_4-gtk
    wireshark
    nextcloud-client
    signal-desktop
    vlc
    #### linux64 only
    vscode

  ];
}
