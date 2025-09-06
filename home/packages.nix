{ pkgs, ... }:

let
  otp = pkgs.beam.packages.erlang_28;
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Tools
    coreutils
    fd
    fzf
    ripgrep
    viddy
    jq
    xh
    bottom
    btop
    dogdns
    du-dust
    # wireguard-tools
    deploy-rs
    ollama
    nurl
    gnused
    (writeShellScriptBin "gsed" "exec ${gnused}/bin/sed \"$@\"") # macos gsed workaround
    ouch
    gping
    tealdeer
    visidata
    inetutils
    rainfrog
    difftastic
    mergiraf

    # Programming
    otp.erlang
    otp.rebar3
    otp.elixir_1_19
    deno
    dotnetCorePackages.dotnet_9.sdk
    mono
    nodejs_24
    corepack_24
    fennel
    gleam
    libiconv
    llvm
    python314
    uv
    rustup
    tailwindcss
    typescript
    typst
    uiua
    d2
    chez

    # LSPs and formatters
    biome
    dockerfile-language-server-nodejs
    erlang-language-platform
    erlfmt
    otp.elixir-ls
    expert-lsp
    fennel-ls
    fnlfmt
    gdtoolkit_4
    nixd
    nixfmt-rfc-style
    nixpkgs-lint-community
    nodePackages.bash-language-server
    shellcheck
    tailwindcss-language-server
    typescript-language-server
    svelte-language-server
    phpactor
    prettierd
    pyright
    ruff
    ty
    rustywind
    shfmt
    stylua
    superhtml
    sql-formatter
    taplo
    tombi
    tinymist
    typstyle
    omnisharp-roslyn
    vscode-langservers-extracted
    yaml-language-server
    # akkuPackages.scheme-langserver

    # fonts
    atkinson-hyperlegible
    cascadia-code
    commit-mono
    fantasque-sans-mono
    fira-code
    hasklig
    # ibm-plex
    inter
    # iosevka
    # jetbrains-mono
    julia-mono
    manrope
    miracode
    recursive
    uiua386
    nerd-fonts.symbols-only
  ];

  programs = {
    zoxide.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "ansi";
        style = "plain";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batpipe
        batgrep
        batwatch
      ];
    };

    eza = {
      enable = true;
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };
  };
}
