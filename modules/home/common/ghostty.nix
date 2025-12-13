{ lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    # Don't install ghostty on macOS (use system/homebrew installation)
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    settings = {
      font-size = 14;
      # font-family = "Maple Mono";
      font-family = "Departure Mono";
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
      font-thicken = true;
      bold-is-bright = true;

      # fallback font
      # font-family = "MapleMono Nerd Font";

      theme = "dark:Zenbones Dark,light:Zenbones Light";

      adjust-cell-height = "40%";

      window-padding-x = 20;
      window-padding-y = 20;
      window-padding-balance = true;
      window-theme = "auto";
      macos-titlebar-style = "hidden";

      keybind = [
        "super+shift+h=previous_tab"
        "super+shift+l=next_tab"
        "super+shift+ctrl+h=move_tab:-1"
        "super+shift+ctrl+l=move_tab:+1"
      ];
    };
  };
}
