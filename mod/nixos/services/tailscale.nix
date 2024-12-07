{
  lib,
  config,
  ...
}:
{
  options.xfaf.services.tailscale = {
    enable = lib.mkEnableOption "enable tailscale";
    secretsFile = lib.mkOption {
      type = lib.types.path;
      description = "path to the sops secret file used for the tailscale auth key";
    };
  };

  config =
    let
      cfg = config.xfaf.services.tailscale;
    in
    lib.mkIf cfg.enable {
      sops.secrets.tailscale-auth-key = {
        sopsFile = cfg.secretsFile;
        format = "binary";
      };

      services.tailscale = {
        enable = true;
        authKeyFile = config.sops.secrets.tailscale-auth-key.path;
        extraUpFlags = [
          "--login-server"
          "https://vpn.wienstroer.net"
        ];
      };
    };
}
