{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.xfaf.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings =
        let
          desktopOpts = config.xfaf.desktop;
        in
        {
          bind = [
            # app shortcuts
            "SUPER, w, exec, ${desktopOpts.browserCommand}"
            "SUPER, t, exec, ${desktopOpts.terminalCommand}"
            "SUPER, space, exec, killall ${builtins.head (lib.splitString " " desktopOpts.launcherCommand)} || ${desktopOpts.launcherCommand}"
            "SUPER, c, exec, killall rofi || rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command \"echo -n '{result}' | wl-copy\""

            # screenshots
            ",Print, exec, ${lib.getExe pkgs.grim} -g \"''$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"

            "SUPER, q, killactive, "
            "SUPER ALT, q, exit, "
            "SUPER, plus, layoutmsg, togglesplit"

            "SUPER, f, fullscreen, 0"
            "SUPER, m, fullscreen, 1"
            "SUPER SHIFT, f, fullscreenstate, -1 2"

            # vim bindings
            "SUPER, h, movefocus, l"
            "SUPER, l, movefocus, r"
            "SUPER, k, movefocus, u"
            "SUPER, j, movefocus, d"

            # Switch workspaces with SUPER + [0-9]
            "SUPER, s, togglespecialworkspace, spotify"
            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER, 5, workspace, 5"
            "SUPER, 6, workspace, 6"
            "SUPER, 7, workspace, 7"
            "SUPER, 8, workspace, 8"
            "SUPER, 9, workspace, 9"
            "SUPER, 0, workspace, 10"

            #switch monitors
            "SUPER, u, focusmonitor, +1"
            "SUPER, i, focusmonitor, -1"

            # Move active window to a workspace with SUPER + SHIFT + [0-9]
            "SUPER SHIFT, 1, movetoworkspacesilent, 1"
            "SUPER SHIFT, 2, movetoworkspacesilent, 2"
            "SUPER SHIFT, 3, movetoworkspacesilent, 3"
            "SUPER SHIFT, 4, movetoworkspacesilent, 4"
            "SUPER SHIFT, 5, movetoworkspacesilent, 5"
            "SUPER SHIFT, 6, movetoworkspacesilent, 6"
            "SUPER SHIFT, 7, movetoworkspacesilent, 7"
            "SUPER SHIFT, 8, movetoworkspacesilent, 8"
            "SUPER SHIFT, 9, movetoworkspacesilent, 9"
            "SUPER SHIFT, 0, movetoworkspacesilent, 10"

            # move active window to relative monitor
            "SUPER SHIFT, i, movewindow, mon:+1"
            "SUPER SHIFT, u, movewindow, mon:-1"

            # move the whole fucking workspace to a monitor
            "SUPER SHIFT ALT, i, movecurrentworkspacetomonitor, +1"
            "SUPER SHIFT ALT, u, movecurrentworkspacetomonitor, -1"

            # swap window with window in direction
            "SUPER SHIFT, h, swapwindow, l"
            "SUPER SHIFT, l, swapwindow, r"
            "SUPER SHIFT, k, swapwindow, u"
            "SUPER SHIFT, j, swapwindow, d"

            # switch output device
            ", XF86Tools, exec, ${lib.getExe pkgs.wp-switch-output}"
            ", XF86AudioMedia, exec, ${lib.getExe pkgs.wp-switch-output}"
            # present
            "SUPER, o, exec, ${lib.getExe pkgs.hyprland-mirror}"
            "SUPER SHIFT, o, exec, killall wl-mirror"
          ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          bindl = [
            ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} -p spotify next"
            ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} -p spotify previous"
            ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} -p spotify play-pause"
          ];

          bindle = [
            ",XF86AudioLowerVolume, exec, ${lib.getExe pkgs.wob-volume} 2%-"
            ",XF86AudioRaiseVolume, exec, ${lib.getExe pkgs.wob-volume} 2%+"
            ",XF86AudioMute, exec, ${lib.getExe pkgs.wob-volume} mutetoggle"

            ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.wob-brightness} +1"
            ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.wob-brightness} -1"
          ];
        };
    };
  };
}
