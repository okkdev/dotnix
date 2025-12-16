{ pkgs, lib, ... }:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./zen-browser.nix
    ./vicinae.nix
  ];

  home.packages = with pkgs; [
    # meta shizzle
    xwayland-satellite
    wtype

    # applications
    nautilus
    nautilus-open-any-terminal
    ungoogled-chromium
    slack
  ];

  programs = {
    fuzzel = {
      enable = true;
      settings = {
        main = {
          prompt = "\"⚡ \"";
          horizontal-pad = 20;
          vertical-pad = 15;
          inner-pad = 10;
        };
      };
    };

    swaylock.enable = true;
  };

  services = {
    mako.enable = true;
    udiskie.enable = true;
  };

  stylix.targets = {
    bat.enable = false;
    ghostty.enable = false;
    fish.enable = false;
    zen-browser.profileNames = [
      "jen"
    ];
  };
}
