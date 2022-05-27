{ config, pkgs, ... }:

let
  comet = pkgs.stdenv.mkDerivation rec {
    name = "comet-${version}";
    version = "0.0.5";
    src = pkgs.fetchurl {
      url = "https://github.com/liamg/comet/releases/download/v${version}/comet-darwin-arm64";
      sha256 = "sha256-UMB7TMhZeVQZVoNZBuUT+0IeaYdeSBk/4mNhdzo+Q4o=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/comet
      chmod +x $out/bin/comet
    '';
  };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Tools
    neovim
    neofetch
    exa
    bat
    viddy
    jq
    nix-info
    comet

    # Programming
    yarn
    beam.interpreters.erlangR24
    beam.packages.erlangR24.elixir_1_13
    nodejs-16_x
    go_1_18
    rustup

    # Nix
    cachix
  ];
}
