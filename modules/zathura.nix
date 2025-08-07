{ config, lib, ... }:
{
  options = {
    waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf config.waybar.enable {
    programs.zathura-pdf-poppler.enable = true;
    programs.zathura = {
      enable = true;

      options = {
        selection-clipboard = "clipboard";
      };
    };
  };
}
