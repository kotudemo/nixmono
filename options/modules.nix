{
  lib,
  config,
  self,
  ...
}: {
  imports = [
    ./passthrough.nix
    ./games.nix
  ];
}
