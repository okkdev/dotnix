{ ... }:
{
  programs.zen-browser = {
    enable = true;

    profiles = {
      jen = {
      };
    };
  };

  stylix.targets.zen-browser.profileNames = [
    "jen"
  ];
}
