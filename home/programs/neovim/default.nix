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
    plugins = with pkgs.vimPlugins; [
      # meta
      tangerine-nvim
      plenary-nvim

      # lsp/completions
      nvim-treesitter
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets

      # ease of use
      undotree
      leap-nvim
      vim-repeat
      vim-sleuth
      comment-nvim
      toggleterm-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      # ui
      rose-pine
      nvim-web-devicons
      noice-nvim
      lualine-nvim
      which-key-nvim
      alpha-nvim
      nui-nvim
      nvim-notify

      # language
      conjure
      vim-nix
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = ./config;
      recursive = true;
    };
  };
}

