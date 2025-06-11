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
    ./modules/firefox.nix
  ];
  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = "25.11";
    packages = with pkgs; [
      blesh
    ];
  };

  stylixConfig = {
    enable = true;
    theme = "everforest";
  };
  programs.home-manager = {
    enable = true;
  };
}
