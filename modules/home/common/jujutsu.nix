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

      # cyon config
      "--scope" = [
        {
          "--when".repositories = [
            "~/Documents/git/work"
            "~/code/work"
          ];
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
        tug = [
          "bookmark"
          "move"
          "--from"
          "closest_bookmark(@-)"
          "--to"
          "closest_pushable(@-)"
        ];
        gf = [
          "git"
          "fetch"
        ];
        gp = [
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
        lb = [
          "log"
          "--revisions"
          "bookmarks()"
        ];
        rb = [ "rebase" ];
      };
      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
        "closest_pushable(to)" =
          "heads(::to & mutable() & ~description(exact:\"\") & (~empty() | merges()))";
      };
    };
  };
}
