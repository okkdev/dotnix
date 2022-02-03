{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # workaround to use homebrew kitty
    package = pkgs.writeShellScriptBin "_kitty" "kitty";
    darwinLaunchOptions = [
      "--single-instance"
      "--directory=~"
    ];
    font = {
      name = "FantasqueSansMono Nerd Font";
      size = 15;
    };
    settings = {
      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = "yes";
      allow_remote_control = "yes";
      window_padding_width = 20;
      adjust_line_height = "120%";
      macos_thicken_font = "0.5";
      background_opacity = "0.95";
    };
    extraConfig = "include current-theme.conf";
  };
}
