{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.xfaf.desktop.wayfire.enable (
    let
      desktopOpts = config.xfaf.desktop;
    in
    {
      wayland.windowManager.wayfire.settings = {
        core.close_top_view = "<super> KEY_Q";
        annotate.clear_workspace = "<super> KEY_RIGHTBRACE";
        cube.activate = "<super> <alt> BTN_RIGHT";
        expo = {
          toggle = "<super> KEY_E";
        };

        vswitch =
          {
            binding_left = "<super> <alt> KEY_H";
            binding_down = "<super> <alt> KEY_J";
            binding_up = "<super> <alt> KEY_K";
            binding_right = "<super> <alt> KEY_L";
            binding_10 = "<super> KEY_0";
            send_win_10 = "<super> <shift> KEY_0";
            send_with_win_10 = "<super> <alt> <shift> KEY_0";
          }
          // (
            lib.range 1 9
            |> builtins.map (x: [
              {
                name = "binding_${builtins.toString x}";
                value = "<super> KEY_${builtins.toString x}";
              }
              {
                name = "send_win_${builtins.toString x}";
                value = "<super> <shift> KEY_${builtins.toString x}";
              }
              {
                name = "send_with_win_${builtins.toString x}";
                value = "<super> <alt> <shift> KEY_${builtins.toString x}";
              }
            ])
            |> lib.concatLists
            |> builtins.listToAttrs
          );

        simple-tile = {
          button_move = "<super> BTN_LEFT";
          button_resize = "<super> BTN_RIGHT";
          key_toggle = "<super> KEY_V";
        };
        wm-actions.toggle_fullscreen = "<super> KEY_F";
        command = {
          binding_terminal = "<super> KEY_T";
          command_terminal = desktopOpts.terminalCommand;
          binding_browser = "<super> KEY_W";
          command_browser = desktopOpts.browserCommand;
          binding_launcher = "<super> KEY_SPACE";
          command_launcher = "killall ${builtins.head (lib.splitString " " desktopOpts.launcherCommand)} || ${desktopOpts.launcherCommand}";
          binding_calc = "<super> KEY_C";
          command_calc = "killall rofi || rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command \"echo -n '{result}' | wl-copy\"";
          binding_screenshot = "KEY_SYSRQ";
          command_screenshot = "${lib.getExe pkgs.grim} -g \"''$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
          # Volume
          binding_volume_mute = "KEY_MUTE";
          command_volume_mute = "${lib.getExe pkgs.wob-volume} mutetoggle";
          repeatable_binding_volume_down = "KEY_VOLUMEDOWN";
          command_volume_down = "${lib.getExe pkgs.wob-volume} 2%-";
          repeatable_binding_volume_up = "KEY_VOLUMEUP";
          command_volume_up = "${lib.getExe pkgs.wob-volume} 2%+";
          # Brightness
          repeatable_binding_brightness_down = "KEY_BRIGHTNESSDOWN";
          command_brightness_down = "${lib.getExe pkgs.wob-brightness} -1";
          repeatable_binding_brightness_up = "KEY_BRIGHTNESSUP";
          command_brightness_up = "${lib.getExe pkgs.wob-volume} +1";
        };
      };
    }
  );
}
