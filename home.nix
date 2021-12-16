{ config, pkgs, lib, ... }:

with lib; {
  home = {
    username = "js";
    homeDirectory = "/Users/js";
    stateVersion = "22.05";
    sessionVariables = {
      ERL_AFLAGS = "-kernel shell_history enabled";
      EDITOR = "neovim";
    };
    file.".hushlogin".text = "";
  };

  programs.home-manager.enable = true;

  imports = map (x: ./config + x) [
    /packages.nix
    /homebrew.nix
    /programs/shell.nix
    /programs/git.nix
  ];
}
