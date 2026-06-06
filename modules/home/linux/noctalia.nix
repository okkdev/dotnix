{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    settings = {

      # capsules
      bar.backgroundOpacity = lib.mkForce 0.0;
      bar.useSeparateOpacity = true;
      bar.showCapsule = true;
      ui.panelsAttachedToBar = false;
      general.enableShadows = false;

      # solid
      # bar.showCapsule = false;

      general = {
        animationSpeed = 1.5;
      };

      bar = {
        density = "default";
        position = "top";
        marginHorizontal = 0.50;
        marginVertical = 0.15;

        colorSchemes.darkMode = config.stylix.polarity == "dark";

        notifications = {
          saveToHistory.low = false;
        };

        widgets = {
          left = [
            {
              id = "ActiveWindow";
              colorizeIcons = false;
              maxWidth = 400;
            }
            {
              id = "MediaMini";
              maxWidth = 400;
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
              displayMode = "graphic";
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
