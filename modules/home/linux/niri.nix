{ config, ... }:
{
  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [ "noctalia-shell" ];
      }
    ];

    cursor.hide-when-typing = true;
    clipboard.disable-primary = true;
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";

    input = {
      keyboard = {
        repeat-delay = 250;
        repeat-rate = 50;
      };

      touchpad = {
        scroll-factor = 0.5;
      };

      mouse = {
        accel-speed = 0.5;
        accel-profile = "flat";
      };
    };

    outputs = {
      # Framework 13 Screen
      "BOE NE135A1M-NY1 Unknown" = {
        mode = {
          width = 2880;
          height = 1920;
        };
        scale = 1.5;
        position.x = 0;
        position.y = 0;
        variable-refresh-rate = "on-demand";
      };
    };

    # overview = {
    #   backdrop-color = config.lib.stylix.colors.withHashtag.base01;
    # };

    animations = {
      slowdown = 0.5;
    };

    layout = {
      # struts.top = -8;
      gaps = 10;
      tab-indicator.place-within-column = true;
    };

    window-rules = [
      {
        geometry-corner-radius = {
          bottom-left = 10.0;
          bottom-right = 10.0;
          top-left = 10.0;
          top-right = 10.0;
        };
        clip-to-geometry = true;
      }
    ];

    binds = with config.lib.niri.actions; {
      # System & overlay & stuff
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+Shift+E".action = quit;
      "Mod+Shift+P".action = power-off-monitors;
      "Mod+Escape" = {
        allow-inhibiting = false;
        action = toggle-keyboard-shortcuts-inhibit;
      };
      "Mod+O" = {
        repeat = false;
        action = toggle-overview;
      };

      # Application launching
      "Mod+Return".action.spawn = "ghostty";
      # "Mod+Space".action.spawn = "fuzzel";
      "Mod+Space".action.spawn = [
        "vicinae"
        "toggle"
      ];
      "Mod+Alt+L".action.spawn = "swaylock";
      "Mod+Alt+K" = {
        allow-when-locked = true;
        action.spawn = [
          "systemctl"
          "suspend"
        ];
      };
      "Mod+E".action.spawn = "nautilus";

      # macOS style keybinds
      "Mod+C".action.spawn = [
        "wtype"
        "-k"
        "XF86Copy"
      ];
      "Mod+V".action.spawn = [
        "wtype"
        "-k"
        "XF86Paste"
      ];
      "Mod+X".action.spawn = [
        "wtype"
        "-k"
        "XF86Cut"
      ];
      "Mod+A".action.spawn = [
        "wtype"
        "-M"
        "ctrl"
        "-k"
        "a"
        "-m"
        "ctrl"
      ];
      "Mod+Shift+V".action.spawn = [
        "vicinae"
        "vicinae://extensions/vicinae/clipboard/history"
      ];

      # Audio control
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "increase"
        ];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "decrease"
        ];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteOutput"
        ];
      };
      "XF86AudioPlay" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "media"
          "playPause"
        ];
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "media"
          "next"
        ];
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "media"
          "previous"
        ];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "increase"
        ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "brightness"
          "decrease"
        ];
      };

      # Window management
      "Mod+Q".action = close-window;

      # Focus - Arrow keys
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;

      # Focus - Vim keys
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      # Focus - First/last column
      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;

      # Move columns/windows - Arrow keys
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;

      # Move columns/windows - Vim keys
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;

      # Move to first/last position
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      # Monitor focus - Arrow keys
      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;

      # Monitor focus - Vim keys
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+L".action = focus-monitor-right;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;

      # Move column to monitor - Arrow keys
      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;

      # Move column to monitor - Vim keys
      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

      # Workspace navigation
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;

      # Move workspace
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;

      # Move workspace monitor
      "Mod+Shift+Ctrl+U".action = move-workspace-to-monitor-next;
      "Mod+Shift+Ctrl+I".action = move-workspace-to-monitor-previous;

      # Move column to workspace
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;

      # Direct workspace access (1-9)
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      # Move to specific workspace (1-9)
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Column operations
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+W".action = toggle-column-tabbed-display;

      # Column/Window sizing
      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
      "Mod+S".action = center-column;
      "Mod+Ctrl+S".action = center-visible-columns;
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Floating
      "Mod+Alt+F".action = toggle-window-floating;
      "Mod+Tab".action = switch-focus-between-floating-and-tiling;

      # Screenshots
      "Mod+Shift+S".action.screenshot = [ ];
      "Mod+Ctrl+Shift+S".action.screenshot-screen = [ ];
      "Mod+Alt+Shift+S".action.screenshot-window = [ ];

      # Duplicate Output workaround
      "Mod+P" = {
        repeat = false;
        action.spawn-sh = "wl-mirror $(niri msg --json focused-output | jq -r .name)";
      };
    };
  };
}
