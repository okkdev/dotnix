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
        name = "Jen Stehlik";
        email = "dev@stehlik.me";
      };

      # work config
      "--scope" = [
        {
          "--when".repositories = [
            "~/code/dreipol"
          ];
          user = {
            name = "Jen Stehlik";
            email = "jen.stehlik@dreipol.ch";
          };
          signing.key = "~/.ssh/id_dreipol_ed25519.pub";
        }
      ];

      ui = {
        pager = [
          "delta"
          "--pager"
          "less -FRX"
        ];
        diff-formatter = ":git";
        default-command = [
          "log"
          "--limit"
          "6"
        ];
      };
      aliases = {
        init = [
          "git"
          "init"
          "--colocate"
        ];
        clone = [
          "git"
          "clone"
          "--colocate"
        ];
        ba = [
          "bookmark"
          "advance"
        ];
        f = [
          "git"
          "fetch"
        ];
        p = [
          "git"
          "push"
        ];
        cm = [
          "commit"
          "-m"
        ];
        c = [ "commit" ];
        s = [ "status" ];
        d = [ "diff" ];
        e = [ "edit" ];
        n = [ "new" ];
        l = [ "log" ];
        ll = [
          "log"
          "--revisions"
          "::@"
        ];
        lb = [
          "log"
          "--revisions"
          "bookmarks()"
        ];
        rb = [ "rebase" ];
      };
      revsets.bookmark-advance-to = "@-";
    };
  };
}
