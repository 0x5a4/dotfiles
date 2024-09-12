{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.xfaf.desktop.hyprland.enable {
    wayland.windowManager.hyprland.extraConfig =
      /*
      hyprlang
      */
      ''
        bind = SUPER, p, submap, power

        submap = power

        bind = SUPER, p, submap, reset
        bind = , escape, submap, reset

        bind = , s, exec, systemctl poweroff
        bind = , r, exec, systemctl reboot

        bind = , h, exec, systemctl hibernate
        bind = , h, submap, reset

        bind = , n, exec, systemctl suspend
        bind = , n, submap, reset

        bind = , l, exec, loginctl lock-session
        bind = , l, submap, reset

        bind = , i, exec, killall wlinhibit || wlinhibit
        bind = , i, submap, reset

        submap = reset
      '';
  };
}
