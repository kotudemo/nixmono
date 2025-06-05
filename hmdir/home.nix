{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./starship.nix
    ./eza.nix
    ./helix.nix
    ./yazi.nix
    ./ghostty.nix
    ./nh.nix
    ./bash.nix
    ./zoxide.nix
    ./bat.nix
    ./stylix.nix
  ];


  home = {
    username = "kd";
    homeDirectory = "/home/kd";
    stateVersion = config.system.nixos.release;
    packages = with pkgs; [
      #blesh
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

