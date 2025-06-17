{
  config,
  pkgs,
  lib,
  ...
}:

let
  taps = [
    "koekeishiya/formulae"
    "FelixKratz/formulae"
    "support/cyon-tools\", \"git@gitlab.cyon.lan:sup/homebrew-cyon-tools.git"
  ];

  brews = [
    "lima"
    "sketchybar"
    "skhd"
    "yabai"
    "support/cyon-tools/supctl"
  ];

  casks = [
    "1password"
    "android-file-transfer"
    "android-studio"
    "appcleaner"
    "arc"
    "balenaetcher"
    "blender"
    "bruno"
    "cyberduck"
    "darktable"
    "dbngin"
    "docker"
    "fightcade"
    "figma"
    "firefox@developer-edition"
    "freecad"
    "ghostty"
    "godot"
    "handbrake"
    "iina"
    "inkscape"
    "insomnia"
    "kicad"
    "krita"
    "lagrange"
    "logseq"
    "losslesscut"
    "maccy"
    "monitorcontrol"
    "mos"
    "obs"
    "openscad"
    "orbstack"
    "orcaslicer"
    "podman-desktop"
    "raycast"
    "signal"
    "slack"
    "spotify"
    "steam"
    "stremio"
    "tableplus"
    "ubersicht"
    "unity-hub"
    "upscayl"
    "utm"
    "visual-studio-code"
    "wezterm"
    "zed"
    "zen"
    "zoom"
  ];
in
with lib;
{
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text =
      (concatMapStrings (
        tap:
        ''tap "''
        + tap
        + ''
          "
        ''

      ) taps)
      + (concatMapStrings (
        brew:
        ''brew "''
        + brew
        + ''
          "
        ''

      ) brews)
      + (concatMapStrings (
        cask:
        ''cask "''
        + cask
        + ''
          "
        ''

      ) casks);
    onChange = ''
      /opt/homebrew/bin/brew bundle install --cleanup --no-upgrade --force --global
    '';
  };
}
