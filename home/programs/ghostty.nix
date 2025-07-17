{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  xdg.configFile."ghostty/config" = {
    text = ''
      font-size = 14
      font-family = "Maple Mono"
      font-variation = wght=500
      font-variation-italic = wght=500
      ${concatMapStrings (var: "font-feature = " + var + "\n") [
        "zero"
        "cv01"
        "cv02"
        "cv03"
        "ss03"
        "ss08"
      ]}
      font-thicken = false

      # fallback font
      font-family = "MapleMono Nerd Font"

      theme = dark:zenbones_dark,light:zenbones_light

      adjust-cell-height = 40%

      window-padding-x = 20
      window-padding-y = 20
      window-padding-balance = true
      window-theme = auto
      macos-titlebar-style = hidden

      keybind = super+shift+h=previous_tab
      keybind = super+shift+l=next_tab
      keybind = super+shift+ctrl+h=move_tab:-1
      keybind = super+shift+ctrl+l=move_tab:+1
    '';
  };
}
