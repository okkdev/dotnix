{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
{
  xdg.configFile."yabai/yabairc" = {
    executable = true;
    text =
      # sh
      ''
        #!/usr/bin/env sh

        # global settings
        yabai -m config mouse_follows_focus          on
        yabai -m config focus_follows_mouse          off
        yabai -m config window_origin_display        default
        yabai -m config window_placement             second_child
        yabai -m config split_ratio                  0.50
        yabai -m config auto_balance                 off
        yabai -m config display_arrangement_order    default

        ## SIP stuff
        # yabai -m config window_topmost               off
        # yabai -m config window_shadow                on
        # yabai -m config window_opacity               off
        # yabai -m config window_opacity_duration      0.0
        # yabai -m config active_window_opacity        1.0
        # yabai -m config normal_window_opacity        0.90
        # yabai -m config window_border                off
        # yabai -m config window_border_width          6
        # yabai -m config active_window_border_color   0xff775759
        # yabai -m config normal_window_border_color   0xff555555
        # yabai -m config insert_feedback_color        0xffd75f5f

        # mouse
        #yabai -m config mouse_modifier               alt
        yabai -m config mouse_action1                move
        yabai -m config mouse_action2                resize
        yabai -m config mouse_drop_action            swap

        # general space settings
        yabai -m config layout                       bsp
        yabai -m config external_bar                 all:40:0
        yabai -m config bottom_padding               20
        yabai -m config left_padding                 20
        yabai -m config right_padding                20
        yabai -m config window_gap                   15

        # rules
        #yabai -m rule --add app=".*" sub-layer=normal
        yabai -m rule --add app="^System Settings$" sticky=on sub-layer=above manage=off
        yabai -m rule --add app="^1Password$" sticky=on sub-layer=above manage=off
        yabai -m rule --add app='^Archive Utility$' sticky=on sub-layer=above manage=off
        yabai -m rule --add label="Finder" app="^Finder\$" title="(Co(py|nnect)|Move|Info|Pref)" sticky=on sub-layer=above manage=off
        yabai -m rule --add app="^Disk Utility$" sticky=on sub-layer=above manage=off
        yabai -m rule --add app="^System Information$" sticky=on sub-layer=above manage=off
        yabai -m rule --add app="^Activity Monitor$" sticky=on sub-layer=above manage=off
        yabai -m rule --add label="Arc" app="^Arc$" title="^Little Arc.*" sticky=on sub-layer=above manage=off
        yabai -m rule --add subrole="^AXSystemDialog$" sticky=on sub-layer=above mouse_follows_focus=off manage=off

        # need to force refresh simple bar
        #osascript -e 'tell application id "tracesOf.Uebersicht" to refresh'

        echo "yabai configuration loaded.."
      '';
    # ${pkgs.yabai}/bin/yabai --restart-service
    onChange = ''
      /opt/homebrew/bin/yabai --restart-service
    '';
  };

  # launchd.agents.yabai = {
  #   enable = true;
  #   config = {
  #     ProgramArguments = [ "${pkgs.skhd}/bin/yabai" ];
  #     EnvironmentVariables = {
  #       "PATH" = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:";
  #       "SHELL" = "/bin/sh";
  #     };
  #     KeepAlive = true;
  #     RunAtLoad = true;
  #     ProcessType = "Interactive";
  #     StandardErrorPath = "/tmp/yabai.err.log";
  #     StandardOutPath = "/tmp/yabai.out.log";
  #   };
  # };

  xdg.configFile."skhd/skhdrc" = {
    executable = true;
    text =
      let
        modMask = "shift + alt";
        moveMask = "ctrl + shift + alt";
      in
      # sh
      ''
        # focus window
        ${modMask} - h : yabai -m window --focus west || yabai -m window --focus stack.prev
        ${modMask} - j : yabai -m window --focus south
        ${modMask} - k : yabai -m window --focus north
        ${modMask} - l : yabai -m window --focus east || yabai -m window --focus stack.next
        # swap managed window
        ${moveMask} - h : yabai -m window --swap west
        ${moveMask} - j : yabai -m window --swap south
        ${moveMask} - k : yabai -m window --swap north
        ${moveMask} - l : yabai -m window --swap east
        # change space
        ${modMask} - b : yabai -m space --layout bsp
        ${modMask} - s : yabai -m space --layout stack
        ${modMask} - f : yabai -m space --layout float
        # rotate space
        ${moveMask} - n : yabai -m space --rotate 270
        ${moveMask} - m : yabai -m space --rotate 90
        # , comma
        ${moveMask} - 0x2B : yabai -m space --mirror y-axis
        # . dot
        ${moveMask} - 0x2F : yabai -m space --mirror x-axis
        # send window to space
        ${concatMapStrings (n: moveMask + " - " + n + " : yabai -m window --space " + n + "\n") (
          map toString (range 1 9)
        )}
        # send window to space and follow focus
        ${moveMask} - u : yabai -m window --space prev
        ${moveMask} - i : yabai -m window --space next
        # focus monitor
        ${modMask} - w : yabai -m display --focus prev
        ${modMask} - e : yabai -m display --focus next
        ${modMask} - r : yabai -m display --focus recent
        # send window to monitor and follow focus
        ${moveMask} - w : yabai -m window --display prev; yabai -m display --focus prev
        ${moveMask} - e : yabai -m window --display next; yabai -m display --focus next
        ${moveMask} - r : yabai -m window --display recent; yabai -m display --focus recent
        # balance size of windows
        ${modMask} - return : yabai -m space --balance
        # fullscreen window
        ${modMask} - space : yabai -m window --toggle zoom-fullscreen
        # window size
        ${modMask} - left : yabai -m window --resize right:-20:0
        ${modMask} - right : yabai -m window --resize right:20:0
        ${modMask} - up : yabai -m window --resize bottom:0:-20
        ${modMask} - down : yabai -m window --resize bottom:0:20
        ${moveMask} - left : yabai -m window --resize left:-20:0
        ${moveMask} - right : yabai -m window --resize left:20:0
        ${moveMask} - up : yabai -m window --resize top:-20:0
        ${moveMask} - down : yabai -m window --resize top:20:0
        # float / unfloat window and center on screen
        ${modMask} - t : yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2

        # unbind hide window shortcut
        cmd - h : skhd -k ""
      '';
    # ${pkgs.skhd}/bin/skhd --restart-service
    onChange = ''
      /opt/homebrew/bin/skhd --restart-service
    '';
  };

  # launchd.agents.skhd = {
  #   enable = true;
  #   config = {
  #     ProgramArguments = [ "${pkgs.skhd}/bin/skhd" ];
  #     EnvironmentVariables = {
  #       "PATH" = "$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:";
  #       "SHELL" = "/bin/sh";
  #     };
  #     KeepAlive = true;
  #     RunAtLoad = true;
  #     ProcessType = "Interactive";
  #     StandardErrorPath = "/tmp/skhd.err.log";
  #     StandardOutPath = "/tmp/skhd.out.log";
  #   };
  # };
}
