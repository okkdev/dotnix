{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    mouse = true;
    aggressiveResize = true;
    escapeTime = 0;
    prefix = "C-a";
    terminal = "tmux-256color";
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      tmux-fzf
      yank
    ];
  };
}
