{
  description = "My macOS Home Manager config 🥵";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, neovim-nightly-overlay, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.js = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            nixpkgs.overlays =
              [ (import ./overlays.nix) neovim-nightly-overlay.overlay ];
          }
          ./home.nix
        ];
      };

      defaultPackage.${system} = home-manager.defaultPackage.${system};
    };
}
