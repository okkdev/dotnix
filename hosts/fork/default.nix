{ pkgs, ... }:

let
  username = "jen";
in
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

  # networking
  networking.hostName = "fork";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # locale
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  # bios updates
  services.fwupd.enable = true;

  # X11 config so maybe not needed?
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # power management
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # security
  security.pam.services.swaylock = {
    enable = true;

    # Using `fprintAuth = true` does not allow password-only unlocking
    text = ''
      auth sufficient pam_unix.so
      auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so
      auth required pam_deny.so
    '';
  };

  # nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # users
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
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
