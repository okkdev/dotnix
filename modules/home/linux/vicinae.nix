{ inputs, pkgs, ... }:
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = true;
    package = pkgs.vicinae;
  };
}
