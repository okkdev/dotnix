{ ... }:
{
  imports = [
    ./stylix.nix
  ];

  services.displayManager.ly = {
    enable = true;
    x11Support = false;
  };

  programs = {
    niri.enable = true;
  };
}
