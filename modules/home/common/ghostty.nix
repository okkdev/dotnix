{ lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    # Don't install ghostty on macOS (use system/homebrew installation)
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

    settings = {
      font-size = 11;
      bold-color = "bright";
      adjust-cell-height = "40%";

      window-padding-x = 15;
      window-padding-y = 10;
      window-padding-balance = true;
      window-theme = "auto";
      # window-decoration = "none";

      scrollback-limit = 100000000;

      keybind = [
        "ctrl+enter=unbind"
      ];
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      font-family = "Agave";

      # font-family = "Maple Mono";
      # font-family = "Departure Mono";
      # font-variation = "wght=500";
      # font-variation-italic = "wght=500";
      # font-feature = [
      #   "zero"
      #   "cv01"
      #   "cv02"
      #   "cv03"
      #   "ss03"
      #   "ss08"
      # ];

      theme = "dark:Zenbones Dark,light:Zenbones Light";

      font-size = 15;
      font-thicken = true;
      macos-titlebar-style = "hidden";
    };
  };
}
