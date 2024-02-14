{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Tools
    delta
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
    krabby

    # Programming
    beam.interpreters.erlangR25
    beam.packages.erlangR26.elixir_1_15
    bun
    corepack_21
    elmPackages.elm
    fennel
    gleam
    libiconv
    llvm
    nodejs_21
    python39
    rustup
    tailwindcss

    # LSPs and formatters
    biome
    elixir_ls
    elmPackages.elm-format
    fennel-ls
    fnlfmt
    nil
    nixfmt
    nodePackages.pyright
    nodePackages.typescript-language-server
    prettierd
    ruff
    rustywind
    stylua
    tailwindcss-language-server
    vscode-langservers-extracted

    # Nix
    cachix
  ];

  programs.bat = {
    enable = true;
    config.theme = "ansi";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
    extraOptions = [ "--group-directories-first" ];
  };

  programs.tealdeer = {
    enable = true;
    updateOnActivation = true;
  };
}
