{pkgs, ...}: {
  programs = {
    ghostty = {
      enable = true; # enabling toggle
      enableBashIntegration = true; # integration with bash
      enableFishIntegration = true; # integration with fish
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      package = pkgs.ghostty.overrideAttrs (_: {
        preBuild = ''
          shopt -s globstar
          sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
          shopt -u globstar
        '';
      });
      settings = {
        # theme = "dark_everforest";
        #theme = "tokyonight";
      };
      themes = {
        dark_everforest = {
          background = "2D353B";
          foreground = "D3C6AA";
          cursor-color = "56635F";
          selection-background = "543A48";
          selection-foreground = "D3C6AA";
          palette = [
            "0=#232A2E"
            "1=#E67E80"
            "2=#A7C080"
            "3=#DBBC7F"
            "4=#7FBBB3"
            "5=#D699B6"
            "6=#83C092"
            "7=#4F585E"
            "8=#3D484D"
            "9=#543A48"
            "10=#425047"
            "11=#4D4C43"
            "12=#3A515D"
            "13=#514045"
            "14=#83C092"
            "15=#D3C6AA"
          ];
        };
      };
    };
  };
}
