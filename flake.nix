{

  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs:  
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      homeManagerModules = [ nixvim.homeManagerModules.nixvim ];
    in
  {
    nixosConfigurations = {
      laptop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configurations/common.nix
          ./configurations/laptop_config.nix
        ];
      };

      desktop = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configurations/common.nix
          ./configurations/desktop_config.nix
        ];
      };
    };

    homeConfigurations = {
      hugo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ] ++ homeManagerModules;
      };
    };
  };

}
