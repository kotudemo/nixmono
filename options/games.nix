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
      };
  };
    environment = {
      systemPackages = with pkgs; [
        inputs.freesm.packages.${pkgs.system}.freesmlauncher
      ];
    };
}
