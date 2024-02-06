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
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = (with pkgs ;[ fzf tree-sitter delta fd ]);
    plugins = with pkgs.vimPlugins; [
      # meta
      tangerine-nvim
      plenary-nvim

      # lsp/completions
      (nvim-treesitter.withPlugins
        (p: [
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

      # ease of use
      leap-nvim
      eyeliner-nvim
      vim-repeat
      vim-sleuth
      comment-nvim
      toggleterm-nvim
      telescope-nvim
      telescope-undo-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      trouble-nvim
      vim-fugitive

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
  xdg.configFile."biome/biome.json" = {
    text = ''
      {
        "formatter": {
          "indentStyle": "space"
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
