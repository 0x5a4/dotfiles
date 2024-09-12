{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.xfaf.desktop.hyprland.enable && config.xfaf.desktop.mako.enable) {
    wayland.windowManager.hyprland.extraConfig =
      /*
      hyprlang
      */
      ''
        bind = SUPER, n, submap, notify

        submap = notify

        bind = SUPER, n, submap, reset
        bind = , escape, submap, reset

        bind = , space, exec, makoctl dismiss --all
        bind = , space, submap, reset
        bind = , r, exec, makoctl restore
        bind = , q, exec, mako-toggle-mode do-not-disturb && makoctl mode -r shut-up
        bind = , q, submap, reset
        bind = SHIFT, q, exec, mako-toggle-mode shut-up && makoctl mode -r do-not-disturb
        bind = SHIFT, q, submap, reset
        bind = , w, exec, makoctl mode -s default
        bind = , w, submap, reset

        submap = reset
      '';
  };
}
