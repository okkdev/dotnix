{
  description = "my systems :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:/sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      niri,
      nixos-hardware,
      ...
    }@inputs:
    {
      # Standalone home-manager (macOS)
      homeConfigurations = {
        boook = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;

          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [ (import ./overlays.nix) ];
            }

            ./hosts/boook
          ];
        };
      };

      # NixOS system configurations
      nixosConfigurations = {
        fork = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            username = "jen";
          };
          modules = [
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            niri.nixosModules.niri

            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                (import ./overlays.nix)
                niri.overlays.niri
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }

            ./hosts/fork
          ];
        };
      };
    };
}
