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
        font-family = "FiraCode Nerd Font";
        confirm-close-surface = false;
        # shell-integration = "detect";
        # shell-integration-features = "ssh-terminfo,ssh-env";
      };
    };

  };
}
