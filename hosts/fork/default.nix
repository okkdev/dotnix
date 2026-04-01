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
  boot.loader.systemd-boot.configurationLimit = 20;

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # emulation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
      HandleLidSwitch = "suspend-then-hibernate";
    };
  };

  # swap for hibernation
  fileSystems."/swap" = {
    device = "/dev/mapper/luks-cfa0fd3d-bc04-4a78-b19c-81a6b412ff17";
    fsType = "btrfs";
    options = [
      "subvol=@swap"
      "noatime"
    ];
  };
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 48 * 1024;
    }
  ];
  boot.resumeDevice = "/dev/mapper/luks-cfa0fd3d-bc04-4a78-b19c-81a6b412ff17";
  boot.kernelParams = [ "resume_offset=55234149" ];
  systemd.sleep.extraConfig = ''
    AllowSuspendThenHibernate=yes
    HibernateDelaySec=90min
  '';

  # security
  services.fprintd.enable = true;
  security = {
    pam.services =
      let
        fprintAuth = {
          fprintAuth = true;
          rules.auth.fprintd.args = [ "timeout=5" ];
        };
      in
      {
        swaylock = fprintAuth;
        login = fprintAuth;
        sudo = fprintAuth;
        "1password" = fprintAuth;
        polkit-1 = fprintAuth;
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
      "kvm"
      "adbusers"
      "dialout"
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
