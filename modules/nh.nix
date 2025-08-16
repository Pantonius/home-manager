{ lib, config, ... }:
{
  options = {
    nh.enable = lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf config.nh.enable {
    programs.nh = {
      enable = true;
    };
  };
}
