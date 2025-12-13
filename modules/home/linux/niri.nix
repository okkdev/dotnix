{ ... }:
{
  programs.niri = {
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
