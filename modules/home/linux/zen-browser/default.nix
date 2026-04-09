{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    profiles = {
      jen = {
        userContent = lib.mkForce (import ./userContent.nix { colors = config.lib.stylix.colors; });
      };
    };

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Certificates = {
        ImportEnterpriseRoots = true;
      };
      SecurityDevices = {
        "p11-kit-trust" = "${pkgs.p11-kit}/lib/pkcs11/p11-kit-trust.so";
      };
    };
  };
}
