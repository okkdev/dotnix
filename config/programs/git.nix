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
          user.name = "js";
          user.email = "js@cyon.ch";
        };
      }
    ];
    aliases = {
      s = "status";
      p = "pull";
      a = "add";
      aa = "add .";
      ap = "add -p";
      d = "diff";
      c = "commit";
      cm = "commit -m";
      pp = "push";
    };
    extraConfig = {
      init.defaultBranch = "main";
      core.sshCommand = "/usr/bin/ssh";
    };
    delta.enable = true;
  };
}
