{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];
  programs = {
    hyprpanel = {
      enable = true;
      hyprland.enable = true;
      overwrite.enable = true;
      overlay.enable = true;
      settings = {
        layout = {
          "bar.layouts" = {
            "*" = {
              left = [
                "dashboard"
                "workspaces"
                "windowtitle"
                "cava"
              ];

              middle = [
                "media"
              ];

              right = [
                "systray"
                "kbinput"
                "volume"
                "clock"
                "notifications"
                "power"
              ];
            };
          };
        };

        scalingPriority = "hyprland";

        terminal = "ghostty";

        bar = {
          autoHide = "never";

          battery = {
            label = false;
          };

          clock = {
            format = "%a %b %d %H:%M";
          };

          customModules = {
            microphone = {
              label = true;
            };

            cava = {
              icon = "";
              showIcon = false;
              autoSensitivity = true;
            };

            weather = {
              unit = "metric";
            };
          };
        };

        menus = {
          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };

            weather = {
              unit = "metric";
              location = "Samara";
              interval = 600;
              key = "fe80b66d0ca342bba9793644252603";
            };
          };

          media = {
            displayTime = false;
            displayTimeTooltip = false;
          };

          dashboard = {
            controls = {
              enabled = true;
            };

            shortcuts = {
              enabled = true;
              left = {
                shortcut1 = {
                  command = "cromite";
                  icon = "";
                  tooltip = "Cromite";
                };
                shortcut2 = {
                  command = "spotify";
                  icon = "";
                  tooltip = "Spotify";
                };
                shortcut3 = {
                  command = "vesktop";
                  icon = "";
                  tooltip = "Discord";
                };
                shortcut4 = {
                  command = "ayugram-desktop";
                  icon = "";
                  tooltip = "Telegram";
                };
              };
              right = {
                shortcut1 = {
                  command = "wofi --show drun";
                  icon = "";
                  tooltip = "Search";
                };
                shortcut3 = {
                  command = "sleep 2; grimblast -c -n copysave screen ~/screens/screen-$(date +%s).png";
                  icon = "󰄀";
                  tooltip = "Screenshot";
                };
              };
            };
            directories = {
              enabled = false;
            };

            powermenu = {
              avatar = {
                image = "../../attachments/dots/hyprlandarch/wallpapers/ava.png";
              };
            };
          };
        };

        theme = {
          name = "gruvbox_vivid";
          font = {
            name = "Hack Font Nerd Regular";
          };

          bar = {
            location = "top";
            layer = "top";
            enableShadow = false;
            floating = false;
            margin_sides = "0.5em";
            margin_top = "0.5em";
          };

          osd = {
            enable = true;
          };
        };

        wallpaper = {
          enable = false;
          pywal = false;
          image = "";
        };
      };
    };
  };
}
