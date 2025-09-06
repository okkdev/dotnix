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
      ui = {
        pager = [
          "delta"
          "--pager"
          "less -FRX"
        ];
        diff-formatter = ":git";
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
        cm = [
          "commit"
          "-m"
        ];
      };
    };
  };
}
