{
  description = "my systems :)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
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
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [ (import ./overlays.nix) ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }

            nixos-hardware.nixosModules.framework-amd-ai-300-series

            ./hosts/fork
          ];
        };
      };
    };
}
