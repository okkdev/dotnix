{ config, pkgs, lib, ... }:

with lib; {
  home = {
    username = "js";
    homeDirectory = "/Users/js";
    stateVersion = "22.05";
    sessionVariables = {
      ERL_AFLAGS = "-kernel shell_history enabled";
      ELIXIR_EDITOR = "code --goto __FILE__:__LINE__";
      EDITOR = "nvim";
      BAT_THEME = "ansi";
    };
    file.".hushlogin".text = "";
  };

  programs.home-manager.enable = true;

  imports = map (x: ./config + x) [
    /macos.nix
    /packages.nix
    /homebrew.nix
    /programs/shell.nix
    /programs/git.nix
    /programs/kitty.nix
    /programs/yabai.nix
  ];
}
