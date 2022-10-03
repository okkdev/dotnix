{ config, pkgs, lib, ... }:

{
  targets.darwin.defaults = {
    "com.apple.dock" = {
      autohide = true;
      show-recents = 0;
    };
    NSGlobalDomain = {
      NSWindowShouldDragOnGesture = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
    };
  };
}