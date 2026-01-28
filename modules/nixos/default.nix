{ username, pkgs, ... }:
{
  imports = [
    ./stylix.nix
    ./cyon.nix
  ];

  networking.wireguard.enable = true;

  # enable niri and disable kde polkit agent
  programs.niri.enable = true;
  systemd.user.services.niri-flake-polkit.enable = false;

  # make bash available at /bin/bash
  system.activationScripts.binbash = ''
    mkdir -p /bin
    ln -sf ${pkgs.bash}/bin/bash /bin/bash
  '';

  xdg.portal = {
    enable = true;
    # niri portals
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gtk" ];
  };

  services = {
    displayManager.ly = {
      enable = true;
      x11Support = false;
    };

    openssh = {
      enable = false;
      ports = [ 1337 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = username;
      group = "users";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };

    # needed for xdg portal niri
    gnome.gnome-keyring.enable = true;

    udisks2.enable = true;
    hardware.bolt.enable = true;
  };

  programs = {
    zoom-us.enable = true;

    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ username ];
    };

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    nix-ld.enable = true;
  };

  # allow 1password extension in zen
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      zen
      .zen-wrapped
      .zen-beta-wrapped
    '';
    mode = "0755";
  };
}
