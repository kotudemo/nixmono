   let
     # For Flakeless:
     # spicePkgs = spicetify-nix.packages;

     # With flakes:
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
   in
   programs.spicetify = {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblock

     ];
     theme = spicePkgs.themes.comfy;
     colorScheme = "Everforest";
   }
