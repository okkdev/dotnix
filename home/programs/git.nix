{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
      ".direnv"
    ];
    userName = "okkdev";
    userEmail = "dev@stehlik.me";
    includes = [
      {
        condition = "gitdir:~/Documents/git/work/";
        contents = {
          user.name = "Jen Stehlik";
          user.email = "js@cyon.ch";
          user.signingkey = "~/.ssh/id_cyon_ed25519.pub";
        };
      }
    ];
    aliases = {
      s = "status";
      p = "pull";
      pp = "push";
      ppf = "push --force-with-lease";
      ppt = "push --tags";
      rb = "rebase";
      sw = "switch";
      swc = "switch -c";
      d = "diff";
      ds = "diff --staged";
      diffs = "diff --staged";
      f = "fetch";
      m = "merge";
      me = "merge --no-ff";

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
    extraConfig = {
      init.defaultBranch = "main";
      core.sshCommand = "/usr/bin/ssh";
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

    delta = {
      enable = true;
      package = pkgs.writeScriptBin "delta" ''
        if defaults read -g AppleInterfaceStyle &> /dev/null; then
          ${pkgs.delta}/bin/delta "$@"
        else
          ${pkgs.delta}/bin/delta --light "$@"
        fi
      '';
      options = {
        syntax-theme = "ansi";
        keep-plus-minus-markers = true;
        line-numbers = true;
      };
    };
  };
}
