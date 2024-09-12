{
  config,
  lib,
  ...
}: {
  options.xfaf.desktop.batsignal.enable = lib.mkEnableOption "run batsignal";

  config = lib.mkIf config.xfaf.desktop.batsignal.enable {
    services.batsignal = {
      enable = true;
      extraArgs = ["-i" "-w" "30" "-c" "15"];
    };
  };
}
