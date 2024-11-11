{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf (config.xfaf.desktop.hyprland.enable && config.xfaf.desktop.mako.enable) {
    wayland.windowManager.hyprland.extraConfig =
      # hyprlang
      ''
        bind = SUPER, n, submap, notify

        submap = notify

        bind = SUPER, n, submap, reset
        bind = , escape, submap, reset

        bind = , space, exec, ${lib.getExe' pkgs.mako "makoctl"} dismiss --all
        bind = , space, submap, reset
        bind = , r, exec, ${lib.getExe' pkgs.mako "makoctl"} restore
        bind = , q, exec, ${lib.getExe' pkgs.mako "makoctl"} mode -t do-not-disturb && ${lib.getExe' pkgs.mako "makoctl"} mode -r shut-up
        bind = , q, submap, reset
        bind = SHIFT, q, exec, ${lib.getExe' pkgs.mako "makoctl"} -t shut-up && ${lib.getExe' pkgs.mako "makoctl"} mode -r do-not-disturb
        bind = SHIFT, q, submap, reset
        bind = , w, exec, ${lib.getExe' pkgs.mako "makoctl"} mode -s default
        bind = , w, submap, reset

        submap = reset
      '';
  };
}
