{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".DS_Store"
      ".direnv"
      ".claude"
    ];
    includes = [
      {
        condition = "gitdir:~/Documents/git/work/";
        contents = {
          user.name = "Jen Stehlik";
          user.email = "js@cyon.ch";
          user.signingkey = "~/.ssh/id_cyon_ed25519.pub";
        };
      }
      {
        condition = "gitdir:~/code/work/";
        contents = {
          user.name = "Jen Stehlik";
          user.email = "js@cyon.ch";
          user.signingkey = "~/.ssh/id_cyon_ed25519.pub";
        };
      }
    ];

    settings = {
      user.name = "okkdev";
      user.email = "dev@stehlik.me";
      alias = {
        s = "status";

        f = "fetch";
        p = "pull";
        pp = "push";
        ppf = "push --force-with-lease";
        ppt = "push --tags";

        sw = "switch";
        swc = "switch -c";
        co = "checkout";

        rb = "rebase";
        m = "merge";
        me = "merge --no-ff";

        d = "diff";
        ds = "diff --staged";
        dt = "-c diff.external=difft diff";
        dts = "-c diff.external=difft diff --staged";

        a = "add";
        aa = "add .";
        ap = "add -p";
        ai = "add -i";

        c = "commit";
        amend = "commit --amend --no-edit";
        cm = "commit -m";

        staash = "stash -all";

        r = "reset";
        rhead = "reset HEAD";
        rhard = "reset --hard";
        undo = "reset HEAD~1 --mixed";

        l = "log --graph --abbrev-commit --decorate --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %s %C(italic)- %an%C(reset)%C(magenta bold)%d%C(reset)' --all";
      };
      init.defaultBranch = "main";
      core.sshCommand = lib.mkIf pkgs.stdenv.isDarwin "/usr/bin/ssh";
      push.default = "current";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere = {
        enabled = true;
        autoUpdate = true;
      };
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
