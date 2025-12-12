{ config, pkgs, ... }:

let
  username = "jen";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # SYSTEM

  # boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "fork";
  networking.networkmanager.enable = true;

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

  # nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  system.stateVersion = "25.11";

  # HOME

  home-manager.users.${username} = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "25.11";
    };

    programs.home-manager.enable = true;

    programs.fish.shellAliases = {
      switch = "sudo nixos-rebuild switch --flake '.#fork'";
    };

    imports = map (x: ../../modules + x) [
      # Common home configuration
      /home

      # Cross-platform programs
      /home/programs/fish.nix
      /home/programs/git.nix
      /home/programs/jujutsu.nix
      # /home/programs/ghostty
      /home/programs/neovim
      # /home/programs/helix.nix
    ];
  };
}
