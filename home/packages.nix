{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Tools
    neofetch
    eza
    bat
    delta
    tealdeer
    fd
    fzf
    ripgrep
    viddy
    jq
    nix-info
    httpie
    bottom
    dogdns
    du-dust
    yt-dlp
    ollama

    # Programming
    beam.interpreters.erlangR25
    beam.packages.erlangR26.elixir_1_15
    elixir_ls
    nodejs_21
    corepack_21
    nodePackages.typescript-language-server
    tailwindcss
    tailwindcss-language-server
    biome
    prettierd
    rustup
    libiconv
    elmPackages.elm
    elmPackages.elm-format
    llvm
    python39
    bun
    gleam
    fennel
    fennel-ls
    fnlfmt
    nil
    nixfmt
    rustywind

    # Nix
    cachix
  ];
}
