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
    mako.enable = true;
    fuzzel.enable = true;
    swaylock.enable = true;
  };
}
