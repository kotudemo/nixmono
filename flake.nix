
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    stylix.url = "github:danth/stylix";

    zapret.url = "github:SnakeOPM/zapret-flake.nix";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    stylix,
    zapret,
    aagl,
    ...
  } @ inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.zapret.nixosModules.zapret
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}

# {
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#
#     home-manager.url = "github:nix-community/home-manager/master";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";
#
#     chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
#
#     stylix.url = "github:danth/stylix";
#     zapret.url = "github:acf/zapret-flake.nix";
#   };
#
#   outputs = {
#     self,
#     nixpkgs,
#     home-manager,
#     chaotic,
#     stylix,
#     zapret,
#     ...
#   } @ inputs:
#   let
#     system = "x86_64-linux";
#     inherit (self) outputs;
#     #pkgs = nixpkgs.legacyPackages.${system};
#   in
#   {
#     nixosConfigurations = {
#       nixos = nixpkgs.lib.nixosSystem rec {
#         specialArgs = { inherit inputs; };
#         inherit system;
#         modules = [
#           ./configuration.nix
#           inputs.chaotic.nixosModules.default
#           inputs.home-manager.nixosModules.default
#           inputs.zapret.nixosModules.zapret
#           stylix.nixosModules.stylix
#         ];
#       };
#     };
#   };
# }
