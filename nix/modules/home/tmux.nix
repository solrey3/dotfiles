{ config, lib, pkgs, ... }: {

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Tmux Configuration - Tokyo Night Theme (Omarchy)
      # Based on Tokyo Night colors from Omarchy theme system

      # ============================================================================
      # General Settings
      # ============================================================================

      # Set true color support
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Enable mouse support
      set -g mouse on

      # Set escape time to reduce delay
      set -sg escape-time 0

      # Start window and pane numbering at 1
      set -g base-index 1
      setw -g pane-base-index 1

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Set history limit
      set -g history-limit 50000

      # ============================================================================
      # Key Bindings
      # ============================================================================

      # Set prefix to Ctrl-a (more accessible than Ctrl-b)
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Reload config
      bind r source-file ~/.tmux.conf \; display "Config reloaded!"

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Pane navigation (vim-like)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Direct pane navigation with Ctrl+hjkl (no prefix needed)
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      # Pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Window navigation
      bind -n M-H previous-window
      bind -n M-L next-window

      # Enable vi mode
      setw -g mode-keys vi

      # ============================================================================
      # Tokyo Night Theme Colors (matching Omarchy)
      # ============================================================================

      # Color definitions from Tokyo Night theme
      BG_DARK="#1a1b26"
      BG_HIGHLIGHT="#292e42"
      BG_LIGHT="#16161e"
      FG="#c0caf5"
      FG_DARK="#545c7e"
      FG_GUTTER="#3b4261"
      BLUE="#7aa2f7"
      CYAN="#7dcfff"
      GREEN="#9ece6a"
      MAGENTA="#bb9af7"
      RED="#f7768e"
      YELLOW="#e0af68"
      ORANGE="#ff9e64"

      # ============================================================================
      # Status Bar Configuration
      # ============================================================================

      # Status bar position
      set -g status-position top

      # Status bar colors
      set -g status-bg "$BG_DARK"
      set -g status-fg "$FG"

      # Status bar format
      set -g status-interval 5
      set -g status-left-length 100
      set -g status-right-length 100

      # Left status (session name)
      set -g status-left "#[fg=$BG_LIGHT,bg=$BLUE,bold] #S #[fg=$BLUE,bg=$BG_DARK,nobold]"

      # Right status (time, date, system info)
      set -g status-right "#[fg=$FG_DARK,bg=$BG_DARK] #[fg=$CYAN,bg=$BG_DARK]#(whoami)@#h #[fg=$MAGENTA,bg=$BG_DARK]%H:%M #[fg=$GREEN,bg=$BG_DARK]%Y-%m-%d"

      # Window status format
      set -g window-status-format "#[fg=$FG_DARK,bg=$BG_DARK] #I #W "
      set -g window-status-current-format "#[fg=$BG_LIGHT,bg=$CYAN,bold] #I #W #[fg=$CYAN,bg=$BG_DARK,nobold]"

      # Window status separator
      set -g window-status-separator ""

      # ============================================================================
      # Pane Styling
      # ============================================================================

      # Pane borders
      set -g pane-border-style "fg=$BG_HIGHLIGHT"
      set -g pane-active-border-style "fg=$BLUE"

      # ============================================================================
      # Message Styling
      # ============================================================================

      # Message style (when showing commands)
      set -g message-style "bg=$YELLOW,fg=$BG_LIGHT"

      # Message command style (when in command mode)
      set -g message-command-style "bg=$GREEN,fg=$BG_LIGHT"

      # ============================================================================
      # Copy Mode Styling
      # ============================================================================

      # Copy mode colors
      set -g mode-style "bg=$BLUE,fg=$BG_LIGHT"

      # ============================================================================
      # Additional Settings
      # ============================================================================

      # Activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off

      # Window title
      set -g set-titles on
      set -g set-titles-string "#T - #W"

      # ============================================================================
      # Plugin Support (TPM ready)
      # ============================================================================

      # List of plugins (commented out - install TPM if you want to use plugins)
      # set -g @plugin 'tmux-plugins/tpm'
      # set -g @plugin 'tmux-plugins/tmux-sensible'
      # set -g @plugin 'tmux-plugins/tmux-resurrect'
      # set -g @plugin 'tmux-plugins/tmux-continuum'

      # Initialize TMUX plugin manager (keep this line at the very bottom)
      # run '~/.tmux/plugins/tpm/tpm'
    '';
  };

}

