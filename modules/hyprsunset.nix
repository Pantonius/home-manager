{ config, lib, ... }:
{
  options = {
    hyprsunset.enable = lib.mkEnableOption "enables hyprsunset";
  };

  config = lib.mkIf config.hyprsunset.enable {
    services.hyprsunset.enable = true;

    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "hyprctl hyprsunset temperature 4500"
        ];
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, XF86MonBrightnessDown, exec, hyprctl hyprsunset temperature -100"
          "$mainMod, XF86MonBrightnessUp, exec, hyprctl hyprsunset temperature +100"
        ];
      };
    };
  };
}
