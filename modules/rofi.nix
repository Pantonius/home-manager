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
      package = pkgs.rofi-wayland;
      theme = lib.mkDefault "custom-theme.rasi";
      plugins = [
        pkgs.rofi-file-browser
      ];
      modes = [
        "drun"
        "file-browser-extended"
      ];
    };

    home.file.".config/rofi/custom-theme.rasi".source = ./rofi/custom-theme.rasi;
  };
}
