{
  pkgs,
  lib,
  inputs,
  ...
}: {
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
    ./modules/firefox.nix
    ./modules/fastfetch.nix
    ./modules/hyprlock.nix
    ./modules/swayimg.nix
    ./modules/wofi.nix
    ./modules/chromium.nix
    ./modules/hypr.nix
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
      dconf
      easyeffects
      hyprpaper
      google-cursor
      grimblast
      hyprpicker
      hyprprop
      kdePackages.ark
      kdePackages.dolphin
      kdePackages.kdegraphics-thumbnailers
      libsForQt5.ffmpegthumbs
      kdePackages.qtsvg
      libsForQt5.kio-extras
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
      vscodium-fhsWithPackages
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
    overlays = [
      inputs.hyprpanel.overlay
    ];
  };

  programs.home-manager = {
    enable = true;
  };
}
