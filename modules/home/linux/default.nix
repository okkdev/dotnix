{ config, pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./mail.nix
    ./zen-browser
  ];

  home.packages = with pkgs; [
    # meta stuff
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
    blender
    figma-linux
    hyprpicker
    (inkscape-with-extensions.override {
      inkscapeExtensions = with inkscape-extensions; [ inkstitch ];
    })
    kdePackages.okular
    # kdePackages.kdenlive
    kicad
    localsend
    moonlight-qt
    obsidian
    pixieditor
    popsicle
    ungoogled-chromium

    # virtualisation
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

    vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
      };
    };
  };

  services = {
    udiskie.enable = true;

    # hypridle, unlike swayidle, honors logind idle inhibitors (noctalia's caffeine)
    hypridle = {
      enable = true;
      systemdTarget = "niri.service";
      settings = {
        # no before-sleep: noctalia holds a logind sleep-delay inhibit and locks itself
        general.inhibit_sleep = 0;
        listener = [
          {
            timeout = 60 * 15;
            on-timeout = "${config.programs.niri.package}/bin/niri msg action power-off-monitors";
          }
          {
            timeout = 60 * 15;
            on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
          }
          {
            timeout = 60 * 30;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
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
