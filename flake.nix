{
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

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, ... }:  
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
        modules = [
          ./machines/common.nix
          ./machines/laptop
        ];
      };
      #
      # fog = nixpkgs.lib.nixosSystem {
      #   modules = [ 
      #     ./machines/fog
      #   ];
      # };
    };

    homeConfigurations = {
      "hugo@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
          ./machines/laptop/laptop-home.nix
        ] ++ homeManagerModules;
      };
      #
      # "hugo@fog" = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = { inherit inputs; };
      #   modules = [
      #     ./home.nix
      #     ./machines/fog/fog-home.nix
      #   ] ++ homeManagerModules;
      # };
    };
  };

}
