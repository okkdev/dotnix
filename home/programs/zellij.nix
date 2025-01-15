{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    # enableFishIntegration = true;
    settings = {
      theme = "ansi";
      default_mode = "locked";
      pane_frames = false;

      keybinds = {
        normal = {
          unbind = "Ctrl g";
          bind = {
            _args = [ "Ctrl a" ];
            SwitchToMode = "locked";
          };
        };

        locked = {
          unbind = "Ctrl g";
          bind = {
            _args = [ "Ctrl a" ];
            SwitchToMode = "normal";
          };
        };
      };
    };
  };

  # xdg.configFile."zellij/config.kdl" = {
  #   text =
  #     # kdl
  #     ''
  #       theme = "ansi"
  #     '';
  # };
}
