{ ... }:

{
  home = {
    username = "jen.stehlik";
    homeDirectory = "/Users/jen.stehlik";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    shellAliases = {
      nsw = "home-manager switch --flake '.#dreibook'";
    };
    shellInit = ''
      set -gx DREIC_DIR "/Users/jen.stehlik/code/dreipol/_meta/dreiC"
      set -gx DREIC_USER_TYPE technical
    '';
  };

  imports = map (x: ../../modules + x) [
    /home
    /home/darwin
  ];
}
