{pkgs, inputs, cfgDir, ...}: {
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        settings = {
          monitor = "HDMI-A-3,1920x1080@144,0x0,1";
          "$mainMod" = "SUPER";
          "$terminal" = "ghostty";
          "$calc" = "kcalc";
          "$browser" = "chromium";
          "$fileManager" = "dolphin";
          "$key" = "tab";

          exec-once = [
            "systemctl --user start hypridle.service"
            "systemctl --user start hyprpolkitagent.service"
            "systemctl --user start hyprpanel.service"
            # "systemctl --user start hyprshell.service"
            #"hyprswitch init --show-title"
            "hyprctl setcursor GoogleDot-Black 24"
            "export QT_DISABLE_WINDOWDECORATION=1"
            "wl-paste --type text --watch cliphist store"
            "wl-paste --type image --watch cliphist store"
            "wlsunset -l 53.1 -L 50.0 -t 4500 -T 5000"
            # "[workspace 2 silent] firefox"
            # "[workspace 3 silent] telegram-desktop"
            # "[workspace 1 silent] vesktop"
            # "[workspace 4 silent] spotify"
          ];

          env = [
            "env = XDG_CURRENT_DESKTOP,Hyprland"
            "env = XDG_SESSION_TYPE,wayland"
            "env = XDG_SESSION_DESKTOP,Hyprland"
            "env = XCURSOR_SIZE,8"
            "env = QT_QPA_PLATFORM,wayland"
            #"env = QT_QPA_PLATFORMTHEME=qt6ct"
            "env = XDG_SCREENSHOTS_DIR,~/screens"
            "env = ELECTRON_OZONE_PLATFORM_HINT,auto"
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
            "float,center,size 950 700,class:^(org.kde.dolphin)$"
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
            "$mainMod, C, exec, vscode"
            "$mainMod, S, exec, spotify"
            "$mainMod, B, exec, vesktop"
            "$mainMod, D, exec, wofi --show drun"
            "$mainMod, L, exec, hyprlock"
            "SUPER_ALT, S, exec, grimblast -f -c copy screen"
            "SUPER_CTRL, S, exec, grimblast -f save area - | swappy -f -"
            "CTRL, Print, exec, grimblast -c copysave screen ~/screens/screen-$(date +%s).png"
            ", Print, exec, grimblast -f copysave area ~/screens/screen-$(date +%s).png"
            "SUPER_SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
            "SUPER_SHIFT, S, exec, grimblast -f copy area"
            "SUPER_SHIFT, T, exec, grimblast -f save area - | tesseract -l eng stdin stdout | wl-copy"
            "SUPER_SHIFT, R, exec, grimblast -f save area - | tesseract -l rus stdin stdout | wl-copy"
            "SUPER_SHIFT, C, exec, hyprpicker -a"
            "SUPER_SHIFT, M, exit,"
            #"ALT, $key, exec, hyprswitch gui --mod-key alt_l --key $key --close mod-key-release --reverse-key=key=$reverse --sort-recent && hyprswitch dispatch"
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

          bindl = [
            ", XF86AudioRaiseVolume, exec, pamixer -i 5"
            ", XF86AudioLowerVolume, exec, pamixer -d 5"
            ", XF86AudioMute, exec, pamixer -t"
            ", XF86AudioMicMute, exec, pamixer --default-source -m"
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
    hyprpanel = {
      enable = true;
      override = ''
                {
          "menus.clock.time.military": true,
          "theme.bar.menus.menu.notifications.scrollbar.color": "#83a598",
          "theme.bar.menus.menu.notifications.pager.label": "#a89984",
          "theme.bar.menus.menu.notifications.pager.button": "#83a598",
          "theme.bar.menus.menu.notifications.pager.background": "#282828",
          "theme.bar.menus.menu.notifications.switch.puck": "#504945",
          "theme.bar.menus.menu.notifications.switch.disabled": "#3c3836",
          "theme.bar.menus.menu.notifications.switch.enabled": "#83a598",
          "theme.bar.menus.menu.notifications.clear": "#83a598",
          "theme.bar.menus.menu.notifications.switch_divider": "#504945",
          "theme.bar.menus.menu.notifications.border": "#3c3836",
          "theme.bar.menus.menu.notifications.card": "#282828",
          "theme.bar.menus.menu.notifications.background": "#282828",
          "theme.bar.menus.menu.notifications.no_notifications_label": "#3c3836",
          "theme.bar.menus.menu.notifications.label": "#83a598",
          "theme.bar.menus.menu.power.buttons.sleep.icon": "#32302f",
          "theme.bar.menus.menu.power.buttons.sleep.text": "#83a598",
          "theme.bar.menus.menu.power.buttons.sleep.icon_background": "#83a598",
          "theme.bar.menus.menu.power.buttons.sleep.background": "#282828",
          "theme.bar.menus.menu.power.buttons.logout.icon": "#32302f",
          "theme.bar.menus.menu.power.buttons.logout.text": "#b8bb26",
          "theme.bar.menus.menu.power.buttons.logout.icon_background": "#b8bb26",
          "theme.bar.menus.menu.power.buttons.logout.background": "#282828",
          "theme.bar.menus.menu.power.buttons.restart.icon": "#32302f",
          "theme.bar.menus.menu.power.buttons.restart.text": "#fe8019",
          "theme.bar.menus.menu.power.buttons.restart.icon_background": "#fe8019",
          "theme.bar.menus.menu.power.buttons.restart.background": "#282828",
          "theme.bar.menus.menu.power.buttons.shutdown.icon": "#32302f",
          "theme.bar.menus.menu.power.buttons.shutdown.text": "#cc241d",
          "theme.bar.menus.menu.power.buttons.shutdown.icon_background": "#cc241d",
          "theme.bar.menus.menu.power.buttons.shutdown.background": "#282828",
          "theme.bar.menus.menu.power.border.color": "#3c3836",
          "theme.bar.menus.menu.power.background.color": "#282828",
          "theme.bar.menus.menu.dashboard.monitors.disk.label": "#d3869b",
          "theme.bar.menus.menu.dashboard.monitors.disk.bar": "#d3869b",
          "theme.bar.menus.menu.dashboard.monitors.disk.icon": "#d3869b",
          "theme.bar.menus.menu.dashboard.monitors.gpu.label": "#b8bb26",
          "theme.bar.menus.menu.dashboard.monitors.gpu.bar": "#b8bb26",
          "theme.bar.menus.menu.dashboard.monitors.gpu.icon": "#b8bb26",
          "theme.bar.menus.menu.dashboard.monitors.ram.label": "#fabd2f",
          "theme.bar.menus.menu.dashboard.monitors.ram.bar": "#fabd2f",
          "theme.bar.menus.menu.dashboard.monitors.ram.icon": "#fabd2f",
          "theme.bar.menus.menu.dashboard.monitors.cpu.label": "#fb4934",
          "theme.bar.menus.menu.dashboard.monitors.cpu.bar": "#fb4934",
          "theme.bar.menus.menu.dashboard.monitors.cpu.icon": "#fb4934",
          "theme.bar.menus.menu.dashboard.monitors.bar_background": "#504945",
          "theme.bar.menus.menu.dashboard.directories.right.bottom.color": "#83a598",
          "theme.bar.menus.menu.dashboard.directories.right.middle.color": "#b16286",
          "theme.bar.menus.menu.dashboard.directories.right.top.color": "#8ec07c",
          "theme.bar.menus.menu.dashboard.directories.left.bottom.color": "#fb4934",
          "theme.bar.menus.menu.dashboard.directories.left.middle.color": "#fabd2f",
          "theme.bar.menus.menu.dashboard.directories.left.top.color": "#d3869b",
          "theme.bar.menus.menu.dashboard.controls.input.text": "#32302f",
          "theme.bar.menus.menu.dashboard.controls.input.background": "#d3869b",
          "theme.bar.menus.menu.dashboard.controls.volume.text": "#32302f",
          "theme.bar.menus.menu.dashboard.controls.volume.background": "#fb4934",
          "theme.bar.menus.menu.dashboard.controls.notifications.text": "#32302f",
          "theme.bar.menus.menu.dashboard.controls.notifications.background": "#fabd2f",
          "theme.bar.menus.menu.dashboard.controls.bluetooth.text": "#32302f",
          "theme.bar.menus.menu.dashboard.controls.bluetooth.background": "#83a598",
          "theme.bar.menus.menu.dashboard.controls.wifi.text": "#32302f",
          "theme.bar.menus.menu.dashboard.controls.wifi.background": "#b16286",
          "theme.bar.menus.menu.dashboard.controls.disabled": "#665c54",
          "theme.bar.menus.menu.dashboard.shortcuts.recording": "#b8bb26",
          "theme.bar.menus.menu.dashboard.shortcuts.text": "#32302f",
          "theme.bar.menus.menu.dashboard.shortcuts.background": "#83a598",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text": "#282828",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.deny": "#d3869b",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm": "#8ec07b",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.body": "#ebdbb2",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.label": "#83a598",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.border": "#3c3836",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.background": "#282828",
          "theme.bar.menus.menu.dashboard.powermenu.confirmation.card": "#282828",
          "theme.bar.menus.menu.dashboard.powermenu.sleep": "#83a598",
          "theme.bar.menus.menu.dashboard.powermenu.logout": "#b8bb26",
          "theme.bar.menus.menu.dashboard.powermenu.restart": "#fe8019",
          "theme.bar.menus.menu.dashboard.powermenu.shutdown": "#cc241d",
          "theme.bar.menus.menu.dashboard.profile.name": "#d3869b",
          "theme.bar.menus.menu.dashboard.border.color": "#3c3836",
          "theme.bar.menus.menu.dashboard.background.color": "#282828",
          "theme.bar.menus.menu.dashboard.card.color": "#282828",
          "theme.bar.menus.menu.clock.weather.hourly.temperature": "#d3869b",
          "theme.bar.menus.menu.clock.weather.hourly.icon": "#d3869b",
          "theme.bar.menus.menu.clock.weather.hourly.time": "#d3869b",
          "theme.bar.menus.menu.clock.weather.thermometer.extremelycold": "#83a598",
          "theme.bar.menus.menu.clock.weather.thermometer.cold": "#458588",
          "theme.bar.menus.menu.clock.weather.thermometer.moderate": "#83a598",
          "theme.bar.menus.menu.clock.weather.thermometer.hot": "#fe8019",
          "theme.bar.menus.menu.clock.weather.thermometer.extremelyhot": "#cc241d",
          "theme.bar.menus.menu.clock.weather.stats": "#d3869b",
          "theme.bar.menus.menu.clock.weather.status": "#8ec07c",
          "theme.bar.menus.menu.clock.weather.temperature": "#ebdbb2",
          "theme.bar.menus.menu.clock.weather.icon": "#d3869b",
          "theme.bar.menus.menu.clock.calendar.contextdays": "#665c54",
          "theme.bar.menus.menu.clock.calendar.days": "#ebdbb2",
          "theme.bar.menus.menu.clock.calendar.currentday": "#d3869b",
          "theme.bar.menus.menu.clock.calendar.paginator": "#d3869b",
          "theme.bar.menus.menu.clock.calendar.weekdays": "#d3869b",
          "theme.bar.menus.menu.clock.calendar.yearmonth": "#8ec07c",
          "theme.bar.menus.menu.clock.time.timeperiod": "#8ec07c",
          "theme.bar.menus.menu.clock.time.time": "#d3869b",
          "theme.bar.menus.menu.clock.text": "#ebdbb2",
          "theme.bar.menus.menu.clock.border.color": "#3c3836",
          "theme.bar.menus.menu.clock.background.color": "#282828",
          "theme.bar.menus.menu.clock.card.color": "#282828",
          "theme.bar.menus.menu.battery.slider.puck": "#7c6f64",
          "theme.bar.menus.menu.battery.slider.backgroundhover": "#504945",
          "theme.bar.menus.menu.battery.slider.background": "#665c54",
          "theme.bar.menus.menu.battery.slider.primary": "#fabd2f",
          "theme.bar.menus.menu.battery.icons.active": "#fabd2f",
          "theme.bar.menus.menu.battery.icons.passive": "#a89984",
          "theme.bar.menus.menu.battery.listitems.active": "#fabd2f",
          "theme.bar.menus.menu.battery.listitems.passive": "#ebdbb2",
          "theme.bar.menus.menu.battery.text": "#ebdbb2",
          "theme.bar.menus.menu.battery.label.color": "#fabd2f",
          "theme.bar.menus.menu.battery.border.color": "#3c3836",
          "theme.bar.menus.menu.battery.background.color": "#282828",
          "theme.bar.menus.menu.battery.card.color": "#282828",
          "theme.bar.menus.menu.systray.dropdownmenu.divider": "#282828",
          "theme.bar.menus.menu.systray.dropdownmenu.text": "#ebdbb2",
          "theme.bar.menus.menu.systray.dropdownmenu.background": "#282828",
          "theme.bar.menus.menu.bluetooth.iconbutton.active": "#83a598",
          "theme.bar.menus.menu.bluetooth.iconbutton.passive": "#ebdbb2",
          "theme.bar.menus.menu.bluetooth.icons.active": "#83a598",
          "theme.bar.menus.menu.bluetooth.icons.passive": "#a89984",
          "theme.bar.menus.menu.bluetooth.listitems.active": "#83a598",
          "theme.bar.menus.menu.bluetooth.listitems.passive": "#ebdbb2",
          "theme.bar.menus.menu.bluetooth.switch.puck": "#504945",
          "theme.bar.menus.menu.bluetooth.switch.disabled": "#3c3836",
          "theme.bar.menus.menu.bluetooth.switch.enabled": "#83a598",
          "theme.bar.menus.menu.bluetooth.switch_divider": "#504945",
          "theme.bar.menus.menu.bluetooth.status": "#7c6f64",
          "theme.bar.menus.menu.bluetooth.text": "#ebdbb2",
          "theme.bar.menus.menu.bluetooth.label.color": "#83a598",
          "theme.bar.menus.menu.bluetooth.border.color": "#3c3836",
          "theme.bar.menus.menu.bluetooth.background.color": "#282828",
          "theme.bar.menus.menu.bluetooth.card.color": "#282828",
          "theme.bar.menus.menu.network.iconbuttons.active": "#b16286",
          "theme.bar.menus.menu.network.iconbuttons.passive": "#ebdbb2",
          "theme.bar.menus.menu.network.icons.active": "#b16286",
          "theme.bar.menus.menu.network.icons.passive": "#a89984",
          "theme.bar.menus.menu.network.listitems.active": "#b16286",
          "theme.bar.menus.menu.network.listitems.passive": "#ebdbb2",
          "theme.bar.menus.menu.network.status.color": "#7c6f64",
          "theme.bar.menus.menu.network.text": "#ebdbb2",
          "theme.bar.menus.menu.network.label.color": "#b16286",
          "theme.bar.menus.menu.network.border.color": "#3c3836",
          "theme.bar.menus.menu.network.background.color": "#282828",
          "theme.bar.menus.menu.network.card.color": "#282828",
          "theme.bar.menus.menu.volume.input_slider.puck": "#665c54",
          "theme.bar.menus.menu.volume.input_slider.backgroundhover": "#504945",
          "theme.bar.menus.menu.volume.input_slider.background": "#665c54",
          "theme.bar.menus.menu.volume.input_slider.primary": "#fe8018",
          "theme.bar.menus.menu.volume.audio_slider.puck": "#665c54",
          "theme.bar.menus.menu.volume.audio_slider.backgroundhover": "#504945",
          "theme.bar.menus.menu.volume.audio_slider.background": "#665c54",
          "theme.bar.menus.menu.volume.audio_slider.primary": "#fe8018",
          "theme.bar.menus.menu.volume.icons.active": "#fe8018",
          "theme.bar.menus.menu.volume.icons.passive": "#a89984",
          "theme.bar.menus.menu.volume.iconbutton.active": "#fe8018",
          "theme.bar.menus.menu.volume.iconbutton.passive": "#ebdbb2",
          "theme.bar.menus.menu.volume.listitems.active": "#fe8018",
          "theme.bar.menus.menu.volume.listitems.passive": "#ebdbb2",
          "theme.bar.menus.menu.volume.text": "#ebdbb2",
          "theme.bar.menus.menu.volume.label.color": "#fe8018",
          "theme.bar.menus.menu.volume.border.color": "#3c3836",
          "theme.bar.menus.menu.volume.background.color": "#282828",
          "theme.bar.menus.menu.volume.card.color": "#282828",
          "theme.bar.menus.menu.media.slider.puck": "#7c6f64",
          "theme.bar.menus.menu.media.slider.backgroundhover": "#504945",
          "theme.bar.menus.menu.media.slider.background": "#665c54",
          "theme.bar.menus.menu.media.slider.primary": "#d3869b",
          "theme.bar.menus.menu.media.buttons.text": "#282828",
          "theme.bar.menus.menu.media.buttons.background": "#83a598",
          "theme.bar.menus.menu.media.buttons.enabled": "#8ec07c",
          "theme.bar.menus.menu.media.buttons.inactive": "#665c54",
          "theme.bar.menus.menu.media.border.color": "#3c3836",
          "theme.bar.menus.menu.media.card.color": "#282828",
          "theme.bar.menus.menu.media.background.color": "#282828",
          "theme.bar.menus.menu.media.album": "#d3869b",
          "theme.bar.menus.menu.media.artist": "#8ec07c",
          "theme.bar.menus.menu.media.song": "#83a598",
          "theme.bar.menus.tooltip.text": "#ebdbb2",
          "theme.bar.menus.tooltip.background": "#282828",
          "theme.bar.menus.dropdownmenu.divider": "#282828",
          "theme.bar.menus.dropdownmenu.text": "#ebdbb2",
          "theme.bar.menus.dropdownmenu.background": "#282828",
          "theme.bar.menus.slider.puck": "#7c6f64",
          "theme.bar.menus.slider.backgroundhover": "#504945",
          "theme.bar.menus.slider.background": "#665c54",
          "theme.bar.menus.slider.primary": "#83a598",
          "theme.bar.menus.progressbar.background": "#504945",
          "theme.bar.menus.progressbar.foreground": "#83a598",
          "theme.bar.menus.iconbuttons.active": "#83a598",
          "theme.bar.menus.iconbuttons.passive": "#ebdbb2",
          "theme.bar.menus.buttons.text": "#32302f",
          "theme.bar.menus.buttons.disabled": "#665c54",
          "theme.bar.menus.buttons.active": "#d3869b",
          "theme.bar.menus.buttons.default": "#83a598",
          "theme.bar.menus.check_radio_button.active": "#83a598",
          "theme.bar.menus.check_radio_button.background": "#3c3836",
          "theme.bar.menus.switch.puck": "#504945",
          "theme.bar.menus.switch.disabled": "#3c3836",
          "theme.bar.menus.switch.enabled": "#83a598",
          "theme.bar.menus.icons.active": "#83a598",
          "theme.bar.menus.icons.passive": "#665c54",
          "theme.bar.menus.listitems.active": "#83a598",
          "theme.bar.menus.listitems.passive": "#ebdbb2",
          "theme.bar.menus.popover.border": "#32302f",
          "theme.bar.menus.popover.background": "#32302f",
          "theme.bar.menus.popover.text": "#83a598",
          "theme.bar.menus.label": "#83a598",
          "theme.bar.menus.feinttext": "#3c3836",
          "theme.bar.menus.dimtext": "#665c54",
          "theme.bar.menus.text": "#ebdbb2",
          "theme.bar.menus.border.color": "#3c3836",
          "theme.bar.menus.cards": "#282828",
          "theme.bar.menus.background": "#282828",
          "theme.bar.buttons.modules.power.icon_background": "#fb4934",
          "theme.bar.buttons.modules.power.icon": "#21252b",
          "theme.bar.buttons.modules.power.background": "#282828",
          "theme.bar.buttons.modules.weather.icon_background": "#fe8017",
          "theme.bar.buttons.modules.weather.icon": "#282828",
          "theme.bar.buttons.modules.weather.text": "#fe8017",
          "theme.bar.buttons.modules.weather.background": "#282828",
          "theme.bar.buttons.modules.updates.icon_background": "#b16286",
          "theme.bar.buttons.modules.updates.icon": "#21252b",
          "theme.bar.buttons.modules.updates.text": "#b16286",
          "theme.bar.buttons.modules.updates.background": "#282828",
          "theme.bar.buttons.modules.kbLayout.icon_background": "#83a598",
          "theme.bar.buttons.modules.kbLayout.icon": "#21252b",
          "theme.bar.buttons.modules.kbLayout.text": "#83a598",
          "theme.bar.buttons.modules.kbLayout.background": "#282828",
          "theme.bar.buttons.modules.netstat.icon_background": "#b8bb26",
          "theme.bar.buttons.modules.netstat.icon": "#21252b",
          "theme.bar.buttons.modules.netstat.text": "#b8bb26",
          "theme.bar.buttons.modules.netstat.background": "#282828",
          "theme.bar.buttons.modules.storage.icon_background": "#83a598",
          "theme.bar.buttons.modules.storage.icon": "#21252b",
          "theme.bar.buttons.modules.storage.text": "#83a598",
          "theme.bar.buttons.modules.storage.background": "#282828",
          "theme.bar.buttons.modules.cpu.icon_background": "#d3869b",
          "theme.bar.buttons.modules.cpu.icon": "#21252b",
          "theme.bar.buttons.modules.cpu.text": "#d3869b",
          "theme.bar.buttons.modules.cpu.background": "#282828",
          "theme.bar.buttons.modules.ram.icon_background": "#fabd2f",
          "theme.bar.buttons.modules.ram.icon": "#21252b",
          "theme.bar.buttons.modules.ram.text": "#fabd2f",
          "theme.bar.buttons.modules.ram.background": "#282828",
          "theme.bar.buttons.notifications.total": "#83a598",
          "theme.bar.buttons.notifications.icon_background": "#83a598",
          "theme.bar.buttons.notifications.icon": "#282828",
          "theme.bar.buttons.notifications.background": "#282828",
          "theme.bar.buttons.clock.icon_background": "#d3869b",
          "theme.bar.buttons.clock.icon": "#282828",
          "theme.bar.buttons.clock.text": "#d3869b",
          "theme.bar.buttons.clock.background": "#282828",
          "theme.bar.buttons.battery.icon_background": "#fabd2f",
          "theme.bar.buttons.battery.icon": "#282828",
          "theme.bar.buttons.battery.text": "#fabd2f",
          "theme.bar.buttons.battery.background": "#282828",
          "theme.bar.buttons.systray.background": "#282828",
          "theme.bar.buttons.bluetooth.icon_background": "#83a598",
          "theme.bar.buttons.bluetooth.icon": "#282828",
          "theme.bar.buttons.bluetooth.text": "#83a598",
          "theme.bar.buttons.bluetooth.background": "#282828",
          "theme.bar.buttons.network.icon_background": "#b16286",
          "theme.bar.buttons.network.icon": "#282828",
          "theme.bar.buttons.network.text": "#b16286",
          "theme.bar.buttons.network.background": "#282828",
          "theme.bar.buttons.volume.icon_background": "#fe8018",
          "theme.bar.buttons.volume.icon": "#282828",
          "theme.bar.buttons.volume.text": "#fe8018",
          "theme.bar.buttons.volume.background": "#282828",
          "theme.bar.buttons.media.icon_background": "#83a598",
          "theme.bar.buttons.media.icon": "#282828",
          "theme.bar.buttons.media.text": "#83a598",
          "theme.bar.buttons.media.background": "#282828",
          "theme.bar.buttons.windowtitle.icon_background": "#d3869b",
          "theme.bar.buttons.windowtitle.icon": "#282828",
          "theme.bar.buttons.windowtitle.text": "#d3869b",
          "theme.bar.buttons.windowtitle.background": "#282828",
          "theme.bar.buttons.workspaces.numbered_active_underline_color": "#ffffff",
          "theme.bar.buttons.workspaces.numbered_active_highlighted_text_color": "#21252b",
          "theme.bar.buttons.workspaces.active": "#d3869b",
          "theme.bar.buttons.workspaces.occupied": "#fb4934",
          "theme.bar.buttons.workspaces.available": "#83a598",
          "theme.bar.buttons.workspaces.hover": "#d3869b",
          "theme.bar.buttons.workspaces.background": "#282828",
          "theme.bar.buttons.dashboard.icon": "#282828",
          "theme.bar.buttons.dashboard.background": "#fabc2f",
          "theme.bar.buttons.icon": "#242438",
          "theme.bar.buttons.text": "#83a598",
          "theme.bar.buttons.hover": "#504945",
          "theme.bar.buttons.icon_background": "#83a598",
          "theme.bar.buttons.background": "#282828",
          "theme.bar.buttons.style": "split",
          "theme.bar.background": "#282828",
          "theme.osd.label": "#83a598",
          "theme.osd.icon": "#282828",
          "theme.osd.bar_overflow_color": "#cc241d",
          "theme.osd.bar_empty_color": "#3c3836",
          "theme.osd.bar_color": "#83a598",
          "theme.osd.icon_container": "#83a598",
          "theme.osd.bar_container": "#282828",
          "theme.notification.close_button.label": "#282828",
          "theme.notification.close_button.background": "#83a598",
          "theme.notification.labelicon": "#83a598",
          "theme.notification.text": "#ebdbb2",
          "theme.notification.time": "#928374",
          "theme.notification.border": "#3c3836",
          "theme.notification.label": "#83a598",
          "theme.notification.actions.text": "#32302f",
          "theme.notification.actions.background": "#83a598",
          "theme.notification.background": "#32302f",
          "theme.bar.buttons.modules.power.border": "#282828",
          "theme.bar.buttons.modules.weather.border": "#fe8017",
          "theme.bar.buttons.modules.updates.border": "#b16286",
          "theme.bar.buttons.modules.kbLayout.border": "#83a598",
          "theme.bar.buttons.modules.netstat.border": "#b8bb26",
          "theme.bar.buttons.modules.storage.border": "#83a598",
          "theme.bar.buttons.modules.cpu.border": "#d3869b",
          "theme.bar.buttons.modules.ram.border": "#fabd2f",
          "theme.bar.buttons.notifications.border": "#83a598",
          "theme.bar.buttons.clock.border": "#d3869b",
          "theme.bar.buttons.battery.border": "#fabd2f",
          "theme.bar.buttons.systray.border": "#504945",
          "theme.bar.buttons.bluetooth.border": "#83a598",
          "theme.bar.buttons.network.border": "#b16286",
          "theme.bar.buttons.volume.border": "#fe8018",
          "theme.bar.buttons.media.border": "#83a598",
          "theme.bar.buttons.windowtitle.border": "#d3869b",
          "theme.bar.buttons.workspaces.border": "#ffffff",
          "theme.bar.buttons.dashboard.border": "#fabd2f",
          "theme.bar.buttons.modules.submap.background": "#282828",
          "theme.bar.buttons.modules.submap.text": "#8ec07c",
          "theme.bar.buttons.modules.submap.border": "#8ec07c",
          "theme.bar.buttons.modules.submap.icon": "#21252b",
          "theme.bar.buttons.modules.submap.icon_background": "#8ec07c",
          "theme.bar.menus.menu.network.switch.enabled": "#b16286",
          "theme.bar.menus.menu.network.switch.disabled": "#3c3836",
          "theme.bar.menus.menu.network.switch.puck": "#504945",
          "theme.bar.buttons.systray.customIcon": "#ebdbb2",
          "theme.bar.border.color": "#83a598",
          "theme.bar.menus.menu.media.timestamp": "#ebdbb2",
          "theme.bar.buttons.borderColor": "#83a598",
          "theme.bar.buttons.modules.hyprsunset.icon": "#21252b",
          "theme.bar.buttons.modules.hyprsunset.background": "#282828",
          "theme.bar.buttons.modules.hyprsunset.icon_background": "#fabd2f",
          "theme.bar.buttons.modules.hyprsunset.text": "#fabd2f",
          "theme.bar.buttons.modules.hyprsunset.border": "#fabd2f",
          "theme.bar.buttons.modules.hypridle.icon": "#21252b",
          "theme.bar.buttons.modules.hypridle.background": "#282828",
          "theme.bar.buttons.modules.hypridle.icon_background": "#83a598",
          "theme.bar.buttons.modules.hypridle.text": "#83a598",
          "theme.bar.buttons.modules.hypridle.border": "#83a598",
          "theme.bar.menus.menu.network.scroller.color": "#b16286",
          "theme.bar.menus.menu.bluetooth.scroller.color": "#83a598",
          "theme.bar.buttons.modules.cava.text": "#8ec07c",
          "theme.bar.buttons.modules.cava.background": "#282828",
          "theme.bar.buttons.modules.cava.icon_background": "#8ec07c",
          "theme.bar.buttons.modules.cava.icon": "#21252b",
          "theme.bar.buttons.modules.cava.border": "#8ec07c",
          "theme.bar.buttons.modules.microphone.border": "#b8bb26",
          "theme.bar.buttons.modules.microphone.background": "#282828",
          "theme.bar.buttons.modules.microphone.text": "#b8bb26",
          "theme.bar.buttons.modules.microphone.icon": "#282828",
          "theme.bar.buttons.modules.microphone.icon_background": "#b8bb26",
          "theme.font.name": "Ubuntu Nerd Font",
          "theme.font.label": "Ubuntu Nerd Font",
          "menus.clock.weather.unit": "metric",
          "menus.clock.weather.location": "Samara",
          "menus.clock.time.hideSeconds": true,
          "bar.customModules.microphone.label": true,
          "scalingPriority": "hyprland",
          "menus.volume.raiseMaximumVolume": true,
          "menus.clock.weather.interval": 600,
          "theme.bar.location": "top",
          "bar.autoHide": "never",
          "bar.workspaces.workspaceMask": false,
          "bar.workspaces.showWsIcons": true,
          "bar.workspaces.showApplicationIcons": false,
          "bar.workspaces.numbered_active_indicator": "highlight",
          "bar.battery.label": false,
          "theme.bar.buttons.battery.enableBorder": false,
          "theme.bar.enableShadow": false,
          "theme.osd.enable": true,
          "theme.bar.floating": false,
          "bar.layouts": {
            "*": {
              "left": [
                "dashboard",
                "workspaces",
                "windowtitle",
                "cava"
              ],
              "middle": [
                "media"
              ],
              "right": [
                "systray",
                "kbinput",
                "volume",
                "clock",
                "notifications",
                "power"
              ]
            }
          },
          "menus.media.displayTime": false,
          "menus.media.displayTimeTooltip": false,
          "menus.clock.weather.key": "fe80b66d0ca342bba9793644252603",
          "menus.dashboard.controls.enabled": true,
          "menus.dashboard.shortcuts.enabled": true,
          "menus.dashboard.directories.enabled": false,
          "menus.dashboard.shortcuts.left.shortcut1.tooltip": "",
          "menus.dashboard.shortcuts.left.shortcut1.command": "",
          "menus.dashboard.shortcuts.left.shortcut1.icon": "",
          "menus.dashboard.shortcuts.left.shortcut2.command": "",
          "menus.dashboard.shortcuts.left.shortcut2.icon": "",
          "menus.dashboard.shortcuts.left.shortcut2.tooltip": "",
          "menus.dashboard.shortcuts.left.shortcut3.icon": "",
          "menus.dashboard.shortcuts.left.shortcut3.command": "",
          "menus.dashboard.shortcuts.left.shortcut3.tooltip": "",
          "menus.dashboard.shortcuts.left.shortcut4.icon": "",
          "menus.dashboard.shortcuts.left.shortcut4.command": "",
          "menus.dashboard.shortcuts.left.shortcut4.tooltip": "",
          "menus.dashboard.powermenu.avatar.image": "${cfgDir}/attachments/dots/hyprlandarch/wallpapers/ava.png",
          "bar.clock.format": "%a %b %d %H:%M",
          "bar.customModules.weather.unit": "metric",
          "bar.customModules.cava.icon": "",
          "theme.bar.buttons.modules.cava.spacing": "0.5em",
          "bar.customModules.cava.showIcon": false,
          "theme.bar.buttons.enableBorders": false,
          "theme.bar.margin_sides": "0.5em",
          "theme.bar.margin_top": "0.5em",
          "bar.launcher.autoDetectIcon": false,
          "theme.bar.buttons.dashboard.enableBorder": false,
          "theme.bar.buttons.notifications.hover": "#504945",
          "theme.bar.buttons.clock.hover": "#504945",
          "theme.bar.buttons.battery.hover": "#504945",
          "theme.bar.buttons.systray.hover": "#504945",
          "theme.bar.buttons.bluetooth.hover": "#504945",
          "theme.bar.buttons.network.hover": "#504945",
          "theme.bar.buttons.volume.hover": "#504945",
          "theme.bar.buttons.media.hover": "#504945",
          "theme.bar.buttons.windowtitle.hover": "#504945",
          "theme.bar.buttons.workspaces.numbered_active_text_color": "#24283b",
          "theme.bar.buttons.dashboard.hover": "#504945",
          "theme.bar.menus.menu.power.card.color": "#2a283e",
          "theme.bar.buttons.modules.cpu.hover": "#45475a",
          "theme.bar.buttons.volume.output_icon": "#11111b",
          "theme.bar.buttons.volume.output_text": "#eba0ac",
          "theme.bar.buttons.volume.input_icon": "#11111b",
          "theme.bar.buttons.volume.input_text": "#eba0ac",
          "theme.bar.buttons.volume.separator": "#45475a",
          "theme.bar.buttons.modules.cpuTemp.icon_background": "#fab387",
          "theme.bar.buttons.modules.cpuTemp.icon": "#fab387",
          "theme.bar.buttons.modules.cpuTemp.text": "#fab387",
          "theme.bar.buttons.modules.cpuTemp.border": "#fab387",
          "theme.osd.border.color": "#b4befe",
          "theme.bar.menus.monochrome": false,
          "bar.customModules.cava.autoSensitivity": true
        }
      '';
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
