{...}: let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color_style = "#A89984";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  programs.waybar = {
    enable = true;
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
        border-top: 1px solid ${border_color_style};
      }

      tooltip {
        background: ${background_1};
        border: 1px solid ${border_color_style};
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
        border: 1px solid ${border_color_style};
        padding: 8px;
      }
      #tray menuitem {
        padding: 1px;
      }

      #pulseaudio, #network, #cpu, #memory, #disk, #battery, #language, #custom-notification {
        padding-left: 5px;
        padding-right: 5px;
        margin-right: 10px;
        color: ${text_color};
      }

      #pulseaudio, #language {
        margin-left: 15px;
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
      modules-center = ["clock"];
      modules-right = [
        "cpu"
        "memory"
        (
          if (host == "desktop")
          then "disk"
          else ""
        )
        "pulseaudio"
        "network"
        "battery"
        "hyprland/language"
        "custom/notification"
      ];
      clock = {
        calendar = {
          format = {
            today = "<span color='#98971A'><b>{}</b></span>";
          };
        };
        format = "  {:%H:%M}";
        tooltip = "true";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "  {:%d/%m}";
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
        format-muted = "<span foreground='${blue}'> </span> {volume}%";
        format-icons = {
          default = ["<span foreground='${blue}'> </span>"];
        };
        scroll-step = 2;
        on-click = "pamixer -t";
        on-click-right = "pavucontrol";
      };
      battery = {
        format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];
        format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
        format-full = "<span foreground='${yellow}'> </span>{capacity}%";
        format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
        interval = 5;
        states = {
          warning = 20;
        };
        format-time = "{H}h{M}m";
        tooltip = true;
        tooltip-format = "{time}";
      };
      "hyprland/language" = {
        format = "<span foreground='#FABD2F'> </span> {}";
        format-fr = "FR";
        format-en = "US";
      };
      "custom/launcher" = {
        format = "";
        on-click = "random-wallpaper";
        on-click-right = "rofi -show drun";
        tooltip = "true";
        tooltip-format = "Random Wallpaper";
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
  };
}
