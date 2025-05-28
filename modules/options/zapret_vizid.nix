{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_vizid;
in {
  options.zapret_vizid = {
    enable = lib.mkEnableOption ''
      Enable zapret.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      udpSupport = true;
      udpPorts = [
        "50000:50099"
        "443"
      ];
      params = [
        "--filter-udp=50000-50099"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--new"
        "--filter-udp=443"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=2"
        "--new"
        "--filter-tcp=80,443"
        "--dpi-desync=fake,multidisorder"
        "--dpi-desync-ttl=3"
      ];
    };
  };
}
