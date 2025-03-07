{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  programs.kitty = {
    enable = true;
    # workaround to use homebrew kitty
    package = pkgs.runCommand "kitty" { } ''
      mkdir -p $out/bin
      ln -s /opt/homebrew/bin/kitty $out/bin/kitty
    '';
    darwinLaunchOptions = [
      "--single-instance"
      "--directory=~"
      "--listen-on=unix:/tmp/kitty.socket"
    ];
    keybindings = {
      "kitty_mod+h" = "previous_tab";
      "kitty_mod+l" = "next_tab";
      "kitty_mod+ctrl+l" = "move_tab_forward";
      "kitty_mod+ctrl+h" = "move_tab_backward";
      "cmd+t" = "new_tab_with_cwd";
    };
    settings = {
      font_family = "Maple Mono NF";
      bold_font = "Maple Mono NF SemiBold";
      italic_font = "Maple Mono NF Italic";
      bold_italic_font = "Maple Mono NF SemiBold Italic";
      font_size = 14;

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty.socket";
      background_opacity = "1";
      hide_window_decorations = "titlebar-only";
      window_padding_width = 20;
      adjust_line_height = "130%";
      disable_ligatures = "cursor";
      kitty_mod = "shift+cmd";
      # macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";

      ## Performance
      # repaint_delay = 10;
      # sync_to_monitor = "no";
      input_delay = 2;

      cursor_trail = 1;
      cursor_trail_decay = "0.01 0.09";

      # Tabs
      tab_bar_style = "fade";
      tab_fade = "0.5 1";
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      ${concatMapStrings
        (var: "font_features MapleMono-NF-" + var + " +zero +cv01 +cv02 +cv03 +ss03 +ss08\n")
        ([
          "Regular"
          "SemiBold"
          "SemiBoldItalic"
          "Italic"
        ])
      }

      include current-theme.conf
    '';
  };
}
