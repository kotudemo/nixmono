{pkgs, ...}: {
  imports = [
    ./modules/starship.nix
    ./modules/eza.nix
    ./modules/helix.nix
    ./modules/yazi.nix
    ./modules/ghostty.nix
    ./modules/nh.nix
    ./modules/bash.nix
    ./modules/zoxide.nix
    ./modules/bat.nix
    ./modules/stylix.nix
    ./moudles/nixcord.nix
    ./modules/librewolf.nix
    ./modules/fastfetch.nix
    ./modules/hyprlock.nix
    ./modules/swayimg.nix
    ./modules/wofi.nix
    ./modules/hyprland.nix
    ./modules/hyprpanel.nix
  ];
  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = "25.11";
    packages = with pkgs; [
      ayugram-desktop
      bemoji
      blesh
      brightnessctl
      cliphist
      cromite
      easyeffects
      grimblast
      hyprpicker
      hyprprop
      hyprswitch
      kdePackages.ark
      kdePackages.dolphin
      kdePackages.kcalc
      libreoffice-qt6-fresh
      librewolf
      mpv
      obs-studio
      pamixer
      pwvucontrol
      qbittorrent-enhanced
      spicetify-cli
      spotify
      swappy
      tesseract
      vscode
      wf-recorder
      wl-clipboard-rs
      wlsunset
    ];
  };

  systemd.user = {
    services = {
      hyprpolkitagent = {
        Unit = {
          Description = "Hyprpolkitagent service.";
          WantedBy = "graphical-session.target";
        };

        Service = {
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
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
          ExecStart = "${pkgs.hyprpanel}/bin/hyprpanel";
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
            before_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 750;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
          }

          {
            timeout = 900;
            on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
          }
        ];
      };
    };
  };

  stylixConfig = {
    enable = true;
    theme = "gruvbox-dark-medium";
  };

  programs.home-manager = {
    enable = true;
  };
}
