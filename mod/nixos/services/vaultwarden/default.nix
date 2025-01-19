{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options.xfaf.services.vaultwarden = {
    enable = lib.mkEnableOption "enable vaultwarden";
    secretsFile = lib.mkOption {
      type = lib.types.path;
    };
  };

  config =
    let
      cfg = config.xfaf.services.vaultwarden;
    in
    lib.mkIf cfg.enable {
      sops.secrets.vaultwarden = {
        sopsFile = cfg.secretsFile;
        format = "binary";
        mode = "0444";
      };

      containers.vaultwarden = {
        autoStart = true;
        privateNetwork = true;
        hostAddress = "192.168.100.10";
        localAddress = "192.168.100.11";
        bindMounts = {
          "resolv" = {
            hostPath = "/etc/resolv.conf";
            mountPoint = "/etc/resolv.conf";
          };
          "secret" = {
            hostPath = config.sops.secrets.vaultwarden.path;
            mountPoint = config.sops.secrets.vaultwarden.path;
          };
        };

        specialArgs = {
          inherit inputs;
          host-config = config;
        };

        config = import ./container.nix;
      };
    };
}
