{
  config,
  lib,
  ...
}: {
  options.xfaf.desktop.apps.kitty = {
    enable = lib.mkEnableOption "install 0x5a4s kitty config";
    makeDefault = lib.mkEnableOption "make kitty the default terminal";
    openTmux = lib.mkEnableOption "open tmux by default if kitty is run";
  };

  config = let
    opts = config.xfaf.desktop.apps.kitty;
  in
    lib.mkIf opts.enable {
      xfaf.desktop.terminalCommand =
        lib.mkIf
        opts.makeDefault "kitty ${lib.optionalString opts.openTmux "-e tmux"}";

      programs.kitty = {
        enable = true;
        shellIntegration = {
          enableBashIntegration = true;
          enableFishIntegration = true;
        };

        keybindings = {
          "ctrl+plus" = "change_font_size all +1.0";
          "ctrl+minus" = "change_font_size all -1.0";
        };

        settings = {
          update_check_interval = 0;
          confirm_os_window_close = 0;
          mouse_hide_wait = 0;
          notify_on_cmd_finish = "invisible 30";
          disable_ligatures = "always";
          font_features = "MonocraftNerdFontComplete- -liga";
          touch_scroll_multiplier = 5;
        };
      };
    };
}
