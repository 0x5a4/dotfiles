{
  config,
  lib,
  ...
}: {
  options.xfaf.services.avahi.enable = lib.mkEnableOption "enable avahi/mdns service";

  config = lib.mkIf config.xfaf.services.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
