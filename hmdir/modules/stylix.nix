{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
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

        ${pkgs.imagemagick}/bin/convert ${../../attachments/input_wallpaper.png} \
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
      targets = {
        librewolf.enable = true;
      };
      image = config.wallpaper;
      fonts = {
        emoji = {
          package = pkgs.nerd-fonts.symbols-only;
          name = "Symbols Only Nerd Font";
        };
        #DE
        serif = {
          package = pkgs.nerd-fonts.hack;
                name = "Hack Nerd Font";
        };
        #GUI
        sansSerif = {
          package = pkgs.nerd-fonts.hack;
                name = "Hack Nerd Font";
        };
        #Terminal
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
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
