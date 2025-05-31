{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_ultimatefix_universalv2;
in {
  options.zapret_ultimatefix_universalv2 = {
    enable = lib.mkEnableOption ''
      Enable zapret.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      configureFirewall = true;
      udpSupport = true;
      udpPorts = [
        "50000:65535"
        "443"
      ];
      params = [
        "--filter-udp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,disorder2"
        "--dpi-desync-repeats=8"
        "--dpi-desync-udplen-increment=12"
        "--dpi-desync-udplen-pattern=0xDEADBEEF"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-udp=50000-65535"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/ipset-discord.txt"
        "--dpi-desync=fake,tamper"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=d4"
        "--dpi-desync-repeats=8"
        "--new"

        "--filter-tcp=80"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,split2"
        "--dpi-desync-autottl=3"
        "--dpi-desync-fooling=md5sig"
        "--new"

        "--filter-tcp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=disorder2"
        "--dpi-desync-split-pos=2"
        "--dpi-desync-autottl=3"
        "--dpi-desync-repeats=8"
        "--dpi-desync-fooling=badseq"
        "--dpi-desync-fake-tls=${inputs.secret_files.packages.${pkgs.system}.files}/tls_clienthello_www_google_com.bin"
        "--new"
      ];
    };
  };
}
