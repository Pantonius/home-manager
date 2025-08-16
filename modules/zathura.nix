{ config, lib, ... }:
{
  options = {
    zathura.enable = lib.mkEnableOption "enables zathura";
  };

  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;

      options = {
        selection-clipboard = "clipboard";
      };
    };
  };
}
