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
    neofetch
    eza
    bat
    tealdeer
    fd
    fzf
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
    beam.packages.erlangR26.elixir_1_15
    elixir_ls
    nodejs_21
    corepack_21
    biome
    rustup
    libiconv
    elmPackages.elm
    llvm
    python39
    bun
    gleam
    fennel
    fnlfmt

    # Nix
    cachix
    nixpkgs-fmt
  ];
}
