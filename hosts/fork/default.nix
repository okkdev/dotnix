{ username, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  # SYSTEM
  system.stateVersion = "25.11";

  # boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # emulation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];

  # networking
  networking.hostName = "fork";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };
  hardware.bluetooth.enable = true;

  # locale
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  # bios updates
  services.fwupd.enable = true;

  # keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
  # remap laptop keyboard (caps to ctrl, lalt <-> meta)
  services.udev.extraHwdb = ''
    evdev:atkbd:dmi:*
     KEYBOARD_KEY_3a=leftctrl
     KEYBOARD_KEY_38=leftmeta
     KEYBOARD_KEY_db=leftalt
  '';

  # power management
  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      IdleAction = "suspend";
      IdleActionSec = "30min";
    };
  };

  # security
  services.fprintd.enable = true;
  security = {
    pam.services = {
      swaylock = {
        unixAuth = true;
        fprintAuth = true;
      };

      login = {
        unixAuth = true;
        fprintAuth = true;
      };

      sudo.fprintAuth = true;
      "1password".fprintAuth = true;
      polkit-1.fprintAuth = true;
    };

    polkit.enable = true;
    soteria.enable = true;

    sudo.extraConfig = ''
      Defaults timestamp_timeout=30
      Defaults timestamp_type=global
    '';

    wrappers = {
      polkit-agent-helper-1 = {
        setuid = true;
        owner = "root";
        group = "root";
        source = "${pkgs.polkit.out}/lib/polkit-1/polkit-agent-helper-1";
      };
    };
  };

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # keep audio awake
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # virtualisation
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  # nix settings
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
    };

    optimise.automatic = true;
  };

  services.printing.enable = false;

  # users
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "podman"
      "docker"
      "lp"
    ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  # HOME
  home-manager.users.${username} = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "25.11";
    };

    programs.home-manager.enable = true;

    programs.fish.shellAliases = {
      nsw = "sudo nixos-rebuild switch --flake '.#fork'";
    };

    imports = map (x: ../../modules + x) [
      /home
      /home/linux
    ];
  };
}
