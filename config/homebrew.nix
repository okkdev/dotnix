{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/cask-fonts"
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
    "iina"
    "insomnia"
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
    "tableplus"
    "the-unarchiver"
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
