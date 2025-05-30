{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_ultimatefix_extended;
in {
  options.zapret_ultimatefix_extended = {
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
        "--filter-udp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=6"
        "--dpi-desync-udplen-increment=10"
        "--dpi-desync-udplen-pattern=0xDEADBEEF"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-udp=50000-65535"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/ipset-discord.txt"
        "--dpi-desync=fake"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=d3"
        "--dpi-desync-repeats=6"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-tcp=80"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,split2"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--new"

        "--filter-tcp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,split"
        "--dpi-desync-autottl=2"
        "--dpi-desync-repeats=6"
        "--dpi-desync-fooling=badseq"
        "--dpi-desync-fake-tls=${inputs.secret_files.packages.${pkgs.system}.files}/tls_clienthello_www_google_com.bin"
      ];
    };
  };
}
