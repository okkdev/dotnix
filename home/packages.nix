{ config, pkgs, neovim-nightly-overlay, ... }:

let otp = pkgs.beam.packages.erlangR26;
in {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Tools
    coreutils
    fd
    fzf
    ripgrep
    viddy
    jq
    httpie
    bottom
    dogdns
    du-dust
    yt-dlp
    wireguard-tools
    deploy-rs
    ollama
    krabby

    # Programming
    otp.erlang
    otp.rebar3
    otp.elixir_1_16
    bun
    corepack_21
    # elmPackages.elm
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
    otp.elixir-ls
    lexical-lsp
    next-ls
    elmPackages.elm-format
    fennel-ls
    fnlfmt
    nil
    nixfmt-rfc-style
    nodePackages.pyright
    nodePackages.typescript-language-server
    prettierd
    ruff
    rustywind
    stylua
    tailwindcss-language-server
    vscode-langservers-extracted
    taplo
    phpactor

    # fonts
    cascadia-code
    commit-mono
    cozette
    fantasque-sans-mono
    fira-code
    hasklig
    ibm-plex
    inter
    iosevka
    jetbrains-mono
    julia-mono
    manrope
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  programs = {
    bat = {
      enable = true;
      config.theme = "ansi";
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batpipe
        batgrep
        batwatch
      ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = true;
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };

    tealdeer = {
      enable = true;
      # updateOnActivation = true;
    };
  };
}
