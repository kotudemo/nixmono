{
  config,
  pkgs,
  lib,
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
  ];

  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = config.system.nixos.release;
    packages = with pkgs; [
      bottom
    ];
  };

  stylixConfig = {
    enable = true;
    theme = "everforest";
  };

  programs.home-manager.enable = true;
  useGlobalPkgs = true;
}
# as i dunno how you'll be use it - i'll left it on you

