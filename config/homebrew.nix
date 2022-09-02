{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
  ];

  brews = [
    "lima"
  ];

  casks = [
    "1password"
    "alacritty"
    "alfred"
    "amethyst"
    "appcleaner"
    "balenaetcher"
    "cyberduck"
    "dbngin"
    "docker"
    "figma"
    "firefox-developer-edition"
    "godot"
    "iina"
    "insomnia"
    "iterm2-beta"
    "keka"
    "kitty"
    "logseq"
    "maccy"
    "mark-text"
    "microsoft-auto-update"
    "microsoft-edge"
    "muse"
    "obs"
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
    "manrope"
  ];

  mas = [
    { name="WireGuard";  id="1451685025"; }
    { name="Unsplash Wallpapers"; id="1284863847"; }
  ];
in
with lib; {
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text = (concatMapStrings 
      (tap: ''tap "'' + tap + "\"\n")
      taps)
      +
      (concatMapStrings 
      (brew: ''brew "'' + brew + "\"\n")
      brews)
      +
      (concatMapStrings
      (cask: ''cask "'' + cask + "\"\n")
      casks)
      +
      (concatMapStrings
      (font: ''cask "font-'' + font + "\"\n")
      fonts)
      +
      (concatMapStrings
      ({name, id}: ''mas "'' + name + ''", id: '' + id + "\n")
      mas);
    onChange = ''
      brew bundle install --cleanup --verbose --no-upgrade --force --no-lock --global
    '';
  };
}
