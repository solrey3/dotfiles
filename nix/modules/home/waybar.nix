{ config, lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = lib.mkDefault {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 8;
        
        modules-left = [
          "hyprland/workspaces"
          "sway/mode"
          "sway/scratchpad"
          "custom/media"
        ];
        
        modules-center = [
          "sway/window"
        ];
        
        modules-right = [
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];

        # Hyprland workspaces configuration
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{name}";
          show-special = false;
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 ];
          };
        };

        # Other module configurations
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "sway/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = ["" ""];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% 󰕾";
          format-disconnected = "Disconnected 󰝚";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped 󰓛";
          unknown-tag = "N/A";
          interval = 5;
          consume-icons = {
            on = "󰆐 ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\">󰒝</span> ";
            on = "󰒞 ";
          };
          repeat-icons = {
            on = "󰑖 ";
          };
          single-icons = {
            on = "󰑘 ";
          };
          state-icons = {
            paused = "󰏤";
            playing = "󰐊";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M} 󰃰";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = "{usage}% 󰻠";
          tooltip = false;
        };

        memory = {
          format = "{}% 󰍛";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["󰜗" "󰔏" "󱃃"];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["󰃞" "󰃟" "󰃠" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓"];
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰚥";
          format-alt = "{time} {icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾"];
        };

        "battery#bat2" = {
          bat = "BAT2";
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "󰈐";
            performance = "󰓅";
            balanced = "󰾅";
            power-saver = "󰌪";
          };
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) 󰖩";
          format-ethernet = "{ipaddr}/{cidr} 󰈀";
          tooltip-format = "{ifname} via {gwaddr} 󰌘";
          format-linked = "{ifname} (No IP) 󰈁";
          format-disconnected = "Disconnected 󰖪";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          # Volume display and controls
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰖁 {icon} {format_source}";
          format-muted = "󰖁 {format_source}";
          format-source = "{volume}% 󰍬";
          format-source-muted = "󰍭";
          
          # Volume control actions
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          
          # Icons for different audio devices and states
          format-icons = {
            headphone = "󰋋";
            hands-free = "󱡏";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰦧";
            car = "󰄋";
            default = ["󰖁" "󰕾" "󰕿"];
          };
          
          # Tooltip information
          tooltip = true;
          tooltip-format = "Volume: {volume}%\nClick: Open mixer\nRight-click: Mute/Unmute\nScroll: Volume control";
        };

        "custom/media" = {
          format = "{icon} {text}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "󰓇";
            default = "󰝚";
          };
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
      };
    };

    style = lib.mkDefault ''
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", "JetBrainsMono NF";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(21, 21, 21, 0.8);
          color: #ffffff;
      }

      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #workspaces button {
          padding: 0 8px;
          margin: 0 2px;
          background: transparent;
          color: #565f89;
          border-radius: 0;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          background: #7aa2f7;
          color: #1a1b26;
      }

      #workspaces button:hover {
          background: rgba(122, 162, 247, 0.2);
          color: #c0caf5;
      }

      #workspaces button.urgent {
          background: #f7768e;
          color: #1a1b26;
      }

      #mode,
      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray,
      #idle_inhibitor,
      #mpd,
      #backlight,
      #power-profiles-daemon {
          padding: 0 12px;
          margin: 0 3px;
          background: rgba(26, 27, 38, 0.8);
          color: #c0caf5;
          border-radius: 0;
      }

      #window {
          padding: 0 10px;
          margin: 0 2px;
          background: transparent;
          color: #c0caf5;
          font-weight: normal;
      }

      #clock {
          background: rgba(122, 162, 247, 0.2);
          color: #7aa2f7;
          font-weight: bold;
      }

      #cpu {
          background: rgba(158, 206, 106, 0.2);
          color: #9ece6a;
      }

      #memory {
          background: rgba(187, 154, 247, 0.2);
          color: #bb9af7;
      }

      #temperature {
          background: rgba(255, 158, 100, 0.2);
          color: #ff9e64;
      }

      #temperature.critical {
          background: rgba(247, 118, 142, 0.3);
          color: #f7768e;
      }

      #network {
          background: rgba(125, 207, 255, 0.2);
          color: #7dcfff;
      }

      #network.disconnected {
          background: rgba(247, 118, 142, 0.2);
          color: #f7768e;
      }

      #pulseaudio {
          background: rgba(230, 192, 123, 0.2);
          color: #e6c07b;
      }

      #pulseaudio.muted {
          background: rgba(86, 95, 137, 0.2);
          color: #565f89;
      }

      #battery {
          background: rgba(158, 206, 106, 0.2);
          color: #9ece6a;
      }

      #battery.charging {
          background: rgba(125, 207, 255, 0.2);
          color: #7dcfff;
      }

      #battery.critical:not(.charging) {
          background: rgba(247, 118, 142, 0.3);
          color: #f7768e;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: rgba(247, 118, 142, 0.5);
          }
      }

      #idle_inhibitor {
          background: rgba(86, 95, 137, 0.2);
          color: #565f89;
      }

      #idle_inhibitor.activated {
          background: rgba(230, 192, 123, 0.2);
          color: #e6c07b;
      }

      #tray {
          background: rgba(26, 27, 38, 0.6);
          margin: 0 4px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: rgba(247, 118, 142, 0.3);
      }

      #mpd {
          background: rgba(158, 206, 106, 0.2);
          color: #9ece6a;
      }

      #mpd.disconnected {
          background: rgba(86, 95, 137, 0.2);
          color: #565f89;
      }

      #mpd.stopped {
          background: rgba(86, 95, 137, 0.2);
          color: #565f89;
      }

      #mpd.paused {
          background: rgba(230, 192, 123, 0.2);
          color: #e6c07b;
      }

      tooltip {
          border-radius: 0;
          background: rgba(26, 27, 38, 0.9);
          color: #c0caf5;
      }
    '';
  };
}
