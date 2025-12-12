{ ... }:

{
  home = {
    username = "js";
    homeDirectory = "/Users/js";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  programs.fish.shellAliases = {
    nsw = "home-manager switch --flake '.#boook'";
  };

  imports = map (x: ../../modules + x) [
    /darwin

    /home
    /home/programs/fish.nix
    /home/programs/git.nix
    /home/programs/jujutsu.nix
    /home/programs/ghostty
    /home/programs/neovim
    /home/programs/helix.nix
  ];
}
