{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-light.yaml";

    cursor = {
      # name = "Maple";
      # package = pkgs.maplestory-cursor;
      # size = 48;
      # name = "Simp1e-Dark";
      # package = pkgs.simp1e-cursors;
      # size = 24;
      name = "Bibata-Modern-Ice";
      package =  pkgs.bibata-cursors;
      size = 24;
    };
  };
}
