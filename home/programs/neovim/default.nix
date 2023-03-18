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
      nvim-lspconfig
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      undotree
      leap-nvim
      vim-sleuth
      which-key-nvim
      comment-nvim

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
        $DRY_RUN_CMD rm -rf "$HOME/.cache/nvim/hotpot/"
      '';
    };
  };
}

