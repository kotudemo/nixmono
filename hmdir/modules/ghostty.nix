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
    };
  };
}
