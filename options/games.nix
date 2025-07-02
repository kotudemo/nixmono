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
        localNetworkGameTransfers = {
          openFirewall = true;
        };
        gamescopeSession = {
          enable = true;
        };
        protontricks.enable = true;
      };
      honkers-railway-launcher = {
        enable = true;
      };
      gamemode.enable = true;
      gamescope = {
        enable = true;
        package = pkgs.gamescope_git;
        args = [
          "-e"
        ];
      };
    };
    environment = {
      systemPackages = with pkgs; [
        #inputs.freesm.packages.${pkgs.system}.freesmlauncher
        adwsteamgtk
        protonplus
      ];
    };
  };
}
