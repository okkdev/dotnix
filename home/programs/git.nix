{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ".direnv" ];
    userName = "okkdev";
    userEmail = "dev@stehlik.me";
    includes = [
      {
        condition = "gitdir:~/Documents/git/work/";
        contents = {
          user.name = "Jen Stehlik";
          user.email = "js@cyon.ch";
        };
      }
    ];
    aliases = {
      s = "status";
      p = "pull";
      pp = "push";
      rb = "rebase";
      sw = "switch";
      swc = "switch -c";
      d = "diff";
      f = "fetch";

      a = "add";
      aa = "add .";
      ap = "add -p";

      c = "commit";
      amend = "commit --amend --no-edit";
      cm = "commit -m";

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
    };
    delta.enable = true;
  };
}
