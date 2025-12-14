{ inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

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
