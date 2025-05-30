{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.zapret_preset_russia;
  quotedHosts = map (host: "\"${host}\"") (lib.splitString "\n" (lib.fileContents "${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-russia-blacklist.txt"));
in {
  options.zapret_preset_russia = {
    enable = lib.mkEnableOption ''
      Enable zapret.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      udpSupport = true;
      udpPorts = [
        "50000:50100"
        "443"
      ];
      params = [
        "--filter-tcp=80"
        "--dpi-desync=fake,split2"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--new"

        "--filter-tcp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake,split2"
        "--dpi-desync-repeats=11"
        "--dpi-desync-fooling=md5sig"
        "--dpi-desync-fake-tls=${inputs.secret_files.packages.${pkgs.system}.files}/tls_clienthello_www_google_com.bin"
        "--new"

        "--filter-tcp=80,443"
        "--dpi-desync=fake,disorder2"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync-autottl=2"
        "--dpi-desync-fooling=md5sig"
        "--new"

        "--filter-udp=50000-50100"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=6"
        "--dpi-desync-any-protocol"
        "--dpi-desync-cutoff=n4"
        "--new"

        "--filter-udp=443"
        "--hostlist=${inputs.zapret-hostlists.packages.${pkgs.system}.files}/lists/list-basic.txt"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=11"
        "--dpi-desync-fake-quic=${inputs.secret_files.packages.${pkgs.system}.files}/quic_initial_www_google_com.bin"
        "--new"

        "--filter-udp=443"
        "--dpi-desync=fake"
        "--dpi-desync-repeats=11"
        "--new"
      ];
      blacklist = quotedHosts;
    };
  };
}
