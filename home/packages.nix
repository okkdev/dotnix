{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../overlays/vimPlugins.nix) ];

  home.packages = with pkgs; [
    # Tools
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
    taplo

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

  programs.bat = {
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

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [ "--disable-up-arrow" ];
  };

  programs.tealdeer = {
    enable = true;
    updateOnActivation = true;
  };
}
