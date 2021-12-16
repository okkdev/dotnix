{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask"
    "homebrew/cask-versions"
    "homebrew/core"
  ];
  casks = [
    "1password"
    "alacritty"
    "alfred"
    "amethyst"
    "appcleaner"
    "docker"
    "firefox-developer-edition"
    "godot"
    "iterm2-beta"
    "kitty"
    "maccy"
    "microsoft-auto-update"
    "microsoft-edge"
    "muse"
    "scroll-reverser"
    "slack"
    "spotify"
    "stremio"
    "ubersicht"
    "via"
    "visual-studio-code"
    "zoom"
  ];
in
with lib; {
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text = (concatMapStrings (tap:
        ''tap "'' + tap + ''"
        '') taps) 
        + (concatMapStrings (cask:
          ''cask "'' + cask + ''"
          '') casks);
    onChange = ''
      brew bundle install --cleanup --verbose --no-upgrade --force --no-lock --global
    '';
  };
}