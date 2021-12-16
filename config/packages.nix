{ config, pkgs, ... }:

{
 home.packages = with pkgs; [
    # Tools
    neovim
    neofetch
    exa

    # Programming
    yarn
    beam.interpreters.erlangR24
    beam.packages.erlangR24.elixir_1_12
    nodejs-16_x
  ];
}