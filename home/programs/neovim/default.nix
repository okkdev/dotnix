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
  bg-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "bg-nvim";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "typicode";
      repo = "bg.nvim";
      rev = "1c95261cc5e3062e3b277fc5c15d180d51a40f62";
      sha256 = "sha256-ZocdEdw7m6gVQap0MFr1uymIkHnX9ewjWmR7fYVR9Ko=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = (with pkgs; [ fzf tree-sitter delta fd ]);
    plugins = with pkgs.vimPlugins; [
      # Fennel compiler plugin
      tangerine-nvim

      # collection of utils
      mini-nvim

      # treesitter
      nvim-treesitter.withAllGrammars

      # lsp and completions
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      tailwindcss-colorizer-cmp

      # snippets
      luasnip
      cmp_luasnip
      friendly-snippets

      # formatter
      conform-nvim

      # ease of use stuff
      eyeliner-nvim
      toggleterm-nvim
      plenary-nvim # telescope dependency
      telescope-nvim
      telescope-undo-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      trouble-nvim
      gitsigns-nvim
      flash-nvim
      oil-nvim

      # ui framework
      nui-nvim

      # icons
      nvim-web-devicons
      lspkind-nvim

      # ui elements
      lualine-nvim
      which-key-nvim
      alpha-nvim
      noice-nvim
      nvim-notify
      zen-mode-nvim
      twilight-nvim
      bg-nvim

      # themes
      rose-pine
      catppuccin-nvim
      neovim-ayu
      oxocarbon-nvim
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
      normal = ["CommitMonoLiga Nerd Font"]
      size = 14.5
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
