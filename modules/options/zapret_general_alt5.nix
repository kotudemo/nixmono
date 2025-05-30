{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_general_alt5;
in {
  options.zapret_general_alt5 = {
    enable = lib.mkEnableOption ''
      Enable zapret.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      configureFirewall = true;
      qnum = 350;

      params = [
        "--filter-udp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=6"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-udp=50000-65535"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=d3"
        "--dpi-desync-repeats=6"
        "--new"

        "--filter-tcp=80"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,split2"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--new"
      ];
    };
  };
}
