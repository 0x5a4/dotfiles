{
  config,
  lib,
  ...
}:
{
  options.xfaf.desktop.apps.tofi = {
    enable = lib.mkEnableOption "install 0x5a4s tofi config";
    makeDefault = lib.mkEnableOption "make tofi the default launcher";
  };

  config =
    let
      opts = config.xfaf.desktop.apps.tofi;
    in
    lib.mkIf opts.enable {
      stylix.targets.tofi.enable = false;

      xfaf.desktop.launcherCommand = lib.mkIf opts.makeDefault "tofi-drun";

      programs.tofi = {
        enable = true;
        settings = {
          auto-accept-single = true;
          drun-launch = true;
          width = "100%";
          height = "100%";
          border-width = 0;
          outline-width = 0;
          padding-left = "35%";
          padding-top = "35%";
          result-spacing = 25;
          num-results = 5;
          background-color = "#000A";
          font-size = 20;
          font = config.stylix.fonts.monospace.name;
        };
      };
    };
}
