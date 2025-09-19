{ lib, ... }:

with lib;
{
  xdg.configFile."ghostty/config" = {
    text = ''
      font-size = 14
      font-family = "Maple Mono"
      font-variation = wght=500
      font-variation-italic = wght=500
      font-feature = ${
        concatMapStrings (var: var + ", ") [
          "zero"
          "cv01"
          "cv02"
          "cv03"
          "ss03"
          "ss08"
        ]
      }
      font-thicken = false

      # fallback font
      font-family = "MapleMono Nerd Font"

      theme = dark:Zenbones Dark,light:Zenbones Light

      # custom-shader = shaders/party_sparks.glsl
      # custom-shader = shaders/cursor_smear_rainbow.glsl

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

  xdg.configFile."ghostty/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
