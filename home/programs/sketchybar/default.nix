{ pkgs, ... }:

let
  sketchybar-font-version = "v2.0.40";
  sketchybar-font = pkgs.stdenv.mkDerivation {
    name = "sketchybar-app-font";
    phases = [ "installPhase" ];
    src = pkgs.fetchurl {
      url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/${sketchybar-font-version}/sketchybar-app-font.ttf";
      sha256 = "sha256:835604784960fff458b849cfb5c69d1c7d7aa7a712d3e03c17c5f3798bbc1d98";
    };
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/sketchybar-app-font.ttf
    '';
  };
  sketchybar-icon-map = pkgs.fetchurl {
    url = "https://github.com/kvndrsslr/sketchybar-app-font/releases/download/${sketchybar-font-version}/icon_map.sh";
    sha256 = "sha256:5740822adec758dcc807391a8ea9440ed635f85f69c55a29f5606b7e0b527145";
  };
in
{
  home.packages = [ sketchybar-font ];
  xdg.configFile."sketchybar/icon_map.sh" = {
    source = sketchybar-icon-map;
    executable = true;
  };
  xdg.configFile."sketchybar/plugins" = {
    source = ./plugins;
    recursive = true;
  };
  xdg.configFile."sketchybar/sketchybarrc" = {
    executable = true;
    text =
      # sh
      ''
        PLUGIN_DIR="$CONFIG_DIR/plugins"

        ##### Bar Appearance #####
        # Configuring the general appearance of the bar.
        # These are only some of the options available. For all options see:
        # https://felixkratz.github.io/SketchyBar/config/bar
        # If you are looking for other colors, see the color picker:
        # https://felixkratz.github.io/SketchyBar/config/tricks#color-picker

        sketchybar --bar position=top height=34

        ##### Changing Defaults #####
        # We now change some default values, which are applied to all further items.
        # For a full list of all available item properties see:
        # https://felixkratz.github.io/SketchyBar/config/items

        default=(
          padding_left=5
          padding_right=5
          icon.font="Symbols Nerd Font Mono:Regular:13.0"
          label.font="Maple Mono:Bold:12.0"
          icon.color=0xffffffff
          label.color=0xffffffff
          icon.padding_left=4
          icon.padding_right=4
          label.padding_left=4
          label.padding_right=4
        )
        sketchybar --default "''${default[@]}"

        ##### Adding Mission Control Space Indicators #####
        # Let's add some mission control spaces:
        # https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
        # to indicate active and available mission control spaces.

        YABAI_SPACES=($(yabai -m query --spaces | jq -r '.[].index'))

        source "$HOME/.config/sketchybar/icon_map.sh"

        for sid in "''${YABAI_SPACES[@]}"
        do
            # Get windows in this space
            windows=$(yabai -m query --windows --space "$sid" | jq -r '.[] | select(.["is-minimized"] == false) | .app')

            # Create icon string from open applications
            icon_string=""
            if [[ -n "$windows" ]]; then
                while IFS= read -r app; do
                    if [[ -n "$app" ]]; then
                        # Get icon for this app using sketchybar-app-font
                        __icon_map "$app"
                        if [[ -n "$icon_result" ]]; then
                            icon_string+="$icon_result"
                        else
                            # Fallback to first letter if no icon found
                            icon_string+="''${app:0:1}"
                        fi
                    fi
                done <<< "$windows"
            fi

            # Use space index if no windows, otherwise use app icons
            display_icon="''${icon_string:-$sid}"

            space=(
                space="$sid"
                icon="$display_icon"
                icon.font="sketchybar-app-font:Regular:16.0"
                icon.padding_left=7
                icon.padding_right=7
                background.color=0x40ffffff
                background.corner_radius=5
                background.height=25
                label.drawing=off
                script="$PLUGIN_DIR/space.sh"
                click_script="yabai -m space --focus $sid"
            )

            sketchybar --add space space."$sid" left --set space."$sid" "''${space[@]}"
        done

        ##### Adding Left Items #####
        # We add some regular items to the left side of the bar, where
        # only the properties deviating from the current defaults need to be set

        sketchybar --add item chevron left \
                   --set chevron icon= label.drawing=off \
                   --add item front_app left \
                   --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
                   --subscribe front_app front_app_switched

        ##### Adding Right Items #####
        # In the same way as the left items we can add items to the right side.
        # Additional position (e.g. center) are available, see:
        # https://felixkratz.github.io/SketchyBar/config/items#adding-items-to-sketchybar

        # Some items refresh on a fixed cycle, e.g. the clock runs its script once
        # every 10s. Other items respond to events they subscribe to, e.g. the
        # volume.sh script is only executed once an actual change in system audio
        # volume is registered. More info about the event system can be found here:
        # https://felixkratz.github.io/SketchyBar/config/events

        sketchybar --add item clock right \
                   --set clock update_freq=10 icon=  script="$PLUGIN_DIR/clock.sh" \
                   --add item volume right \
                   --set volume script="$PLUGIN_DIR/volume.sh" \
                   --subscribe volume volume_change \
                   --add item battery right \
                   --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
                   --subscribe battery system_woke power_source_change

        ##### Force all scripts to run the first time (never do this in a script) #####
        sketchybar --update
      '';
    onChange = ''
      /opt/homebrew/bin/sketchybar --reload
    '';
  };
}
