{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./vicinae.nix

    ./zen-browser
  ];

  home.packages = with pkgs; [
    # meta stuff
    xwayland-satellite
    wtype
    wl-mirror
    wl-clipboard
    openssl
    p11-kit
    alsa-ucm-conf
    inotify-tools

    # core applications
    gedit
    gnome-disk-utility
    nautilus
    nautilus-open-any-terminal
    networkmanagerapplet
    pwvucontrol
    sushi

    # applications
    figma-linux
    hyprpicker
    # kdePackages.kdenlive
    kdePackages.okular
    kicad
    obsidian
    pixieditor
    popsicle
    orca-slicer
    slack
    spotify
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
    udiskie.enable = true;

    swayidle = {
      enable = true;
      systemdTarget = "niri.service";
      events = {
        "before-sleep" = "${pkgs.swaylock}/bin/swaylock -fF";
      };
      timeouts = [
        {
          timeout = 60 * 15;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        }
        {
          timeout = 60 * 15;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 60 * 30;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
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
