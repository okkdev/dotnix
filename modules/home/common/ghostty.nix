{ lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    # Don't install ghostty on macOS (use system/homebrew installation)
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    settings = {
      font-size = if pkgs.stdenv.isDarwin then 14 else 11;
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
      bold-color = "bright";

      # macOS stuff
      font-thicken = true;
      macos-titlebar-style = "hidden";

      # fallback font
      # font-family = "MapleMono Nerd Font";

      # theme = "dark:Zenbones Dark,light:Zenbones Light";

      adjust-cell-height = "40%";

      window-padding-x = 15;
      window-padding-y = 10;
      window-padding-balance = true;
      window-theme = "auto";
      window-decoration = "none";

      keybind = [
        "ctrl+enter=unbind"
      ];
    };
  };
}
