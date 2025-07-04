{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        settings = {
          monitor = "HDMI-A-1,1920x1080@143.98Hz,1920x0,1";
          "$mainMod" = "SUPER";
          "$terminal" = "ghostty";
          "$calc" = "kcalc";
          "$browser" = "chromium";
          "$fileManager" = "nemo";
          "$key" = "tab";

          exec-once = [
            "systemctl --user start hypridle.service"
            "systemctl --user start hyprpolkitagent.service"
            "hyprctl setcursor GoogleDot-Black 24"
            "export QT_DISABLE_WINDOWDECORATION=1"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "wlsunset -l 53.1 -L 50.0 -t 4500 -T 5000"
            "[workspace 2 silent] $browser"
            "[workspace 3 silent] discord"
            "[workspace 4 silent] ayugram-desktop"
            "[workspace 4 silent] spotify"
          ];

          env = [
            #"env = XDG_CURRENT_DESKTOP,Hyprland"
            #"env = XDG_SESSION_TYPE,wayland"
            #"env = XDG_SESSION_DESKTOP,Hyprland"
            #"env = XCURSOR_SIZE,8"
            #"env = QT_QPA_PLATFORM,wayland"
            #"env = XDG_SCREENSHOTS_DIR,~/screens"
            #"env = ELECTRON_OZONE_PLATFORM_HINT,auto"
            #"env = QT_QPA_PLATFORMTHEME=qt6ct"
            # env = MOZ_ENABLE_WAYLAND,0
            # Nvidima
            #"env = LIBVA_DRIVER_NAME,nvidia"
            #"env = __GLX_VENDOR_LIBRARY_NAME,nvidia"
            #"env = NVD_BACKEND,direct"
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
              "myBezier, 0.05, 0.7, 0.1, 1.0"
              "myBezier1, 0.05, 0.8, 0.1, 1.0"
              "myBezier2, 0.05, 0.92, 0.1, 1.0"
            ];
            animation = [
              "windows, 1, 9, myBezier2, popin"
              "windowsOut, 1, 7, myBezier2, popin 80%"
              "border, 1, 10, default"
              "borderangle, 0, 8, myBezier1"
              "fade, 1, 7, myBezier1"
              "workspaces, 1, 8, myBezier, slide"
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
            "float,center,size 950 700,class:^(nemo)$"
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
            "$mainMod, S, exec, spotify"
            "$mainMod, B, exec, discord"
            "$mainMod, D, exec, wofi --show drun"
            "$mainMod, L, exec, hyprlock"
            "SUPER_ALT, S, exec, ${lib.getExe pkgs.grimblast} -f -c copy screen"
            "SUPER_CTRL, S, exec, ${lib.getExe pkgs.grimblast} -f save area - | ${lib.getExe pkgs.swappy} -f -"
            "CTRL, Print, exec, ${lib.getExe pkgs.grimblast} -c copysave screen ~/screens/screen-$(date +%s).png"
            ", Print, exec, ${lib.getExe pkgs.grimblast} -f copysave area ~/screens/screen-$(date +%s).png"
            "SUPER_SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
            "SUPER_SHIFT, S, exec, ${lib.getExe pkgs.grimblast} -f copy area"
            "SUPER_SHIFT, T, exec, ${lib.getExe pkgs.grimblast} -f save area - | tesseract -l eng stdin stdout | wl-copy"
            "SUPER_SHIFT, R, exec, ${lib.getExe pkgs.grimblast} -f save area - | tesseract -l rus stdin stdout | wl-copy"
            "SUPER_SHIFT, C, exec, ${lib.getExe pkgs.hyprpicker} -a"
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
          # bindl = [
          #   ", XF86AudioRaiseVolume, exec, pamixer -i 5"
          #   ", XF86AudioLowerVolume, exec, pamixer -d 5"
          #   ", XF86AudioMute, exec, pamixer -t"
          #   ", XF86AudioMicMute, exec, pamixer --default-source -m"
          # ];
          bindel = [
            ", XF86AudioRaiseVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ];

          bindl = [
            ", XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
            ", XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
            ", XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
            ", XF86AudioMute, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];
        };
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
        };

        label = [
          {
            monitor = "";
            text = "$TIME";
            text_align = "center";
            color = config.lib.stylix.colors.base01;
            font_size = 48;
            font_family = "Nerd Hack Font";
            rotate = 0;

            position = "0, 50";
            halign = "center";
            valign = "center";

            shadow_passes = 1;
            shadow_size = 2;
            shadow_color = "rgb(40, 40, 40)";
            shadow_boost = 2;
          }

          {
            monitor = "";
            text = "> $LAYOUT[en,ru]";
            text_align = "center";
            color = config.lib.stylix.colors.base06;
            font_size = 26;
            font_family = "Nerd Hack Font";
            rotate = 0;

            position = "200, -50";
            halign = "center";
            valign = "center";

            shadow_passes = 1;
            shadow_size = 2;
            shadow_color = "rgb(40, 40, 40)";
            shadow_boost = 2;
          }
        ];

        input-field = lib.mkForce [
          {
            monitor = "";
            size = "250, 50";
            outline_thickness = 2;
            dots_size = 0.35;
            dots_spacing = 0.5;
            dots_center = true;
            dots_rounding = -2;

            fade_on_empty = false;
            fade_timeout = 0;
            placeholder_text = " ";
            hide_input = false;
            rounding = -0.3;

            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_transition = 1000;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            swap_font_color = false;

            position = "0, -50";
            halign = "center";
            valign = "center";

            shadow_passes = 1;
            shadow_size = 5;
            shadow_boost = 1;
          }
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
      hyprpanel = {
        Unit = {
          Description = "Hyprpanel service.";
          WantedBy = "graphical-session.target";
        };

        Service = {
          ExecStart = "${lib.getExe pkgs.hyprpanel}";
          Restart = "always";
          RestartSec = 1;
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
}
