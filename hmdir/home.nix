{
  pkgs,
  lib,
  inputs,
  self,
  ...
}: {
  imports = [
    #./modules/audacious.nix
    # ./modules/bash.nix
    ./modules/starship.nix
    ./modules/eza.nix
    ./modules/helix.nix
    ./modules/yazi.nix
    ./modules/ghostty.nix
    ./modules/zoxide.nix
    ./modules/bat.nix
    ./modules/stylix.nix
    ./modules/vesktop.nix
    ./modules/fastfetch.nix
    ./modules/chromium.nix
    ./modules/nemo.nix

    ./modules/wayland/swayimg.nix
    ./modules/wayland/hypr.nix
    ./modules/wayland/waybar.nix
    ./modules/wayland/swaync.nix
    ./modules/wayland/swayosd.nix
    ./modules/wayland/wofi.nix
    
    ./goida.nix
  ];
  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = "25.11";
    packages = with pkgs; [
      legcord
      (discord-krisp.override {
        withOpenASAR = true; # can do this here too
        withVencord = true;
      })
      lmstudio
      unigine-superposition
      r2modman
      flow-control
      ayugram-desktop
      bemoji
      # blesh
      brightnessctl
      cliphist
      easyeffects
      kdePackages.ark
      kdePackages.kcalc
      libreoffice-qt6-fresh
      mpv
      vlc
      obs-studio
      pamixer
      pwvucontrol
      qbittorrent-enhanced
      spicetify-cli
      tesseract
      vscodium-fhs
    ];
    #file = {
    #  ".config/hyprpanel/config.json" = {
    #    source = "${self}/attachments/dots/hyprlandarch/config.json";
    #  };
    #};
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
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "black";};
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
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
