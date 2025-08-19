{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "enables fzf";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
    };

    programs.tmux.plugins = lib.mkIf config.tmux.enable [ pkgs.tmuxPlugins.tmux-fzf ];
  };
}
