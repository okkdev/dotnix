{ config, pkgs, ... }:

let
  comet = pkgs.stdenv.mkDerivation rec {
    name = "comet-${version}";
    version = "v0.0.5";
    src = pkgs.fetchurl {
      url = "https://github.com/liamg/comet/releases/download/${version}/comet-darwin-arm64";
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
    tealdeer
    fd
    ripgrep
    viddy
    jq
    nix-info
    comet
    httpie
    bottom
    dogdns
    du-dust
    yt-dlp

    # Programming
    beam.interpreters.erlangR25
    beam.packages.erlangR25.elixir_1_14
    nodejs-16_x
    yarn
    nodePackages.pnpm
    go_1_18
    rustup
    elmPackages.elm
    llvm

    # Nix
    cachix
  ];
}
