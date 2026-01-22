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
    wl-clipboard
    openssl

    # applications
    figma-linux
    gedit
    gnome-disk-utility
    hyprpicker
    kdePackages.kdenlive
    kdePackages.okular
    kicad
    nautilus
    nautilus-open-any-terminal
    networkmanagerapplet
    obsidian
    orca-slicer
    pwvucontrol
    pixieditor
    popsicle
    slack
    spotify
    sushi
    ungoogled-chromium

    # virtualisation
    docker-compose
    podman-compose
    podman-desktop

    # office
    libreoffice-qt6
    hunspell
    hunspellDicts.de_CH
    hunspellDicts.en_US
  ];

  programs = {
    # fuzzel = {
    #   enable = true;
    #   settings = {
    #     main = {
    #       prompt = "\"⚡ \"";
    #       horizontal-pad = 20;
    #       vertical-pad = 15;
    #       inner-pad = 10;
    #     };
    #   };
    # };

    swaylock.enable = true;
    imv.enable = true;
    mpv.enable = true;
    vesktop.enable = true;
  };

  services = {
    # mako.enable = true;
    udiskie.enable = true;

    swayidle = {
      enable = true;
      systemdTarget = "niri.service";
      events = {
        "before-sleep" = "${pkgs.swaylock}/bin/swaylock -fF";
      };
    };
  };

  # add hyprpicker to launcher
  xdg.desktopEntries.hyprpicker = {
    name = "Hyprpicker";
    comment = "Color picker for Wayland";
    exec = "hyprpicker -a";
    icon = "color-select-symbolic";
    terminal = false;
    categories = [
      "Utility"
      "Graphics"
    ];
  };
}
