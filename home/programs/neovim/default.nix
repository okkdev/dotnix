{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = (with pkgs ;[ fennel fnlfmt ripgrep fd fzf tree-sitter ]);
    plugins = with pkgs.vimPlugins; [
      # meta
      hotpot-nvim
      nvim-treesitter
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      undotree
      leap-nvim
      vim-sleuth
      which-key-nvim
      comment-nvim
      toggleterm-nvim

      # language
      conjure
      vim-nix

      # themes
      rose-pine
      nvim-web-devicons
     ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/fnl" = {
      source = ./fnl;
      onChange = ''
        rm -rf "$HOME/.cache/nvim/hotpot/"
      '';
    };
  };
}

