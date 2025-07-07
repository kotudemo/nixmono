{
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;

        settings = {
          monitor = ",1920x1080@143.98Hz,1920x0,1";
          "$mainMod" = "SUPER";
          "$terminal" = "ghostty";
          "$calc" = "kcalc";
          "$browser" = "chromium";
          "$fileManager" = "nemo";

          exec-once = [
            "systemctl --user start hypridle.service"
            "systemctl --user start hyprpolkitagent.service"
            "hyprctl setcursor Bibata-Modern-Ice 24"
            "wl-clip-persist --clipboard both"
            "wl-paste --watch cliphist store"
            "wlsunset -l 53.1 -L 50.0 -t 4500 -T 5000"
          ];

          input = {
            kb_layout = "us,ru";
            kb_options = "grp:alt_shift_toggle";
            follow_mouse = "1";
            sensitivity = "0";

            touchpad = {
              natural_scroll = false;
            };
          };

          general = {
            border_size = "2";
            gaps_in = "2";
            gaps_out = "4";
            layout = "dwindle";
          };

          decoration = {
            rounding = "2";

            blur = {
              enabled = true;
              size = "7";
              passes = "2";
              popups = true;
              special = true;
              ignore_opacity = true;
              xray = true;
              new_optimizations = true;
            };

            dim_inactive = true;
            dim_strength = "0.04";
          };

          cursor = {
            no_warps = true;
            no_hardware_cursors = true;
            enable_hyprcursor = true;
            inactive_timeout = "10";
            hide_on_key_press = true;
            hide_on_touch = true;
          };

          animations = {
            enabled = true;
            first_launch_animation = false;
            bezier = [
              "fluent_decel, 0, 0.2, 0.4, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutCubic, 0.33, 1, 0.68, 1"
              "fade_curve, 0, 0.55, 0.45, 1"
            ];
            animation = [
              "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
              "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
              "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

              # Fade
              "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
              "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
              "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
              "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
              "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
              # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
              # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
              "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
            ];
          };

          dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = false; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true;
            smart_split = "no";
            special_scale_factor = "0.92";
            force_split = "2";
          };

          master = {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_status = "master";
            mfact = "0.62";
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = "3";
            workspace_swipe_invert = false;
            workspace_swipe_distance = "200";
          };

          misc = {
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
            enable_swallow = true;
            render_ahead_of_time = false;
            disable_hyprland_logo = true;
          };

          render = {
            explicit_sync = "2";
            explicit_sync_kms = "2";
          };

          xwayland = {
            enabled = true;
            use_nearest_neighbor = true;
            force_zero_scaling = false;
          };

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

          windowrulev2 = [
            "float,center,size 1250 700,move 330 15%, class:^(swayimg)$"
            "float,size 650 400,move 785 625,class:^(pwvucontrol)$"
            "float,center,size 900 600,class:^(mpv)$"
            "float,center,size 1777 1111,class:^(nemo)$"
            "float,center,size 900 600,class:^(org.kde.ark)$"
            "float,center,size 500 600,class:^(org.kde.kcalc)$"
            "float,size 900 550,class:^(com.ayugram)$,title:^(Media viewer)$"

            "opacity 0.95 0.95,class:^(ghostty)$"

            "workspace 1 silent,class:^(dota2)$"
            "workspace 1 silent,class:^(starrail.exe)$"

            "bordersize 0, floating:0, onworkspace:w[tv1]"
            "rounding 0, floating:0, onworkspace:w[tv1]"
            "bordersize 0, floating:0, onworkspace:f[1]"
            "rounding 0, floating:0, onworkspace:f[1]"

            "suppressevent maximize, class:.*"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

            "opacity 0.0 override, class:^(xwaylandvideobridge)$"
            "noanim, class:^(xwaylandvideobridge)$"
            "noinitialfocus, class:^(xwaylandvideobridge)$"
            "maxsize 1 1, class:^(xwaylandvideobridge)$"
            "noblur, class:^(xwaylandvideobridge)$"
            "nofocus, class:^(xwaylandvideobridge)$"
          ];

          workspace = [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];

          bind = [
            "$mainMod, Return, exec, $terminal"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, G, exec, $calc"
            "$mainMod, F, exec, $browser"
            "$mainMod, period, exec, bemoji -cn"
            "$mainMod, O, exec, obs"
            "$mainMod, T, exec, ayugram-desktop"
            "$mainMod, C, exec, codium"
            "$mainMod, S, exec, flatpak run com.spotify.Client"
            "$mainMod, B, exec, discord"
            "$mainMod, D, exec, wofi --show drun"
            "$mainMod, L, exec, hyprlock"
            #"$mainMod, equal, exec, ${lib.getExe pkgs.woomer}"
            "SUPER_ALT, S, exec, ${lib.getExe pkgs.grimblast} -f -c copy screen"
            "SUPER_CTRL, S, exec, ${lib.getExe pkgs.grimblast} -f save area - | ${lib.getExe pkgs.swappy} -f -"
            "CTRL, Print, exec, ${lib.getExe pkgs.grimblast} -c copysave screen ~/screens/screen-$(date +%s).png"
            ", Print, exec, ${lib.getExe pkgs.grimblast} -f copysave area ~/screens/screen-$(date +%s).png"
            "SUPER_SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
            "SUPER_SHIFT, S, exec, ${lib.getExe pkgs.grimblast} -f copy area"
            "SUPER_SHIFT, T, exec, ${lib.getExe pkgs.grimblast} -f save area - | tesseract -l eng stdin stdout | wl-copy"
            "SUPER_SHIFT, R, exec, ${lib.getExe pkgs.grimblast} -f save area - | tesseract -l rus stdin stdout | wl-copy"
            "SUPER_SHIFT, C, exec, ${lib.getExe pkgs.hyprpicker} -a"
            "ALT, TAB, hyprexpo:expo, toggle"
            "$mainMod, TAB, overview:toggle"
            "SUPER_SHIFT, M, exit,"
            "$mainMod, Q, killactive,"
            "$mainMod, V, fullscreen,"
            "$mainMod, SPACE, togglefloating,"
            "$mainMod, J, togglesplit,"
            "SUPER_ALT, T, pin,"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
            "SUPER_SHIFT, left, swapwindow, l"
            "SUPER_SHIFT, right, swapwindow, r"
            "SUPER_SHIFT, up, swapwindow, u"
            "SUPER_SHIFT, down, swapwindow, d"
            "SUPER_ALT, right, moveactive, 50 0"
            "SUPER_ALT, left, moveactive, -50 0"
            "SUPER_ALT, up, moveactive, 0 -50"
            "SUPER_ALT, down, moveactive, 0 50"
            "SUPER_CTRL, left, resizeactive, -60 0"
            "SUPER_CTRL, right, resizeactive, 60 0"
            "SUPER_CTRL, up, resizeactive, 0 -60"
            "SUPER_CTRL, down, resizeactive, 0 60"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
            "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
            "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
            "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
            "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
            "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
            "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
            "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
            "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
            "SUPER_SHIFT, 0, movetoworkspacesilent, 10"
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];
          plugin = {
            hyprexpo = {
              columns = 3;
              gap_size = 2;
            };
            dynamic-cursors = {
              enabled = true;
              mode = "strech";
              threshold = 2;
              stretch = {
                limit = 4000;
                function = "quadratic";
              };

              shake = {
                enabled = true;
                nearest = true;
                threshold = 10.0;
                effects = true;
              };

              hyprcursor = {
                enabled = true;
                nearest = true;
                fallback = "clientside";
              };
            };
          };
        };

        plugins = with pkgs.hyprlandPlugins; [
          hyprspace
          hyprexpo
          hypr-dynamic-cursors
          hyprwinwrap
          xtra-dispatchers
        ];
      };
    };
  };
  systemd.user = {
    services = {
      hyprpolkitagent = {
        Unit = {
          Description = "Hyprpolkitagent service.";
          WantedBy = "graphical-session.target";
        };

        Service = {
          ExecStart = "${lib.getExe pkgs.hyprpolkitagent}";
          Restart = "always";
          RestartSec = 10;
        };

        Install = {
          After = "graphical-session.target";
          ConditionEnvironment = "WAYLAND_DISPLAY";
          PartOf = "graphical-session.target";
        };
      };
    };
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
          after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "${lib.getExe pkgs.brightnessctl} -s set 10";
            on-resume = "${lib.getExe pkgs.brightnessctl} -r";
          }

          {
            timeout = 600;
            on-timeout = "${lib.getExe pkgs.hyprlock}";
          }

          {
            timeout = 900;
            on-timeout = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
          }
        ];
      };
    };
  };

  programs = {
    hyprlock = {
      enable = true;

      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
          no_fade_in = false;
          disable_loading_bar = true;
          fractional_scaling = 0;
        };

        background = lib.mkForce [
          {
            monitor = "";
            blur_passes = 2;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        shape = [
          # User box
          {
            monitor = "";
            size = "300, 50";
            color = "rgba(102, 92, 84, 0.33)";
            rounding = 10;
            border_color = "rgba(255, 255, 255, 0)";
            position = "0, 270";
            halign = "center";
            valign = "bottom";
          }
        ];

        label = [
          # Time
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +'%k:%M')"'';
            color = "rgba(235, 219, 178, 0.9)";
            font_size = 115;
            font_family = "Hack Nerd Font";
            shadow_passes = 3;
            position = "0, -150";
            halign = "center";
            valign = "top";
          }
          # Date
          {
            monitor = "";
            text = ''cmd[update:1000] echo "- $(date +'%A, %B %d') -" '';
            color = "rgba(235, 219, 178, 0.9)";
            font_size = 18;
            font_family = "Hack Nerd Font";
            shadow_passes = 3;
            position = "0, -350";
            halign = "center";
            valign = "top";
          }
          # Username
          {
            monitor = "";
            text = "  $USER";
            color = "rgba(235, 219, 178, 1)";
            font_size = 15;
            font_family = "Hack Nerd Font";
            position = "0, 281";
            halign = "center";
            valign = "bottom";
          }
        ];
      };
    };
  };
}
