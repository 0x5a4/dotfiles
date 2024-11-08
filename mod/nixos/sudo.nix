{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.xfaf.sudo = {
    enable = lib.mkEnableOption "make sudo more fun";
  };

  config =
    let
      opts = config.xfaf.sudo;
    in
    lib.mkIf opts.enable {
      security.sudo = {
        package = pkgs.sudo.override { withInsults = true; };
        extraConfig = ''
          Defaults insults
          Defaults passprompt="[sudo] gib passwort:"
        '';
      };
    };
}
