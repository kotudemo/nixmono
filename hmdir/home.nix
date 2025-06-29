{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./programs/starship.nix
    ./programs/eza.nix
    ./programs/helix.nix
    ./programs/yazi.nix
    ./programs/ghostty.nix
    ./programs/nh.nix
    ./programs/bash.nix
    ./programs/zoxide.nix
    ./programs/bat.nix
    ./programs/stylix.nix
    ./programs/nixcord.nix
    ./programs/firefox.nix
    ./programs/fastfetch.nix
    ./programs/hyprlock.nix
    ./programs/swayimg.nix
    ./programs/wofi.nix
    ./programs/chromium.nix
    ./programs/hyprland.nix
    # ./programs/hyprshell.nix
    # ./programs/handpanel.nix
    #./modules/hyprpanel.nix
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
      easyeffects
      hyprpaper
      google-cursor
      grimblast
      hyprpicker
      hyprprop
      kdePackages.ark
      kdePackages.dolphin
      kdePackages.kcalc
      libreoffice-qt6-fresh
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

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    # style = {
    #   package = pkgs.gruvbox-kvantum;
    #   name = "kvantum";
    # };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Whitesur-icon-theme";
      package = pkgs.whitesur-icon-theme;
    };
  };

  stylixConfig = {
    enable = true;
    theme = "gruvbox-dark-medium";
  };

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      substituters = [
        # cache.nixos.org
        # "https://nixos-cache-proxy.cofob.dev"
        "https://cache.nixos.org"
        # cache.garnix.org
        # "https://cache.garnix.io"
        # cachix
        # "https://nix-community.cachix.org/"
        # "https://chaotic-nyx.cachix.org/"
        # "https://ags.cachix.org"
        # "https://hyprland.cachix.org"
        # "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        # cache.nixos.org
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # cache.garnix.io
        # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        # cachix.org
        # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        # "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
    overlays = [
      inputs.hyprpanel.overlay
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

  programs.home-manager = {
    enable = true;
  };
}
