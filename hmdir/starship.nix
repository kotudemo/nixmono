{...}: {
  programs = {
    starship = {
      enable = true; # enabling toggle
      enableBashIntegration = true; # integration with bash
      enableFishIntegration = true; # integration with fish
      enableZshIntegration = true;
      enableTransience = false;
    };
  };
}
