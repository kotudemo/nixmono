{
    inputs,
    pkgs,
    self,
    cfgDir,
    config,
    ...
}:{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  
  programs.nixcord = {
    enable = true;  # enable Nixcord. Also installs discord package
    vesktop = {
      enable = true;
      autoscroll = {
        enable = true;
      };
      #configDir = "../../attachments/dots/vencord";
    };
  };
  # ...
}
