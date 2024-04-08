{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask-versions"
    "homebrew/cask-fonts"
    "homebrew/services"
    "koekeishiya/formulae"
  ];

  brews = [ "lima" "skhd" "yabai" ];

  casks = [
    "1password"
    "amethyst"
    "android-file-transfer"
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
    "firefox-developer-edition"
    "freecad"
    "gimp"
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
    "mark-text"
    "monitorcontrol"
    "muse"
    "neovide"
    "obs"
    "obsidian"
    "openscad"
    "orbstack"
    "orcaslicer"
    "podman-desktop"
    "qbittorrent"
    "raycast"
    "scroll-reverser"
    "signal"
    "slack"
    "spotify"
    "steam"
    "stremio"
    "tableplus"
    "transmission"
    "ubersicht"
    "utm"
    "visual-studio-code"
    "wezterm"
    "zed"
    "zoom"
  ];
in with lib; {
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text = (concatMapStrings (tap:
      ''tap "'' + tap + ''
        "
      ''

    ) taps) + (concatMapStrings (brew:
      ''brew "'' + brew + ''
        "
      ''

    ) brews) + (concatMapStrings (cask:
      ''cask "'' + cask + ''
        "
      ''

    ) casks);
    onChange = ''
      /opt/homebrew/bin/brew bundle install --cleanup --no-upgrade --force --no-lock --global
    '';
  };
}
