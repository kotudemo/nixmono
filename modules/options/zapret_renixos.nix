{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_renixos;
in {
  options.zapret_renixos = {
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
        "--wssize 1:6"

        "--filter-tcp=80"
        "--dpi-desync=multisplit"
        "--dpi-desync-split-pos=10"
        "--dpi-desync-repeats=6"
        "--new"

        "--filter-tcp=443"
        "--dpi-desync=multidisorder"
        "--dpi-desync-split-pos=1,midsld"
        "--new"

        "--filter-tcp=443"
        "--dpi-desync=syndata"
        "--dpi-desync-fake-syndata=0x00000000"
        "--dpi-desync-ttl=10"
        "--new"

        "--filter-udp=443"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=6"
        "--dpi-desync-fake-quic=0x00000000"
        "--new"

        "--filter-udp=443"
        "--dpi-desync=fake,udplen"
        "--dpi-desync-udplen-increment=5"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-cutoff=n3"
        "--dpi-desync-repeats=2"
        "--new"

        "--filter-tcp=443"
        "--dpi-desync=split"
        "--dpi-desync-fooling=md5sig,badseq"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-split-pos=1"
        "--dpi-desync-repeats=10"
        "--new"

        "--filter-tcp=443"
        "--dpi-desync=fake,split2"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-split-seqovl=2"
        "--dpi-desync-split-pos=2"

        "--dpi-desync-autottl"
        "--new"
        "--filter-tcp=443"
        "--dpi-desync=fake,split2"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-split-seqovl=2"
        "--dpi-desync-split-pos=2"
        "--dpi-desync-autottl"
        "--new"

        "--filter-tcp=80"
        "--dpi-desync=fake,split2"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-autottl"
        "--new"

        "--filter-tcp=80"
        "--dpi-desync-ttl=1"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fake-tls=0x00000000"
        "--dpi-desync-split-pos=1"
        "--dpi-desync=fake,split2"
        "--dpi-desync-repeats=6"
        "--dpi-desync-fooling=md5sig"
        "--new"
      ];
    };
  };
}
