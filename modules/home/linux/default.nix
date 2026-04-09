{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./vicinae.nix
    ./mail.nix
    ./zen-browser
  ];

  home.packages = with pkgs; [
    # meta stuff
    xwayland-satellite
    wl-mirror
    wl-clipboard
    openssl
    p11-kit
    alsa-ucm-conf
    inotify-tools
    gettext

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
    localsend

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
    swaylock.enable = true;
    imv.enable = true;
    mpv.enable = true;
    vesktop.enable = true;

    thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
    };

    iamb = {
      enable = false;
      settings = {
        default_profile = "user";
        profiles.user.user_id = "@jen:goo.garden";
        settings = {
          notifications.enabled = true;
          image_preview.protocol = {
            type = "kitty";
            size = {
              height = 10;
              width = 66;
            };
          };
        };
      };
    };
  };

  services = {
    udiskie.enable = true;

    swayidle = {
      enable = true;
      systemdTargets = [ "niri.service" ];
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
