{
  lib,
  config,
  ...
}:
{
  options.xfaf.bootconfig = {
    enable = lib.mkEnableOption "auto configure the boot loader";
  };

  config =
    let
      opts = config.xfaf.bootconfig;
    in
    lib.mkIf opts.enable {
      boot.loader = {
        timeout = 0;
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = true;
          editor = false;
        };
      };

      boot.kernelParams = lib.mkBefore [
        "quiet"
        "loglevel=3"
      ];
      boot.initrd.systemd.enable = true;
    };
}
