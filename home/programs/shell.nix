{ config, pkgs, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global = { load_dotenv = true; };
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
          sha256 = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "79b62958ecf4e87334f24d6743e5766475bcf4d0";
          sha256 = "sha256-3d/qL+hovNA4VMWZ0n1L+dSM1lcz7P5CQJyy+/8exTc=";
        };
      }
      {
        name = "puffer-fish";
        src = pkgs.fetchFromGitHub {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "41721259f16b9695d582a8de8d656d4e429d7eea";
          sha256 = "sha256-TdGyrAlL7aMxNtemxzOwTaOI+bbQ4zML2N2tV300FM8=";
        };
      }
    ];
    loginShellInit =
      "fish_add_path --move --prepend --path $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin";
    shellInit = ''
      fish_add_path /opt/homebrew/sbin
      fish_add_path /opt/homebrew/bin
      fish_add_path $HOME/.ghcup/bin
      fish_add_path $HOME/.cabal/bin
      fish_add_path $HOME/.cargo/bin

      if test -d (brew --prefix)"/share/fish/completions"
          set -gx fish_complete_path (brew --prefix)/share/fish/completions $fish_complete_path 
      end

      if test -d (brew --prefix)"/share/fish/vendor_completions.d"
          set -gx fish_complete_path (brew --prefix)/share/fish/vendor_completions.d $fish_complete_path 
      end

      set -g hydro_symbol_prompt "$(shell_level)$(tput bold)➜$(tput sgr0)"
      set -U hydro_multiline true
    '';
    shellAbbrs = {
      top = "btm";
      npm = "pnpm";
      du = "dust";
    };
    shellAliases = {
      ssh = "TERM=xterm-256color /usr/bin/ssh";
      nvim = "nvim --listen /tmp/nvim.socket";
      vim = "nvim";
      vi = "nvim";
    };
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "echo 🐟";
      };
      shell_level = {
        description = "show the current shell level as icon";
        body = ''
          switch (math "$SHLVL - 1")
            case 0
                echo " "
            case 1
                echo ⋅
            case 2
                echo ∶
            case 3
                echo ∴
            case 4
                echo ∷
            case '*'
                echo (math "$SHLVL - 1")
          end
        '';
      };
      ns = {
        description = "nix shell shorthand";
        body = ''
          if test (count $argv) -eq 0
              echo "Error: Please provide at least one package name"
              return 1
          end

          set nix_shell_cmd "nix shell"

          for pkg in $argv
              set nix_shell_cmd "$nix_shell_cmd nixpkgs#$pkg"
          end

          eval $nix_shell_cmd
        '';
      };
      os_theme = {
        description = "get the current appearance mode of the system";
        body = ''
          if [ (defaults read -g AppleInterfaceStyle 2> /dev/null) ]
            echo "dark"
          else
            echo "light"
          end
        '';
      };
      switch_theme = {
        argumentNames = "mode";
        description = "switches global theme";
        body = ''
          if [ "$mode" = "dark" ]
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" > /dev/null
            switch_kitty_theme "Rosé Pine"
            nvim --server /tmp/nvim.socket --remote-send ':DarkTheme<CR>'
            echo "Switched to Dark Theme"
          else if [ "$mode" = "light" ]
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" > /dev/null
            switch_kitty_theme "Rosé Pine Dawn"
            nvim --server /tmp/nvim.socket --remote-send ':LightTheme<CR>'
            echo "Switched to Light Theme"
          else
            if [ (os_theme) = "dark" ]
              switch_theme "light"
            else
              switch_theme "dark"
            end
          end
        '';
      };
      switch_kitty_theme = {
        argumentNames = "theme_name";
        description = "changes the kitty terminal theme";
        body = ''
          if [ -z "$theme_name" ]
            echo "please pass a theme as argument"
            return
          end

          set -l current_theme (realpath ~/.config/kitty/current-theme.conf)

          if kitty +kitten themes --dump-theme $theme_name > $current_theme
            kitty @ --to unix:/tmp/kitty.socket set-colors -a -c $current_theme
          else
            echo "theme not found"
          end
        '';
      };
      fish_terminal_colors = {
        description = "set fish colors to use terminal colors";
        body =
          "  # Syntax highlighting variables\n  # https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables\n  set -U fish_color_normal normal\n  set -U fish_color_command magenta\n  set -U fish_color_keyword blue\n  set -U fish_color_quote yellow\n  set -U fish_color_redirection green\n  set -U fish_color_end brblack\n  set -U fish_color_error red\n  set -U fish_color_param cyan\n  set -U fish_color_comment brblack\n  set -U fish_color_selection --reverse\n  set -U fish_color_operator normal\n  set -U fish_color_escape green\n  set -U fish_color_autosuggestion brblack\n  set -U fish_color_cwd cyan\n  set -U fish_color_user yellow\n  set -U fish_color_host blue\n  set -U fish_color_host_remote magenta\n  set -U fish_color_cancel normal\n  set -U fish_color_search_match --background=black\n\n  # Pager color variables\n  # https://fishshell.com/docs/current/interactive.html#pager-color-variables\n  set -U fish_pager_color_progress cyan\n  set -U fish_pager_color_background\n  set -U fish_pager_color_prefix blue\n  set -U fish_pager_color_completion normal\n  set -U fish_pager_color_description normal\n  set -U fish_pager_color_selected_background --reverse\n  set -U fish_pager_color_selected_prefix\n  set -U fish_pager_color_selected_completion\n  set -U fish_pager_color_selected_description\n  set -U fish_pager_color_secondary_background\n  set -U fish_pager_color_secondary_prefix blue\n  set -U fish_pager_color_secondary_completion normal\n  set -U fish_pager_color_secondary_description normal\n";
      };
    };
  };
}
