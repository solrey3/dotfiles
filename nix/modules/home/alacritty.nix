{ ... }: {
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      font.normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      font.size = 10;
      env.TERM = "xterm-256color";
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window.padding = {
        x = 4;
        y = 4;
      };
      window.decorations = "Full";
      window.opacity = 0.8;
    };
  };
}
