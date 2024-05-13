{
  config,
  pkgs,
  lib,
  ...
}:

let
  lua-config = pkgs.stdenv.mkDerivation {
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
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      fzf
      tree-sitter
      fd
    ];
    plugins = with pkgs.vimPlugins; [
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
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ts-context-commentstring

      # lsp and completions
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-cmdline
      cmp-path
      cmp-tailwind-colors

      # snippets
      luasnip
      cmp_luasnip
      friendly-snippets

      # formatter
      conform-nvim

      # plugin dependency
      plenary-nvim

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
      (harpoon.overrideAttrs (_: {
        version = "2";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "harpoon";
          rev = "0378a6c428a0bed6a2781d459d7943843f374bce";
          sha256 = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
        };
      }))

      # ui framework
      nui-nvim

      # icons
      nvim-web-devicons
      lspkind-nvim

      # ui elements
      alpha-nvim
      noice-nvim
      nvim-notify
      bg-nvim
      no-neck-pain-nvim

      # themes
      rose-pine
      everforest-nvim
      catppuccin-nvim
      neovim-ayu
      oxocarbon-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = lua-config;
    recursive = true;
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
