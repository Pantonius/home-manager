{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    vscodium.enable = lib.mkEnableOption "enables vscodium";
  };

  config = lib.mkIf config.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
        arcticicestudio.nord-visual-studio-code
        unifiedjs.vscode-mdx
        esbenp.prettier-vscode
        arrterian.nix-env-selector
        ms-toolsai.jupyter
      ];
    };
  };
}
