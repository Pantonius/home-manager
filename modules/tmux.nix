{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;

      plugins = with pkgs; [
        tmuxPlugins.nord
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.vim-tmux-navigator;
          extraConfig = "set-option -sa terminal-overrides \",xterm*:TC\"";
        }
      ];
    };
  };
}
