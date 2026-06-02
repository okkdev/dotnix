{ ... }:

{
  home = {
    username = "jen.stehlik";
    homeDirectory = "/Users/jen.stehlik";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  programs.fish.shellAliases = {
    nsw = "home-manager switch --flake '.#dreibook'";
  };

  imports = map (x: ../../modules + x) [
    /home
    /home/darwin
  ];
}
