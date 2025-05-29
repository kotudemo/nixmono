{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_ultimatefix;
in {
  options.zapret_ultimatefix = {
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
       "--dpi-desync=fake,split2"
       "--dpi-desync-repeats=10"
       "--dpi-desync-udplen-increment=15"
       "--dpi-desync-udplen-pattern=0xCAFEBABE"
       "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
       "--new"

        "--filter-udp=50000-65535"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/ipset-discord.txt"
        "--dpi-desync=fake,disorder2"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=n5"
        "--dpi-desync-repeats=10"
        "--new"

        "--filter-tcp=80"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,disorder2"
        "--dpi-desync-autottl=4"
        "--dpi-desync-fooling=badseq"
        "--new"

        "--filter-tcp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=split"
        "--dpi-desync-split-pos=3"
        "--dpi-desync-autottl=4"
        "--dpi-desync-repeats=10"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=${inputs.secret_files.packages.${pkgs.system}.files}/tls_clienthello_www_google_com.bin"
      ];
    };
  };
}
