{ username, ... }:
{
  imports = [
    ./stylix.nix
    ./wireguard.nix
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
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ username ];
    };
    zoom-us.enable = true;
  };
}
