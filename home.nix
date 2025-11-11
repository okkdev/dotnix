{
  ...
}:

{
  home = {
    username = "js";
    homeDirectory = "/Users/js";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  imports = map (x: ./home + x) [
    /packages.nix
    /darwin
    /programs/fish.nix
    /programs/git.nix
    /programs/jujutsu.nix
    /programs/ghostty
    /programs/neovim
    /programs/helix.nix
  ];
}
