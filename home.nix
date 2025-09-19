{
  ...
}:

{
  home = {
    username = "js";
    homeDirectory = "/Users/js";
    stateVersion = "23.05";
    sessionVariables = {
      ERL_AFLAGS = "-kernel shell_history enabled";
    };
  };

  programs.home-manager.enable = true;

  imports = map (x: ./home + x) [
    /packages.nix
    /darwin.nix
    /homebrew.nix
    /programs/shell.nix
    /programs/git.nix
    /programs/jujutsu.nix
    /programs/ghostty
    /programs/yabai.nix
    /programs/neovim
    # /programs/tmux.nix
    # /programs/zellij.nix
    /programs/helix.nix
    /programs/sketchybar
  ];
}
