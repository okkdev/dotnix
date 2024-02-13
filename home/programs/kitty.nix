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
      [ "--single-instance" "--directory=~" "--listen-on=unix:/tmp/mykitty" ];
    font = {
      name = "CommitMonoLiga Nerd Font";
      size = 14.5;
    };
    settings = {
      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = "yes";
      allow_remote_control = "yes";
      window_padding_width = 20;
      adjust_line_height = "130%";
      background_opacity = "1";
      listen_on = "unix:/tmp/mykitty";
      disable_ligatures = "cursor";

      ## Performance
      # repaint_delay = 10;
      # sync_to_monitor = "no";
      input_delay = 2;
    };
    shellIntegration.enableFishIntegration = true;
    extraConfig = "include current-theme.conf";
  };
}
