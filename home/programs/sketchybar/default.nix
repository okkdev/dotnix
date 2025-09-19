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

        sketchybar --bar position=top height=36 color=0x00000000

        default=(
          padding_left=5
          padding_right=5
          icon.font="Symbols Nerd Font Mono:Regular:13.0"
          label.font="Maple Mono:Bold:13.0"
          icon.color=0xff180f23
          label.color=0xff180f23
          icon.padding_left=10
          icon.padding_right=2
          label.padding_left=5
          label.padding_right=10
          background.color=0xffefedec
          background.corner_radius=99
          background.height=25
          background.shadow.drawing=on
          background.shadow.color=0x10000000
          background.shadow.distance=3
          background.shadow.angle=45
        )

        sketchybar --default "''${default[@]}"

        # sketchybar --add item spaces left \
        #            --set spaces script="$PLUGIN_DIR/spaces.sh" \
        #            --subscribe spaces space_change

        sketchybar --add item front_app left \
                   --set front_app icon=󰅂 script="$PLUGIN_DIR/front_app.sh" \
                   --subscribe front_app front_app_switched

        sketchybar --add item clock right \
                   --set clock script="$PLUGIN_DIR/clock.sh" \
                   --add item battery right \
                   --set battery script="$PLUGIN_DIR/battery.sh" \
                   --subscribe battery system_woke power_source_change \
                   --add item volume right \
                   --set volume script="$PLUGIN_DIR/volume.sh" \
                   --subscribe volume volume_change

                   # --add item music right \
                   # --set music script="$PLUGIN_DIR/music.sh" \
                   # --subscribe music media_change system_woke

        sketchybar --update
      '';
    onChange = ''
      /opt/homebrew/bin/sketchybar --reload
    '';
  };
}
