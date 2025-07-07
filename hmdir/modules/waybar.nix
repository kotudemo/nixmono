{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = ["waybar"];
    };
  };
  xdg.configFile."waybar/config.jsonc".text = ''
          {
          "layer": "top",
          "position": "top",
          "mode": "dock",
          "exclusive": true,
          "passthrough": false,
          "gtk-layer-shell": true,
          "ipc": false,
          "reload_style_on_change": true,
          "height": 0,
          "modules-left": [
              "custom/weather",
              "hyprland/workspaces",
      		    "hyprland/window"
          ],
          "modules-center": [
              "cava",
              "custom/playerctl",
              "pulseaudio",
              "pulseaudio#microphone"
          ],
          "modules-right": [
              "keyboard-state",
              "tray",
              "hyprland/language",
              "clock",
              "custom/notification"
              "custom/power"
          ],
          "hyprland/window": {
              "format": "{}"
          },
            "custom/notification": {
      "tooltip": false,
      "format": "{icon} ",
      "format-icons": {
        "notification": "<span foreground='#CC241D'><sup></sup></span>  <span foreground='#CC241D'></span>",
        "none": "  <span foreground='#CC241D'></span>",
        "dnd-notification": "<span foreground='red'><sup></sup></span>  <span foreground='#CC241D'></span>",
        "dnd-none": "  <span foreground='#CC241D'></span>",
        "inhibited-notification": "<span foreground='red'><sup></sup></span>  <span foreground='#CC241D'></span>",
        "inhibited-none": "  <span foreground='#CC241D'></span>",
        "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>  <span foreground='#CC241D'></span>",
        "dnd-inhibited-none": "  <span foreground='#CC241D'></span>"
      },
      "return-type": "json",
      "exec-if": "which swaync-client",
      "exec": "swaync-client -swb",
      "on-click": "swaync-client -t -sw",
      "on-click-right": "swaync-client -d -sw",
      "escape": true
    },
          "hyprland/workspaces": {
              "disable-scroll": false,
              "all-outputs": true,
              "show-special": true,
              "on-scroll-up": "hyprctl dispatch workspace m-1",
              "on-scroll-down": "hyprctl dispatch workspace m+1",
              "on-click": "activate",
              "format": "{icon}",
              "format-icons": {
                    "1": "I",
                    "2": "II",
                    "3": "III",
                    "4": "IV",
                    "5": "v",
                    "6": "VI",
                    "7": "VII",
                    "8": "VIII",
                    "9": "IX",
                    "10": "X",
                    "urgent": "",
                    "default": "󰐗",
                    "magic": "󰓏",
              },
              "persistent-workspaces": {
                  "1": [],
                  "2": [],
                  "3": [],
                  "4": [],
                  "5": [],
                  "6": [],
                  "7": [],
                  "8": [],
                  "9": [],
                  "10": [],
              },
              "sort-by-number": true,
          },

          "hyprland/language": {
              "format": "{}",
              "format-en": "🇺🇸",
              "format-ru": "🇷🇺"
          },
          "keyboard-state": {
              "numlock": false,
              "scrolllock": false,
              "capslock": true,
              "format": "{icon}",
              "format-icons": {
                  "locked": "󰪛",
                  "unlocked": ""
              }
          },
          "idle_inhibitor": {
              "tooltip": false,
              "format": "{icon}",
              "start-activated": true,
              "format-icons": {
                  "activated": " ",
                  "deactivated": " "
              }
          },
          "custom/weather" : {
              "tooltip" : true,
              "format" : "{}",
              "interval" : 30,
              "exec" : "~/.config/waybar/scripts/waybar-wttr.py",
              "return-type" : "json"
          },
          "tray": {
              "icon-size": 11,
              "spacing": 8
          },
          "clock": {
              "timezone": "Europe/Samara",
              "format": "{:%H:%M  %a  %d.%m}",
              "tooltip-format": "<span font='RobotoMonoNerdFont'><tt><small>{calendar}</small></tt></span>",
              "calendar": {
                  "mode": "year",
                  "mode-mon-col": 3,
                  "format": {
                      "months":     "<span color='#504945'><b>{}</b></span>",
                      "days":       "<span color='#ebdbb2'><b>{}</b></span>",
                      "weeks":      "<span color='#928374'><b>W{}</b></span>",
                      "weekdays":   "<span color='#7c6f64'><b>{}</b></span>",
                      "today":      "<span color='#d79921'><b><u>{}</u></b></span>"
                  }
              }
          },
          "pulseaudio": {
              "format": "{icon}   {volume}%",
              "tooltip": false,
              "format-muted": " Muted",
              "on-click": "pamixer -t",
              "on-scroll-up": "pamixer -i 2",
              "on-scroll-down": "pamixer -d 2",
              "scroll-step": 3,
              "format-icons": {
                  "headphone": "",
                  "hands-free": "",
                  "headset": "",
                  "phone": "",
                  "portable": "",
                  "car": "",
                  "default": ["", "", ""]
              }
          },
      	"pulseaudio#microphone": {
              "format": "{format_source}",
              "format-source": " {volume}%",
              "tooltip": false,
              "format-source-muted": " Muted",
              "on-click": "pamixer --default-source -t",
              "on-scroll-up": "pamixer --default-source -i 2",
              "on-scroll-down": "pamixer --default-source -d 2",
              "scroll-step": 5
          },
          "custom/power": {
              "format": "",
              "tooltip": false,
              "on-click": "wlogout -b 5 --protocol layer-shell"
          },
          "custom/playerctl": {
              "format": "{icon}  <span>{}</span>",
              "return-type": "json",
              "exec": "playerctl -p spotify metadata -f '{\"text\": \"{{markup_escape(title)}} - {{markup_escape(artist)}}  {{ duration(position) }}/{{ duration(mpris:length) }}\", \"tooltip\": \"{{markup_escape(title)}} - {{markup_escape(artist)}}  {{ duration(position) }}/{{ duration(mpris:length) }}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F",
              "tooltip": false,
              "on-click-middle": "playerctl -p spotify previous",
              "on-click": "playerctl -p spotify play-pause",
              "on-click-right": "playerctl -p spotify next",
              "on-click-forward": "playerctl -p spotify position 10+",
              "on-click-backward": "playerctl -p spotify position 10-",
              "on-scroll-up": "playerctl -p spotify volume 0.02+",
              "on-scroll-down": "playerctl -p spotify volume 0.02-",
              "format-icons": {
                  "Paused": "",
                  "Playing": ""
              }
          },
          "cava": {
              "framerate": 40,
              "autosens": 0,
              "sensitivity": 38,
              "bars": 18,
              "lower_cutoff_freq": 50,
              "higher_cutoff_freq": 12000,
              "method": "pulse",
              "hide_on_silence": false,
              "sleep_timer": 5,
              "source": "auto",
              "stereo": false,
              "reverse": false,
              "bar_delimiter": 0,
              "monstercat": false,
              "waves": false,
              "noise_reduction": 0.77,
              "input_delay": 2,
              "format-icons" : ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" ],
              "actions": {
              "on-click-right": "mode"
              }
      	 }
      }
  '';
  home.packages = with pkgs; [
    wttrbar
  ];
  programs.waybar = {
    enable = true;
    style = ''
      * {
          border: none;
          font-family: JuliaMono;
          font-weight: 800;
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: none;
          margin: 0px;
          padding: 0px;
      }

      tooltip {
          background: rgba(40, 40, 40, 0.92);
          border-radius: 4px;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          color: #ebdbb2;
      }

      #workspaces button {
          border: none;
          transition-duration: 0.3s;
          background: none;
          box-shadow: inherit;
          text-shadow: inherit;
          color: #928374;
          padding: 3px;
          padding-left: 3px;
          padding-right: 3px;
      }

      #workspaces button.persistent {
          color: #928374;
      }

      #workspaces button.empty {
          color: #504945;
      }

      #workspaces button.special {
          color: #b8bb26;
      }

      #workspaces button.visible {
          color: #ebdbb2;
      }

      #workspaces button:hover {
          color: #d79921;
      }

      #workspaces button.active {
          color: #ebdbb2;
      }

      #workspaces button.urgent {
          color: #cc241d;
      }

      #language,
      #custom-weather,
      #window,
      #custom-playerctl,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #cava,
      #keyboard-state,
      #custom-notification,
      #custom-power {
          background: none;
          padding: 0px 10px;
          margin: 0px;
          margin-top: 5px;
          margin-bottom: 0px;
      }

      #tray {
          background: rgba(40, 40, 40, 0.92);
          border-radius: 4px;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          margin-right: 4px;
          margin-left: 4px;
          padding-right: 8px;
          padding-left: 9px;
          padding-top: 2px;
          color: #ebdbb2;
      }

      #workspaces {
          background: rgba(40, 40, 40, 0.92);
          border-radius: 4px;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          margin-left: 4px;
          padding-right: 6px;
          padding-left: 4px;
      }



      #language {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-right: 0px;
          border-radius: 4px 0px 0px 4px;
          min-width: 24px;
      }

      #keyboard-state {
          background: none;
          color: #ebdbb2;
          border: none;
          padding-top: 1px;
      }

      #window {
          background: rgba(40, 40, 40, 0.92);
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-radius: 4px;
          margin-left: 30px;
          margin-right: 30px;
          color: #ebdbb2;
      }

      #custom-playerctl {
          background: rgba(40, 40, 40, 0.92);
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-right: 0px;
          border-left: 0px;
          color: #ebdbb2;
      }

      #cava {
          background: rgba(40, 40, 40, 0.92);
          border-radius: 4px 0px 0px 4px;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-right: 0px;
          margin-left: 4px;
          color: #ebdbb2;
      }

      #clock {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-radius: 0px;
          border-right: 0px;
          border-left: 0px;
      }

      #network {
          color: #ebdbb2;
          border-left: 0px;
          border-right: 0px;
      }

      #pulseaudio {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-right: 0px;
          border-left: 0px;
          border-radius: 0px;
      }

      #pulseaudio.microphone {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-radius: 0px 4px 4px 0px;
          border-left: 0px;
          margin-right: 4px;
      }

      #battery {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-radius: 0px;
          border-right: 0px;
          border-left: 0px;
      }

      #custom-weather {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-radius: 4px;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          margin-left: 4px;
          padding-right: 7px;
          padding-top: 1px;
      }

      #idle_inhibitor {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-left: 0px;
          border-right: 0px;
          border-radius: 0px;
          min-width: 18px;
          margin-left: -4px;
          margin-right: -4px;
      }

      #custom-power {
          background: rgba(40, 40, 40, 0.92);
          color: #ebdbb2;
          border-width: 2px;
          border-style: solid;
          border-color: #ebdbb2;
          border-radius: 0px 4px 4px 0px;
          border-left: 0px;
          margin-left: 0px;
          margin-right: 4px;
          padding-right: 16px;
      }
    '';
  };
}
