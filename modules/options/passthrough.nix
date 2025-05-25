{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.passthrough;
in {
  options.passthrough = {
    enable = lib.mkEnableOption ''
      Enable GPU passthrough system settings.
    '';
  };

  imports = lib.mkIf cfg.enable [
    ./specialisations/passthrough.nix
  ];
}
