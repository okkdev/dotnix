{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config.global = {
      load_dotenv = true;
    };
  };

  programs.fzf.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
        };
      }
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "383cdd905f5723f1805362185ad17ab7e7f48bff";
          sha256 = "1vlh273nxa5r79p1nw061l5y2cbip04v64027xjgbh2wzjnqy9xr";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "2fd3d2157d5271ca3575b13daec975ca4c10577a";
          sha256 = "0mb01y1d0g8ilsr5m8a71j6xmqlyhf8w4xjf00wkk8k41cz3ypky";
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
    shellInit = ''
      #source /opt/homebrew/opt/asdf/libexec/asdf.fish

      if test -d (brew --prefix)"/share/fish/completions"
          set -gx fish_complete_path (brew --prefix)/share/fish/completions $fish_complete_path 
      end

      if test -d (brew --prefix)"/share/fish/vendor_completions.d"
          set -gx fish_complete_path (brew --prefix)/share/fish/vendor_completions.d $fish_complete_path 
      end

      fish_add_path /opt/homebrew/sbin
      fish_add_path /opt/homebrew/bin

      fish_add_path /Users/js/.ghcup/bin
      fish_add_path $HOME/.cabal/bin

      fish_terminal_colors
      set --global hydro_symbol_prompt " ➜"
      set --global hydro_multiline true

      direnv hook fish | source
    '';
    shellAbbrs = {
      top = "btm";
      npm = "pnpm";
    };
    shellAliases = {
      ssh = "TERM=xterm-256color /usr/bin/ssh";
      ll = "exa -abhl --icons --group-directories-first";
    };
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "echo 🐟";
      };
      switch_theme = {
        argumentNames = "mode";
        description = "switches global theme";
        body = ''
          if [ "$mode" = "dark" ]
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true"
            switch_kitty_theme "Kaolin Temple"
          else if [ "$mode" = "light" ]
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false"
            switch_kitty_theme "Kaolin Light"
          else
            if [ (osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode()") = "true" ]
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
            kitty @ --to unix:/tmp/mykitty set-colors -a -c $current_theme
          else
            echo "theme not found"
            return
          end
        '';
      };
      fish_terminal_colors = {
        description = "set fish colors to use terminal colors";
        body = ''
          	  # Syntax highlighting variables
          	  # https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables
          	  set -U fish_color_normal normal
          	  set -U fish_color_command magenta
          	  set -U fish_color_keyword blue
          	  set -U fish_color_quote yellow
          	  set -U fish_color_redirection green
          	  set -U fish_color_end brblack
          	  set -U fish_color_error red
          	  set -U fish_color_param cyan
          	  set -U fish_color_comment brblack
          	  set -U fish_color_selection --reverse
          	  set -U fish_color_operator normal
          	  set -U fish_color_escape green
          	  set -U fish_color_autosuggestion brblack
          	  set -U fish_color_cwd cyan
          	  set -U fish_color_user yellow
          	  set -U fish_color_host blue
          	  set -U fish_color_host_remote magenta
          	  set -U fish_color_cancel normal
          	  set -U fish_color_search_match --background=black

          	  # Pager color variables
          	  # https://fishshell.com/docs/current/interactive.html#pager-color-variables
          	  set -U fish_pager_color_progress cyan
          	  set -U fish_pager_color_background
          	  set -U fish_pager_color_prefix blue
          	  set -U fish_pager_color_completion normal
          	  set -U fish_pager_color_description normal
          	  set -U fish_pager_color_selected_background --reverse
          	  set -U fish_pager_color_selected_prefix
          	  set -U fish_pager_color_selected_completion
          	  set -U fish_pager_color_selected_description
          	  set -U fish_pager_color_secondary_background
          	  set -U fish_pager_color_secondary_prefix blue
          	  set -U fish_pager_color_secondary_completion normal
          	  set -U fish_pager_color_secondary_description normal
          	'';
      };
    };
  };
}
