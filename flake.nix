{

  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:  
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      homeManagerModules = [ nixvim.homeManagerModules.nixvim ];
    in
  {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };

    homeConfigurations = {
      hugo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ] ++ homeManagerModules;
      };
    };
  };

}
