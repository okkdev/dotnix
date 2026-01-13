{ pkgs, ... }:
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
    wl-mirror
    openssl

    # applications
    nautilus
    nautilus-open-any-terminal
    gedit
    pavucontrol
    kdePackages.okular
    ungoogled-chromium
    slack
    spotify
    kicad
    hyprpicker
    networkmanagerapplet
    pixieditor
    podman-desktop
    podman-compose
    docker-compose
    orca-slicer
    obsidian
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
    imv.enable = true;
    mpv.enable = true;
    vesktop.enable = true;
  };

  services = {
    # mako.enable = true;
    udiskie.enable = true;
    network-manager-applet.enable = true;
  };
}
