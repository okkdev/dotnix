{ config, pkgs, ... }:

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
    font = {
      name = "CommitMonoLiga Nerd Font";
      size = 14.5;
    };
    keybindings = {
      "kitty_mod+y" = "kitty_scrollback_nvim";
      "kitty_mod+g" =
        "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
      "kitty_mod+h" = "previous_tab";
      "kitty_mod+l" = "next_tab";
      "kitty_mod+ctrl+l" = "move_tab_forward";
      "kitty_mod+ctrl+h" = "move_tab_backward";
      "cmd+t" = "new_tab_with_cwd";
    };
    settings = {
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty.socket";
      background_opacity = "1";
      hide_window_decorations = "titlebar-only";
      window_padding_width = 20;
      adjust_line_height = "130%";
      disable_ligatures = "cursor";
      kitty_mod = "shift+cmd";
      macos_option_as_alt = "yes";
      macos_quit_when_last_window_closed = "yes";

      action_alias =
        "kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py --nvim-args -n";

      ## Performance
      # repaint_delay = 10;
      # sync_to_monitor = "no";
      input_delay = 2;

      # Tabs
      tab_bar_style = "fade";
      tab_powerline_style = "round";
      tab_fade = "0.5 1";
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      include current-theme.conf
      mouse_map kitty_mod+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';
  };
}
