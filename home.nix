{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "js";
  home.homeDirectory = "/Users/js";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    sessionPath = [ "/opt/homebrew/bin" ];
    sessionVariables = {
      ERL_AFLAGS = "-kernel shell_history enabled";
    };
  };

  home.packages = with pkgs; [
    # Tools
    neovim
    neofetch
    exa

    # Programming
    yarn
    beam.interpreters.erlangR24
    beam.packages.erlangR24.elixir_1_12
    nodejs-16_x
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ".direnv" ];
    userName = "okkdev";
    userEmail = "dev@stehlik.me";
    includes = [
      {
        condition = "gitdir:~/Documents/git/work/";
        contents = {
          user.name = "js";
          user.email = "js@cyon.ch";
        };
      }
    ];
    aliases = {
      s = "status";
      p = "pull";
      a = "add";
      aa = "add .";
      c = "commit";
      cm = "commit -m";
      pp = "push";
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.sshCommand = "/usr/bin/ssh";
    };
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
      source /opt/homebrew/opt/asdf/libexec/asdf.fish

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
