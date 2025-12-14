{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./zen-browser.nix
  ];

  home.packages = with pkgs; [
    nautilus
    nautilus-open-any-terminal
    xwayland-satellite
  ];

  programs = {
    fuzzel.enable = true;
    swaylock.enable = true;
  };

  services = {
    mako.enable = true;
  };

  stylix.targets = {
    bat.colors.enable = false;
    ghostty.colors.enable = false;
    zen-browser.profileNames = [
      "jen"
    ];
  };
}
