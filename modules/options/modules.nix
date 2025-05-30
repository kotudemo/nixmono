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
  ];
}
