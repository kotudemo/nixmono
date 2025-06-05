{
  lib,
  config,
  self,
  ...
}: {
  imports = [
    ./passthrough.nix
    ./stylix.nix
  ];
}
