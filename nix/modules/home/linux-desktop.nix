{ lib, config, pkgs, username, ... }:
{
  # Import sub-modules
  imports = [
    ./zsh.nix
    ./bash.nix
    ./git.nix
    ./core.nix
    ./starship.nix
    ./tmux.nix
    ./neovim.nix
    ./ghostty.nix
    ./wezterm.nix
    ./alacritty.nix
    ./linux-apps.nix
    ./i3.nix
    ./waybar.nix
    ./hyprland.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    # homeDirectory = if system == "x86_64-linux" || system == "aarch64-linux"
                    # then "/home/${username}"
                    # else "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";
  };

  # Basic Hyprland and Waybar configurations can be added here if needed
  # For now, removed dotfiles dependencies

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

}
