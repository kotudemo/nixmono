{
  inputs,
  pkgs,
  ...
}: {


  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord = {
      enable = true;
      package = pkgs.discord-krisp;
      branch = "canary";
      vencord = {
        enable = true;
      };
      openASAR.enable = true;
      autoscroll.enable = true;
    };
  };
  # ...
}
