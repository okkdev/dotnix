{ pkgs, ... }:

let
  nvim-config = pkgs.stdenv.mkDerivation {
    name = "lua-config";
    src = ./config;
    nativeBuildInputs = [ pkgs.fennel ];
    phases = [
      "buildPhase"
      "installPhase"
    ];
    buildPhase = ''
      mkdir -p build/lua
      cp $src/init.fnl build/
      cp -r --no-preserve=mode,ownership $src/fnl/* build/lua/

      find build -name "*.fnl" -type f | while read -r f; do
        echo "Compiling $f..."
        fennel --compile --globals vim "$f" > "''${f%.fnl}.lua" || exit 1
        rm "$f"
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
      curl
      fzf
      tree-sitter
      fd
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      # plugin dependencies
      plenary-nvim
      nvim-nio
      nui-nvim

      # collection of utils
      mini-nvim

      # treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-autotag

      # lsp
      nvim-lspconfig
      SchemaStore-nvim

      # completions
      blink-cmp
      blink-cmp-copilot
      friendly-snippets

      # AI 🫥
      copilot-lua
      minuet-ai-nvim
      codecompanion-nvim

      # formatter
      conform-nvim

      # telescope
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
      telescope-undo-nvim
      telescope-recent-files-nvim
      telescope-live-grep-args-nvim

      # editing
      dial-nvim
      parinfer-rust
      conjure

      # ease of use stuff
      nvim-tree-lua
      gitsigns-nvim
      flash-nvim
      oil-nvim
      nvim-spectre
      git-conflict-nvim
      persisted-nvim
      harpoon2
      visual-whitespace-nvim
      # rainbow-delimiters-nvim

      # notes
      typst-preview-nvim
      markview-nvim

      # icons
      nvim-web-devicons

      # ui elements
      noice-nvim
      nvim-notify
      bg-nvim

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
      d2-vim
    ];
  };

  xdg.configFile."nvim" = {
    source = nvim-config;
    recursive = true;
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
              "trailingCommas": "all"
            }
          },
          "linter": {
            "rules": {
              "suspicious": {
                "noShadowRestrictedNames": "warn"
              }
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
