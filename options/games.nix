{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}: let
  cfg = config.games;
in {
  options.games = {
    enable = lib.mkEnableOption ''
      Enable some TRUE GAMING OPTIONS
    '';
  };

  config = lib.mkIf cfg.enable {
    hardware.steam-hardware.enable = true;
    programs = {
      steam = {
        enable = true;
        remotePlay = {
          openFirewall = true;
        };
        gamescopeSession = {
          enable = true;
        };
        protontricks.enable = true;
        package = (
          pkgs.steam.override {
            extraPkgs = pkgs:
              with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          }
        );
      };
      honkers-railway-launcher = {
        enable = true;
      };
      gamemode.enable = true;
    };
    environment = {
      systemPackages = with pkgs; [
        inputs.freesm.packages.${pkgs.system}.freesmlauncher
        adwsteamgtk
        protonplus
      ];
    };
  };
}
