{
  lib,
  host-config,
  config,
  ...
}:
{
  users.users.vaultwarden = {
    isSystemUser = true;
  };

  services.postgresql = {
    enable = true;
    ensureUsers = lib.singleton {
      name = config.users.users.vaultwarden.name;
      ensureDBOwnership = true;
    };
    ensureDatabases = [ "vaultwarden" ];
    authentication = lib.mkOverride 10 ''
      local all       all     trust
      host  all       all     all trust
    '';
  };

  systemd.services.vaultwarden.after = [ "postgresql.service" ];

  services.vaultwarden = {
    enable = true;
    dbBackend = "postgresql";
    environmentFile = host-config.sops.secrets.vaultwarden.path;
    config = {
      DOMAIN = "https://vaultwarden.helmut:80";
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8222;

      ROCKET_LOG = "critical";

      DATABASE_URL = "postgresql://localhost:5432/vaultwarden";

      SMTP_HOST = "mail.privateemail.com";
      SMTP_PORT = 465;
      SMTP_SECURITY = "force_tls";

      SMTP_FROM = "no-reply@wienstroer.net";
      SMTP_FROM_NAME = "Nicht der FSCS Password Manager";
      SMTP_USERNAME = "no-reply@wienstroer.net";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8222 ];
    };
    # Use systemd-resolved inside the container
    # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
    useHostResolvConf = lib.mkForce false;
  };

  services.resolved.enable = true;

  networking.hostName = "vaultwarden";

  system.stateVersion = "23.11";
}
