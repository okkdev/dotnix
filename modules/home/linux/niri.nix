{ ... }:
{
  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];
    };
  };
}
