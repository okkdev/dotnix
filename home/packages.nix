{ config, pkgs, ... }:

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
    httpie # replace with xh?
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
    otp.elixir_1_18
    deno
    dotnet-sdk_9
    mono
    nodejs_24
    corepack_24
    fennel
    gleam
    libiconv
    llvm
    python313
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
    fennel-ls
    fnlfmt
    gdtoolkit_4
    nil
    nixfmt-rfc-style
    nodePackages.bash-language-server
    shellcheck
    typescript-language-server
    otp.elixir-ls
    phpactor
    prettierd
    pyright
    ruff
    rustywind
    shfmt
    stylua
    superhtml
    sql-formatter
    tailwindcss-language-server
    taplo
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
    ibm-plex
    inter
    iosevka
    jetbrains-mono
    julia-mono
    manrope
    miracode
    recursive
    uiua386
    nerd-fonts.symbols-only
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

    yazi = {
      enable = true;
      enableFishIntegration = true;
      plugins = {
        # "mime.yazi" = pkgs.fetchFromGitHub {
        #   owner = "DreamMaoMao";
        #   repo = "mime.yazi";
        #   rev = "8e866b9c281d745ebb5e712fd238fdf103ec2361";
        #   sha256 = "sha256-RGev5ecsBrzJHlooWw24FWZMjpwUshPMGRUc4UIh5mg=";
        # };
        "ouch" = pkgs.fetchFromGitHub {
          owner = "ndtoan96";
          repo = "ouch.yazi";
          rev = "694d149be5f96eaa0af68d677c17d11d2017c976";
          sha256 = "sha256-J3vR9q4xHjJt56nlfd+c8FrmMVvLO78GiwSNcLkM4OU=";
        };
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "okkdev";
          email = "dev@stehlik.me";
        };
        ui.diff.tool = "delta";
      };
    };
  };
}
