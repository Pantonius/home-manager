{ config, lib, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
    };
  };
}
