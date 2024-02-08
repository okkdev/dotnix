{ config, pkgs, lib, ... }:

let
  tangerine-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "tangerine-nvim";
    version = "v2.8";
    src = pkgs.fetchFromGitHub {
      owner = "udayvir-singh";
      repo = "tangerine.nvim";
      rev = version;
      sha256 = "sha256-gviY9oltZiOWJR9vWSIgWGd7uVvfcTPNUScmaWjVCm8=";
    };
  };
  tailwindcss-colorizer-cmp = pkgs.vimUtils.buildVimPlugin {
    pname = "tailwindcss-colorizer-cmp";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "roobert";
      repo = "tailwindcss-colorizer-cmp.nvim";
      rev = "bc25c56083939f274edcfe395c6ff7de23b67c50";
      sha256 = "sha256-4wt4J6pENX7QRG7N1GzE9L6pM5E88tnHbv4NQa5JqSI=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = (with pkgs; [ fzf tree-sitter delta fd ]);
    plugins = with pkgs.vimPlugins; [
      # meta
      tangerine-nvim
      plenary-nvim
      mini-nvim

      # lsp/completions
      (nvim-treesitter.withPlugins (p: [
        p.bash
        p.c
        p.elixir
        p.elm
        p.fennel
        p.fish
        p.gleam
        p.heex
        p.javascript
        p.json
        p.lua
        p.markdown
        p.markdown_inline
        p.nix
        p.query
        p.regex
        p.rust
        p.typescript
        p.vim
        p.vimdoc
        p.yaml
      ]))
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      conform-nvim
      tailwindcss-colorizer-cmp

      # ease of use
      leap-nvim
      eyeliner-nvim
      vim-repeat
      # vim-sleuth
      toggleterm-nvim
      telescope-nvim
      telescope-undo-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      trouble-nvim
      vim-fugitive
      gitsigns-nvim

      # ui
      rose-pine
      nvim-web-devicons
      lualine-nvim
      which-key-nvim
      alpha-nvim
      noice-nvim
      nui-nvim
      nvim-notify

      # language
      conjure
      vim-nix
    ];
  };

  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
    onChange = ''
      $HOME/.nix-profile/bin/nvim -Es -c ":FnlClean!" -c ":FnlCompile!"
    '';
  };

  xdg.configFile."neovide/config.toml" = {
    text = ''
      frame = "buttonless"

      [font]
      normal = ["FantasqueSansM Nerd Font"]
      size = 15
    '';
  };

  # Default biome config
  home.file."biome.json" = {
    text = ''
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
}
