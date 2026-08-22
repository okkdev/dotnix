{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # workaround noctalia v5 needs a wallpaper folder now
  wallpaperDir = pkgs.runCommand "noctalia-wallpaper" { } ''
    mkdir -p $out
    cp ${config.stylix.image} $out/
  '';
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {

      shell = {
        settings_show_advanced = true;
        animation.speed = 1.5;

        panel = {
          shadow = false;
          control_center_placement = "floating";
          open_near_click_control_center = true;
          wallpaper_placement = "centered";
          session_placement = "centered";
        };
      };

      bar.main = {
        position = "top";

        background_opacity = lib.mkForce 0.0;
        capsule = true;

        shadow = false;

        margin_edge = 4;
        margin_ends = 6;

        start = [
          "active_window"
          "media"
        ];
        center = [
          "workspaces"
        ];
        end = [
          "volume"
          "network"
          "battery"
          "clock"
          "tray"
          "notifications"
          "control-center"
        ];
      };

      widget = {
        active_window.max_length = 400;
        media = {
          max_length = 400;
          hide_when_no_media = true;
        };
        workspaces.display = "none";
        battery.display_mode = "graphic";
        clock.format = "{:%H:%M %a, %b %d}";
        tray = {
          drawer = true;
          detached_panel = true;
        };
      };

      battery.warning_threshold = 20;

      control_center.sidebar_section = "none";

      location.address = "Basel";

      wallpaper.enabled = true;
      wallpaper.directory = "${wallpaperDir}";
      dock.enabled = false;

      desktop_widgets.enabled = false;

      lockscreen.enabled = true;
      lockscreen.fingerprint = true;
      lockscreen_widgets.enabled = false;
    };
  };
}
