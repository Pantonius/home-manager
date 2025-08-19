{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "lambda";
      };

      # initContent = ''
      #   eval "$(zoxide init zsh)"
      # '';
      #
    };
    programs.ghostty.enableZshIntegration = config.ghostty.enable;
    programs.fzf.enableZshIntegration = config.fzf.enable;
    programs.tmux.shell = lib.mkIf (config.tmux.enable) "${pkgs.zsh}/bin/zsh";
    programs.zoxide.enableZshIntegration = config.zoxide.enable;
  };
}
