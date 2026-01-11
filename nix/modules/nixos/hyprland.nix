{ config, pkgs, ... }:

{

  # Enable Hyprland as the window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  # Enable Xwayland support for X11 applications
  };

  # Set environment variables for better Wayland and Hyprland performance and compatibility
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";           # Fix for invisible cursor issue
    NIXOS_OZONE_WL = "1";                    # Hint to use Wayland for certain applications
    XDG_CURRENT_DESKTOP = "Hyprland";        # Set the desktop environment name
    MOZ_ENABLE_WAYLAND = "1";                # Enable Wayland support for Firefox
    QT_QPA_PLATFORM = "wayland";             # Use Wayland for Qt applications
    _JAVA_AWT_WM_NONREPARENTING = "1";       # Improve Java app compatibility with Wayland
  };

  # Essential packages for Hyprland and Wayland environment
  environment.systemPackages = with pkgs; [

    # Wayland and Hyprland-related packages
    hyprland                         # Compositor and window manager for Wayland
    hyprpaper                        # Wallpaper manager for Hyprland
    hyprlock                         # Screen locker for Hyprland
    hyprshot                         # Screenshot tool for Hyprland
    wayland-utils                    # Wayland utilities
    wlroots                          # Modular Wayland compositor library
    # qt5-wayland                      # Qt5 platform plugin for Wayland
    # qt6-wayland                      # Qt6 platform plugin for Wayland

    # Status bar and notifications
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))                               # Highly customizable status bar for Wayland
    dunst                             # Lightweight notification daemon

    # Terminal emulators
    kitty                             # Fast, feature-rich, GPU-based terminal emulator
    alacritty                         # Another GPU-accelerated terminal emulator

    # File manager
    xfce.thunar                       # File manager providing a graphical interface for managing files

    # Application launchers
    rofi                              # Window switcher and application launcher for Wayland
    wofi                              # Simple application launcher and dmenu replacement for Wayland

    # Network management
    networkmanagerapplet              # GUI applet for managing network connections

    # Audio management
    pavucontrol                       # GTK-based volume control tool for PulseAudio
    pasystray                         # System tray icon for managing PulseAudio volume

    # Screen savers and lockers
    swaylock                          # Screen locker for Wayland
    swayidle                          # Idle management daemon for Wayland
    wlogout                           # Logout menu for Wayland

    # Clipboard utilities
    wl-clipboard                      # Command-line copy/paste utilities for Wayland

    # Authentication agents
    kdePackages.polkit-kde-agent-1    # Authentication agent for Polkit
    gnome-keyring               # GNOME keyring daemon
    pinentry-all                      # Collection of PIN or passphrase entry dialogs

    # Utilities
    meson                             # Build system used by some packages
    screen                            # Terminal multiplexer for managing multiple terminal sessions
    pass                              # Password manager

    # Other tools
    swww                              # Wallpaper daemon with support for animated wallpapers
    cmatrix                           # Console-based "Matrix" effect screensaver
    wayvnc                            # VNC server for Wayland

  ];

  # Enable XDG portals for better compatibility with Flatpak and sandboxed apps
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk       # XDG desktop portal for GTK applications
    pkgs.xdg-desktop-portal-hyprland  # XDG desktop portal for Hyprland
  ];

  # Configure SDDM as the display manager with Wayland support and set Hyprland as the default session
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  services.displayManager.defaultSession = "hyprland";

  # Enable hyprlock and hypridle for screen locking and idle management
  programs.hyprlock.enable = true;    # Enable hyprlock screen locker
  services.hypridle.enable = true;    # Enable hypridle idle management service

  # Optional configurations

  # Enable NVIDIA Prime Sync for better performance on hybrid graphics setups
  # hardware.nvidia.prime.sync.enable = true;

  # Use LightDM instead of SDDM as the display manager if preferred
  # services.xserver.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

}
