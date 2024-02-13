{ config, pkgs, lib, ... }:

let
  taps = [
    "homebrew/bundle"
    "homebrew/cask"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
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
    "iterm2-beta"
    "keka"
    "kicad"
    "kitty"
    "krita"
    "logseq"
    "losslesscut"
    "maccy"
    "mark-text"
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
    "zoom"
  ];

  fonts = [
    "cascadia-code"
    "commit-mono"
    "cozette"
    "fantasque-sans-mono"
    "fira-code"
    "hasklig"
    "ibm-plex"
    "inter"
    "iosevka"
    "jetbrains-mono"
    "juliamono"
    "manrope"
    "symbols-only-nerd-font"
  ];

  mas = [
    {
      name = "WireGuard";
      id = "1451685025";
    }
    {
      name = "Unsplash Wallpapers";
      id = "1284863847";
    }
  ];
in with lib; {
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text = (concatMapStrings (tap:
      ''tap "'' + tap + ''
        "
      '') taps) + (concatMapStrings (brew:
        ''brew "'' + brew + ''
          "
        '') brews) + (concatMapStrings (cask:
          ''cask "'' + cask + ''
            "
          '') casks) + (concatMapStrings (font:
            ''cask "font-'' + font + ''
              "
            '') fonts) + (concatMapStrings
              ({ name, id }: ''mas "'' + name + ''", id: '' + id + "\n") mas);
    onChange = ''
      /opt/homebrew/bin/brew bundle install --cleanup --verbose --no-upgrade --force --no-lock --global
    '';
  };
}
