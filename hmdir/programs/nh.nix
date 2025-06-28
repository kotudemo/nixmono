{...}: {
  programs = {
    nh = {
      enable = true; # enabling togglek
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 2 --keep-since 2d";
      };
    };
  };
}
