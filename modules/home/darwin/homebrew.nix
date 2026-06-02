{ lib, ... }:

let
  taps = [
    "koekeishiya/formulae"
    "FelixKratz/formulae"
    "jackielii/tap"
  ];

  brews = [
    "lima"
    "sketchybar"
    "skhd"
    "yabai"
  ];

  casks = [
    "1password"
    "1password-cli"
    "android-file-transfer"
    "bruno"
    "cyberduck"
    "dbngin"
    "figma"
    "ghostty"
    "iina"
    "inkscape"
    "losslesscut"
    "maccy"
    "mos"
    "obsidian"
    "orbstack"
    "raycast"
    "slack"
    "spotify"
    "utm"
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
      /opt/homebrew/bin/brew bundle install --cleanup --no-upgrade --force --global --verbose
    '';
  };
}
