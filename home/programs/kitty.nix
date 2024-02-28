{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # workaround to use homebrew kitty
    package = pkgs.runCommand "kitty" { } ''
      mkdir -p $out/bin
      ln -s /opt/homebrew/bin/kitty $out/bin/kitty
    '';
    darwinLaunchOptions =
      [ "--single-instance" "--directory=~" "--listen-on=unix:/tmp/kitty" ];
    font = {
      name = "CommitMonoLiga Nerd Font";
      size = 14.5;
    };
    keybindings = {
      # Kitty scrollback nvim
      "kitty_mod+h" = "kitty_scrollback_nvim";
      "kitty_mod+g" =
        "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
    };
    settings = {
      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = "yes";
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
      window_padding_width = 20;
      adjust_line_height = "130%";
      background_opacity = "1";
      disable_ligatures = "cursor";
      kitty_mod = "shift+cmd";

      action_alias =
        "kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py --nvim-args -n";

      ## Performance
      # repaint_delay = 10;
      # sync_to_monitor = "no";
      input_delay = 2;
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      include current-theme.conf
      mouse_map kitty_mod+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
    '';
  };
}
