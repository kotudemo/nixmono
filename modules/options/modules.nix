{
  lib,
  config,
  self,
  ...
}: {
  imports = [
    ./passthrough.nix
    ./zapret_preset_russia.nix
    ./zapret_renixos.nix
    ./zapret_ultimatefix_universalv3.nix
    ./zapret_ultimatefix_extended.nix
    ./zapret_russiafix.nix
    ./zapret_general.nix
    ./zapret_general_alt.nix
    ./zapret_general_alt2.nix
    ./zapret_general_alt3.nix
    ./zapret_general_alt4.nix
    ./zapret_general_alt5.nix
    ./zapret_general_alt6.nix
    ./zapret_general_mgts.nix
    ./zapret_general_mgts2.nix
  ];
}
