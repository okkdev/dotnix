{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = (with pkgs; [ fzf tree-sitter fd sqlite ]);
    plugins = with pkgs.vimPlugins; [
      # Fennel compiler plugin
      tangerine-nvim

      ## Profiler
      #{
      #  plugin = profile-nvim;
      #  config = ''
      #    local should_profile = os.getenv("NVIM_PROFILE")
      #    if should_profile then
      #      require("profile").instrument_autocmds()
      #      if should_profile:lower():match("^start") then
      #        require("profile").start("*")
      #      else
      #        require("profile").instrument("*")
      #      end
      #    end
      #
      #    local function toggle_profile()
      #      local prof = require("profile")
      #      if prof.is_recording() then
      #        prof.stop()
      #        vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      #          if filename then
      #            prof.export(filename)
      #            vim.notify(string.format("Wrote %s", filename))
      #          end
      #        end)
      #      else
      #        prof.start("*")
      #      end
      #    end
      #    vim.keymap.set("", "<f1>", toggle_profile)
      #  '';
      #  type = "lua";
      #}

      # kitty scrollback support
      kitty-scrollback-nvim

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
      vim-sleuth
      eyeliner-nvim
      toggleterm-nvim
      plenary-nvim # telescope dependency
      telescope-nvim
      telescope-undo-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      gitsigns-nvim
      flash-nvim
      oil-nvim
      smart-open-nvim
      {
        # smartopen dependency
        plugin = sqlite-lua;
        # macOS: libsqlite3.dylib, other: libsqlite3.so
        config =
          "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.dylib'";
      }

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
      (rose-pine.overrideAttrs (_: {
        version = "main";
        src = pkgs.fetchFromGitHub {
          owner = "rose-pine";
          repo = "neovim";
          rev = "f977eeba34b030b37f93ece2fbd792477606203b";
          sha256 = "sha256-Zukzbs5ZQUjWutZK0oc1VHqFmUbvzWKtu6hb9EDFl9Y=";
        };
      }))
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
