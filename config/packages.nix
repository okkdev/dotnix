{ config, pkgs, ... }:

{
 home.packages = with pkgs; [
    # Tools
    neovim
    neofetch
    exa
    bat
    viddy

    # Programming
    yarn
    beam.interpreters.erlangR24
    beam.packages.erlangR24.elixir_1_12
    nodejs-16_x
    rustup

    # Nix
    cachix
  ];

  home.file.".config/nixpkgs/config.nix".text = "
  {
    allowUnfree = true;
  }
  ";
}
