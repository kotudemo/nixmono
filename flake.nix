{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixgl.url = "github:nix-community/nixGL";

    nur.url = "github:nix-community/NUR";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-anywhere.url = "github:nix-community/nixos-anywhere";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    freesm.url = "github:FreesmTeam/FreesmLauncher";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    #secret_files.url = "github:kotudemo/secret_files";
    #zapret-hostlists.url = "github:kotudemo/zapret-hostlists";
    zapret-presets.url = "github:kotudemo/zapret-presets";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixgl,
    nur,
    chaotic,
    freesm,
    spicetify-nix,
    disko,
    nixos-anywhere,
    #secret_files,
    #zapret-hostlists,
    zapret-presets,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.zapret-presets.nixosModules.presets
        ];
      };
    };
  };
}
