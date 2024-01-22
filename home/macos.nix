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
  launchd.agents.load-ssh-keys = {
    enable = true;
    config = {
      UserName = "js";
      ProgramArguments = [
        "/usr/bin/ssh-add"
        "--apple-load-keychain"
      ];
      RunAtLoad = true;
    };
  };
}
