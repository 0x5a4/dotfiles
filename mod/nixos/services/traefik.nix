{
  config,
  lib,
  ...
}:
{
  options.xfaf.services.traefik.enable = lib.mkEnableOption "enable traefik";

  config =
    let
      cfg = config.xfaf.services.traefik;
    in
    lib.mkIf cfg.enable {
      services.traefik = {
        enable = true;
        staticConfigOptions = {
          log.level = "DEBUG";
          accessLog.filePath = "/var/log/traefik.log";
          api = {
            dashboard = true;
          };
          entryPoints = {
            http = {
              address = ":80";
            };
            https = {
              address = ":443";
            };
          };
        };
        dynamicConfigOptions = {
          http.services.vaultwarden = {
            loadBalancer.servers = lib.singleton {
              url = "http://vaultwarden:8222";
            };
          };
          http.routers.dashboard = {
            entryPoints = [ "http" ];
            service = "api@internal";
            # change me
            rule = "Host(`helmut`)";
            tls = { };
          };
          http.routers.vaultwarden = {
            entryPoints = [ "http" ];
            service = "vaultwarden";
            # change me
            rule = "Host(`vaultwarden.helmut`)";
            tls = { };
          };
        };
      };
    };
}
