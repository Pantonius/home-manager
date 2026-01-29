{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    rofi.enable = lib.mkEnableOption "enables rofi";
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      theme = lib.mkDefault "custom-theme.rasi";
      plugins = [
        pkgs.rofi-file-browser
      ];
      modes = [
        "drun"
        "file-browser-extended"
        #   {
        #     name = "bluetooth";
        #     path = lib.getExe pkgs.rofi-bluetooth;
        #   }
        #   {
        #     name = "nm";
        #     path = lib.getExe pkgs.rofi-network-manager;
        #   }
      ];
    };

    home.file.".config/rofi/custom-theme.rasi".source = ./rofi/custom-theme.rasi;
  };
}
