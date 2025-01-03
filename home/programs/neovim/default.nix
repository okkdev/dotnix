{
  config,
  pkgs,
  lib,
  ...
}:

let
  nvim-config = pkgs.stdenv.mkDerivation {
    name = "lua-config";
    src = ./config;
    buildInputs = [ pkgs.fennel ];
    phases = [
      "buildPhase"
      "installPhase"
    ];
    buildPhase = ''
      shopt -s globstar

      mkdir -p build/lua
      cp $src/init.fnl build/
      cp -r --no-preserve=mode,ownership $src/fnl/* build/lua/

      for f in build/**/*.fnl
      do 
        fennel --compile --globals vim $f > ''${f%.fnl}.lua
        rm $f
      done
    '';
    installPhase = ''
      mkdir -p $out
      cp -r build/* $out
    '';
  };
in
{
  programs.neovim = {
    enable = true;
    # uncomment to enable neovim nightly
    # package = pkgs.neovim;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      fzf
      tree-sitter
      fd
    ];
    extraLuaPackages =
      luaPkgs: with luaPkgs; [
        pathlib-nvim # for neorg
        lua-utils-nvim # for neorg
        jsregexp # for luasnip
      ];
    plugins = with pkgs.vimPlugins; [
      # kitty scrollback support
      kitty-scrollback-nvim

      # collection of utils
      mini-nvim

      # treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-autotag

      # lsp and completions
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      cmp-tailwind-colors
      copilot-lua
      copilot-cmp

      # snippets
      luasnip
      cmp_luasnip
      friendly-snippets

      # formatter
      conform-nvim

      # plugin dependencies
      plenary-nvim
      nvim-nio
      nui-nvim

      # telescope
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
      telescope-undo-nvim
      telescope-recent-files-nvim
      telescope-live-grep-args-nvim

      # ease of use stuff
      vim-sleuth
      nvim-tree-lua
      gitsigns-nvim
      flash-nvim
      oil-nvim
      diffview-nvim
      nvim-spectre
      vim-fugitive
      persisted-nvim
      (harpoon.overrideAttrs (_: {
        version = "2";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "harpoon";
          rev = "0378a6c428a0bed6a2781d459d7943843f374bce";
          sha256 = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
        };
      }))

      # notes
      neorg
      typst-preview-nvim

      # icons
      nvim-web-devicons
      lspkind-nvim

      # ui elements
      noice-nvim
      nvim-notify
      bg-nvim
      no-neck-pain-nvim

      # themes
      lush-nvim
      rose-pine
      everforest-nvim
      catppuccin-nvim
      neovim-ayu
      oxocarbon-nvim
      zenbones-nvim

      # language specific plugins
      uiua-vim
    ];
  };

  xdg.configFile."nvim" = {
    source = nvim-config;
    recursive = true;
  };

  xdg.configFile."neovide/config.toml" = {
    text =
      # toml
      ''
        frame = "buttonless"

        [font]
        normal = ["CommitMonoLiga Nerd Font"]
        size = 14.5
      '';
  };

  # Default biome config
  home.file."biome.json" = {
    text =
      # json
      ''
        {
          "formatter": {
            "indentStyle": "space",
            "formatWithErrors": true
          },
          "javascript": {
            "formatter": {
              "semicolons": "asNeeded",
              "trailingComma": "all"
            }
          }
        }
      '';
  };

  # Default deno config
  home.file."deno.json" = {
    text =
      # json
      ''
        {
          "fmt": {
            "semiColons": false
          }
        }
      '';
  };

}
