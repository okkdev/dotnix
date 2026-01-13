{ inputs, lib, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "default";
        position = "top";
        showCapsule = false;
        marginHorizontal = 0.50;
        marginVertical = 0.15;
        # backgroundOpacity = lib.mkForce 0.0;
        useSeparateOpacity = false;
        floating = false;

        notifications = {
          saveToHistory.low = false;
        };

        widgets = {
          left = [
            {
              id = "ActiveWindow";
              maxWidth = 250;
            }
            {
              id = "MediaMini";
              maxWidth = 300;
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
              id = "Network";
            }
            {
              id = "VPN";
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
