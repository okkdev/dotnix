# Stylix bridge for noctalia v5.
{
  config,
  lib,
  ...
}:
let
  cfg = config.stylix;
in
lib.mkIf cfg.enable {
  programs.noctalia = {
    settings.theme = {
      source = "custom";
      custom_palette = "stylix";
      mode = if cfg.polarity == "light" then "light" else "dark";
    };

    customPalettes.stylix.dark = with config.lib.stylix.colors.withHashtag; {
      mPrimary = base0D;
      mOnPrimary = base00;
      mSecondary = base0E;
      mOnSecondary = base00;
      mTertiary = base0C;
      mOnTertiary = base00;
      mError = base08;
      mOnError = base00;
      mSurface = base00;
      mOnSurface = base05;
      mHover = base0C;
      mOnHover = base00;
      mSurfaceVariant = base01;
      mOnSurfaceVariant = base04;
      mOutline = base03;
      mShadow = base00;

      terminal = {
        foreground = base05;
        background = base00;
        cursor = base05;
        cursorText = base00;
        selectionFg = base05;
        selectionBg = base02;
        normal = {
          black = base00;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base05;
        };
        bright = {
          black = base03;
          red = base08;
          green = base0B;
          yellow = base0A;
          blue = base0D;
          magenta = base0E;
          cyan = base0C;
          white = base07;
        };
      };
    };

    settings = {
      shell.font_family = cfg.fonts.sansSerif.name;

      dock.background_opacity = cfg.opacity.desktop;
      osd.background_opacity = cfg.opacity.popups;
      notification.background_opacity = cfg.opacity.popups;

      wallpaper.default.path = "${cfg.image}";
    };
  };
}
