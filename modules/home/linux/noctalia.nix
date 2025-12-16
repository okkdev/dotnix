{ inputs, lib, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "default";
        position = "top";
        showCapsule = true;
        backgroundOpacity = lib.mkForce 0.0;
        marginHorizontal = 4.0;
        marginVertical = 2.0;

        widgets = {
          left = [
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "Tray";
              colorizeIcons = false;
              blacklist = [ ];
            }
            {
              id = "Volume";
            }
            {
              id = "WiFi";
            }
            {
              id = "Battery";
              displayMode = "alwaysShow";
              warningThreshold = 20;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm ddd, MMM dd";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      location = {
        name = "Basel";
      };

      wallpaper.enabled = false;
      dock.enabled = false;
    };
  };
}
