{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  options.quickSettings = {
    enable = lib.mkEnableOption ''
      Option for options.
    '';
  };
}
