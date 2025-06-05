{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  options = {
    stylixConfig = {
      enable = lib.mkEnableOption "enable stylix";
      theme = lib.mkOption {type = lib.types.str;};
    };
    wallpaper = lib.mkOption {type = with lib.types; oneOf [str path package];};
  };
  config = lib.mkIf config.stylixConfig.enable {
    wallpaper = with config.lib.stylix.colors.withHashtag;
      pkgs.runCommand "output_wallpaper.png" {} ''
        pastel=${pkgs.pastel}/bin/pastel
        SHADOWS=$($pastel darken 0.1 '${base05}' | $pastel format hex)
        TAIL=$($pastel lighten 0.1 '${base02}' | $pastel format hex)
        HIGHLIGHTS=$($pastel lighten 0.1 '${base05}' | $pastel format hex)

        ${pkgs.imagemagick}/bin/convert ${./attachments/input_wallpaper.png} \
         -fill '${base00}' -opaque black \
         -fill '${base05}' -opaque white \
         -fill '${base08}' -opaque blue \
         -fill $SHADOWS -opaque gray \
         -fill '${base02}' -opaque orange \
         -fill $TAIL -opaque green \
         -fill $HIGHLIGHTS -opaque brown \
         $out'';
    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.stylixConfig.theme}.yaml";
      image = config.wallpaper;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.roboto-mono;
          name = "Roboto-Mono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sansSerif = {
          package = pkgs.nerd-fonts.aurulent-sans-mono;
          name = "Aurulent Sans Mono Nerd Font";
        };

        serif = {
          package = pkgs.nerd-fonts.inconsolata-lgc;
          name = "Hack Nerd Font";
        };
      };
      cursor = {
        name = "Whitesur-cursors";
        package = pkgs.whitesur-cursors;
        size = 24;
      };
    };
  };
}
