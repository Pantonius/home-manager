{ lib, config, ... }:
{
  options = {
    ghostty.enable = lib.mkEnableOption "enables ghostty";
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        background-opacity = "0";
        font-family = "JetBrains Mono";
        confirm-close-surface = false;
      };
    };
  };
}
