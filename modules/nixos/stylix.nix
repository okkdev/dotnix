{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = false;
    # polarity = "dark";

    # light
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/brushtrees.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/cupcake.yaml";

    # dark
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chinoiserie-night.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chinoiserie-morandi.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/vesper.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/mountain.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";

    image = ../../assets/wallpapers/lei-min-31.jpg;

    cursor = {
      # name = "Maple";
      # package = pkgs.maplestory-cursor;
      # size = 48;
      # name = "Simp1e-Dark";
      # package = pkgs.simp1e-cursors;
      # size = 24;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    icons = {
      enable = true;
      dark = "Tela-dark";
      light = "Tela-light";
      package = pkgs.tela-icon-theme;
    };
  };

  home-manager.sharedModules = [
    {
      stylix.targets = {
        # terminal
        neovim = {
          enable = true;
          plugin = "base16-nvim";
          # transparentBackground = {
          #   numberLine = true;
          #   signColumn = true;
          # };
        };
        ghostty.enable = true;

        # os
        niri.enable = true;
        swaylock.enable = true;
        noctalia-shell.enable = true;
        gtk.enable = true;
        qt.enable = true;
        mako.enable = true;
        font-packages.enable = true;
        xresources.enable = true;

        # programs
        vicinae.enable = true;
        mpv.enable = true;
        btop.enable = true;
        vesktop.enable = true;
        zen-browser = {
          enable = true;
          profileNames = [
            "jen"
          ];
        };
      };
    }
  ];
}
