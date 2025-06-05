{
  pkgs,
  inputs,
  config,
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
  useGlobalPkgs = true;
  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = config.system.nixos.release;
    packages = with pkgs; [
      blesh
    ];
  };

  stylixConfig = {
    enable = true;
    theme = "everforest";
  };
}
