{ username, pkgs, ... }:
{
  imports = [
    ./wireguard.nix
    ./stylix.nix
  ];

  services = {
    displayManager.ly = {
      enable = true;
      x11Support = false;
    };

    udisks2.enable = true;
  };

  programs = {
    niri.enable = true;
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
  };
}
