{
  lib,
  config,
  pkgs,
  ...
}:

let
  bin = pkgs.stdenv.mkDerivation {
    pname = "pass-cli";
    version = "1.3.5";

    src = pkgs.fetchurl {
      url = "https://proton.me/download/pass-cli/1.3.5/pass-cli-${builtins.concatStringsSep "-" (lib.lists.reverseList (builtins.split "-" pkgs.system))}";
      # name = "proton-pass-cli";
      # hash = "sha256-2deaf3b420cd43adf061439f8942ddbd8db340352555735c0ec7f5dd20da220f";
    };
  };
in
{
  options = {
    proton-pass.enable = lib.mkEnableOption "enables proton-pass";
  };

  config = lib.mkIf config.proton-pass.enable {

  };
}
