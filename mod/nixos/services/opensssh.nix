{
  config,
  lib,
  ...
}: {
  options.xfaf.services.ssh.enable = lib.mkEnableOption "enable the ssh server";

  config = lib.mkIf config.xfaf.services.ssh.enable {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  };
}
