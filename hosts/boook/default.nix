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
    /home
    /home/darwin
  ];
}
