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
        marginHorizontal = 0.50;
        marginVertical = 0.15;
        floating = true;

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
              id = "Tray";
              colorizeIcons = false;
              blacklist = [ ];
            }
            {
              id = "NotificationHistory";
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

      wallpaper.enabled = true;
      dock.enabled = false;
    };
  };
}
