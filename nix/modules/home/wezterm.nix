{ ... }: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        -- General settings
        font = wezterm.font 'JetBrainsMono Nerd Font',  -- Feel free to change the font
        font_size = 12.0,

        -- Disable the tab bar
        enable_tab_bar = false,

        -- Window padding
        window_padding = {
          left = 1,
          right = 1,
          top = 1,
          bottom = 1,
        },

        -- Color scheme
        color_scheme = 'Catppuccin Mocha',  -- Or choose another theme that you like

        -- Background opacity
        window_background_opacity = 0.95,

        -- Scrollback
        scrollback_lines = 3500,

        -- Disable ligatures if preferred
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

        -- Key bindings, if you want to add custom shortcuts
        keys = {
          -- Example: Close the window with Ctrl+Shift+W
          {key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentPane={confirm=true}}},
        }
      }
    '';
  };
}
