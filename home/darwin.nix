{ ... }:

{
  targets.darwin.defaults = {
    "com.apple.dock" = {
      autohide = true;
      show-recents = false;
      # I need my downloads in dock...
      # static-only = true;
      wvous-bl-corner = 0;
      wvous-br-corner = 0;
      wvous-tl-corner = 0;
      wvous-tr-corner = 0;
    };
    NSGlobalDomain = {
      NSWindowShouldDragOnGesture = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
    };
  };

  home.file.".hushlogin".text = "";

  fonts.fontconfig.enable = true;

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
