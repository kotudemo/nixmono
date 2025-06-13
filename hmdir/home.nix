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
    ./modules/nixcord.nix
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

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      substituters = [
        # cache.nixos.org
        "https://nixos-cache-proxy.cofob.dev"
        "https://cache.nixos.org"
        # cache.garnix.org
        "https://cache.garnix.io"
        # cachix
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
        "https://ags.cachix.org"
        "https://hyprland.cachix.org"
        "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        # cache.nixos.org
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # cache.garnix.io
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        # cachix.org
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
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
