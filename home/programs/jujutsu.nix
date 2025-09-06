{ ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
      user = {
        name = "okkdev";
        email = "dev@stehlik.me";
      };

      # cyon config
      "--scope" = [
        {
          "--when".repositories = [ "~/Documents/git/work" ];
          user = {
            name = "Jen Stehlik";
            email = "js@cyon.ch";
          };
          signing.key = "~/.ssh/id_cyon_ed25519.pub";
        }
      ];

      ui = {
        pager = [
          "delta"
          "--pager"
          "less -FRX"
        ];
        diff-formatter = ":git";
        default-command = "log";
      };
      aliases = {
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];
        gf = [
          "git"
          "fetch"
        ];
        gp = [
          "git"
          "push"
          "--allow-new"
        ];
        s = [ "status" ];
        d = [ "diff" ];
        e = [ "edit" ];
        n = [ "new" ];
        cm = [
          "commit"
          "-m"
        ];
      };
    };
  };
}
