{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
  ];

  casks = [
    "1password"
    "alacritty"
    "alfred"
    "amethyst"
    "appcleaner"
    "cyberduck"
    "dbngin"
    "docker"
    "firefox-developer-edition"
    "godot"
    "iina"
    "insomnia"
    "iterm2-beta"
    "keka"
    "kitty"
    "maccy"
    "mark-text"
    "microsoft-auto-update"
    "microsoft-edge"
    "muse"
    "raycast"
    "scroll-reverser"
    "signal"
    "slack"
    "spotify"
    "stremio"
    "tableplus"
    "transmission"
    "ubersicht"
    "via"
    "visual-studio-code"
    "zoom"
  ];

  fonts = [
    "fantasque-sans-mono-nerd-font"
    "fira-code"
    "hasklig"
    "hasklug-nerd-font"
    "ibm-plex"
    "inter"
    "iosevka-nerd-font"
    "iosevka"
    "jetbrains-mono"
    "juliamono"
  ];
in
with lib; {
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text = (concatMapStrings 
      (tap: ''tap "'' + tap + ''"
        '')
      taps)
      +
      (concatMapStrings
      (cask: ''cask "'' + cask + ''"
        '')
      casks)
      +
      (concatMapStrings
      (font: ''cask "font-'' + font + ''"
        '')
      fonts);
    onChange = ''
      brew bundle install --cleanup --verbose --no-upgrade --force --no-lock --global
    '';
  };
}
