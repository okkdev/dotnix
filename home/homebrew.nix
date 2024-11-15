{
  config,
  pkgs,
  lib,
  ...
}:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask-versions"
    "homebrew/cask-fonts"
    "homebrew/services"
    "koekeishiya/formulae"
    "support/cyon-tools\", \"git@gitlab.cyon.lan:sup/homebrew-cyon-tools.git"
  ];

  brews = [
    "lima"
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
    "diffusionbee"
    "docker"
    "fightcade"
    "figma"
    "firefox@developer-edition"
    "freecad"
    "godot"
    "handbrake"
    "iina"
    "inkscape"
    "insomnia"
    "kicad"
    "kitty"
    "krita"
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
    "qbittorrent"
    "raycast"
    "signal"
    "slack"
    "spotify"
    "steam"
    "stremio"
    "tableplus"
    "transmission"
    "ubersicht"
    "upscayl"
    "utm"
    "visual-studio-code"
    "wezterm"
    "zed"
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
      /opt/homebrew/bin/brew bundle install --cleanup --no-upgrade --force --no-lock --global
    '';
  };
}
