{
  description = "My macOS Home Manager config 🥵";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      # neovim-nightly-overlay,
      brew-nix,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.js = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            nixpkgs.overlays = [
              # neovim-nightly-overlay.overlay
              brew-nix.overlay.${system}
              (import ./overlays.nix)
            ];
          }
          ./home.nix
        ];
      };

      defaultPackage.${system} = home-manager.defaultPackage.${system};
    };
}
