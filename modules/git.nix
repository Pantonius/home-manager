{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Anton Pogrebnjak";
          email = "contact@pantonius.dev";
        };

        alias = {
          "history" = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        };

        init.defaultBranch = "main";
      };
    };
  };
}
