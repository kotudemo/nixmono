{
  pkgs,
  self,
  ...
}: let
  custom = {
    font = "JetBrainsMono Nerd Font";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#e8cb94";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    aqua = "#8EC07C";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  home.packages = with pkgs; [
    wttrbar
    playerctl
  ];
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = ["waybar"];
    };
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = with custom; {
      position = "bottom";
      layer = "top";
      height = 28;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = [
        "custom/playerctl"
        "cava"
        "pulseaudio"
        "pulseaudio#microphone"

        
      ];
      modules-right = [
        "cpu"
        "memory"
        #"hyprland/language"
        "clock"
        "custom/notification"
      ];
      clock = {
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            "months" = "<span color='${aqua}'><b>{}</b></span>";
            "days" = "<span color='${border_color}'><b>{}</b></span>";
            "weeks" = "<span color='${blue}'><b>W{}</b></span>";
            #"weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
            "today" = "<span color='${green}'><b><u>{}</u></b></span>";
          };
        };
        format = "  {:%H:%M  %a  %d.%m}";
        tooltip = "true";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "I";
          "2" = "II";
          "3" = "III";
          "4" = "IV";
          "5" = "V";
          "6" = "VI";
          "7" = "VII";
          "8" = "VIII";
          "9" = "IX";
          "10" = "X";
          sort-by-number = true;
        };
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };
      "custom/playerctl" = {
        format = "{2} <span>{0}</span>";
        return-type = "json";
        exec = "playerctl -p spotify metadata -f '{\"text\": \"{{markup_escape(title)}} - {{markup_escape(artist)}}  {{ duration(position) }}/{{ duration(mpris:length) }}\", \"tooltip\": \"{{markup_escape(title)}} - {{markup_escape(artist)}}  {{ duration(position) }}/{{ duration(mpris:length) }}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        tooltip = false;
        on-click-middle = "playerctl -p spotify previous";
        on-click = "playerctl -p spotify play-pause";
        on-click-right = "playerctl -p spotify next";
        on-click-forward = "playerctl -p spotify position 10+";
        on-click-backward = "playerctl -p spotify position 10-";
        on-scroll-up = "playerctl -p spotify volume 0.02+";
        on-scroll-down = "playerctl -p spotify volume 0.02-";
        format-icons = {
          Paused = " ";
          Playing = " ";
        };
      };
      cava = {
        framerate = 40;
        autosens = 0;
        sensitivity = 38;
        bars = 18;
        lower_cutoff_freq = 50;
        higher_cutoff_freq = 12000;
        method = "pulse";
        hide_on_silence = false;
        sleep_timer = 5;
        source = "auto";
        stereo = false;
        reverse = false;
        bar_delimiter = 0;
        monstercat = false;
        waves = false;
        noise_reduction = 0.77;
        input_delay = 0;
        format-icons = [
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        actions = {
          on-click-right = "mode";
        };
      };
      cpu = {
        format = "<span foreground='${green}'> </span> {usage}%";
        format-alt = "<span foreground='${green}'> </span> {avg_frequency} GHz";
        interval = 2;
        on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
      };
      memory = {
        format = "<span foreground='${cyan}'>󰟜 </span>{}%";
        format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB"; # 
        interval = 2;
        on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
      };
      disk = {
        # path = "/";
        format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
        interval = 60;
        on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
      };
      network = {
        format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
        format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
        tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
      };
      tray = {
        icon-size = 20;
        spacing = 8;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        tooltip = false;
        format-muted = " Muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "pwvucontrol";
        on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+";
        on-scroll-down = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%-";
        scroll-step = 2;
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
      };
      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        tooltip = false;
        format-source-muted = " Muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        on-click-right = "pwvucontrol";
        on-scroll-up = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 2%+";
        on-scroll-down = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 2%-";
        scroll-step = 2;
      };

      "hyprland/language" = {
        #format = "<span foreground='#FABD2F'> </span> {}";
        format = "{}";
        format-en = "🇺🇸";
        format-ru = "🇷🇺";
      };
      "custom/launcher" = {
        format = "";
        on-click = "wofi --show drun";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} ";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
          none = "  <span foreground='${red}'></span>";
          dnd-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
          dnd-none = "  <span foreground='${red}'></span>";
          inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
          inhibited-none = "  <span foreground='${red}'></span>";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='${red}'></span>";
          dnd-inhibited-none = "  <span foreground='${red}'></span>";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
    style = with custom; ''
      * {
        border: none;
        border-radius: 0px;
        padding: 0;
        margin: 0;
        font-family: ${font};
        font-weight: ${font_weight};
        opacity: ${opacity};
        font-size: ${font_size};
      }

      window#waybar {
        background: #282828;
        border-top: 1px solid ${border_color};
      }

      tooltip {
        background: ${background_1};
        border: 1px solid ${border_color};
      }
      tooltip label {
        margin: 5px;
        color: ${text_color};
      }

      #workspaces {
        padding-left: 15px;
      }
      #workspaces button {
        color: ${yellow};
        padding-left:  5px;
        padding-right: 5px;
        margin-right: 10px;
      }
      #workspaces button.empty {
        color: ${text_color};
      }
      #workspaces button.active {
        color: ${orange_bright};
      }

      #clock {
        color: ${text_color};
      }

      #tray {
        margin-left: 10px;
        color: ${text_color};
      }
      #tray menu {
        background: ${background_1};
        border: 1px solid ${border_color};
        padding: 8px;
      }
      #tray menuitem {
        padding: 1px;
      }

      #pulseaudio.microphone, #pulseaudio, #network, #cpu, #memory, #disk, #language, #custom-playerctl, #cava, #custom-notification {
        padding-left: 5px;
        padding-right: 5px;
        margin-right: 10px;
        color: ${text_color};
      }



      #custom-notification {
        margin-left: 15px;
        padding-right: 2px;
        margin-right: 5px;
      }

      #custom-launcher {
        font-size: 20px;
        color: ${text_color};
        font-weight: bold;
        margin-left: 15px;
        padding-right: 10px;
      }
    '';
  };
}
