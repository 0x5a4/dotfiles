{
  config,
  lib,
  pkgs,
  ...
}: {
  options.xfaf.desktop.apps.rofi = {
    enable = lib.mkEnableOption "install 0x5a4s rofi config";
    makeDefault = lib.mkEnableOption "make rofi the default launcher";
  };

  config = let
    opts = config.xfaf.desktop.apps.rofi;
  in lib.mkIf opts.enable {
    stylix.targets.rofi.enable = false;

    xfaf.desktop.launcherCommand = lib.mkIf opts.makeDefault "rofi -show drun";
    
    programs.rofi = {
      enable = true;

      package = pkgs.rofi-wayland;

      theme = ../../../config/rofi-theme.rasi;

      plugins = with pkgs; [
        rofi-calc-wayland
      ];

      extraConfig = {
        normalize-match = true;
        show-icons = true;
      };
    };
  };
}
