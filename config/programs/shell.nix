{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
          rev = "cf7b19842f03bc4df27f9281badfc2828c02b56a";
          sha256 = "sha256-d2ioK4smwYd49WP4Esd2jRaS82NzVFzi/Ljhy+QbFPc=";
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

      direnv hook fish | source
    '';
    shellAbbrs = {
      vim = "nvim";
      vi = "nvim";
    };
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "echo 🐟";
      };
      ll = {
        wraps = "exa";
        description = "List contents of directory using long format";
        body = "exa -abhl --icons --group-directories-first $argv";
      };
    };
  }; 
}
