{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.file = {
    ".config/hypr" = {
      source = ../../config/hypr;
      recursive = true;
    };
    ".config/hypr/hyprland.local.conf".text = ''
      # keybind overrides
      unbind = $mainMod, w
      bind = $mainMod, w, exec, firefox

      exec-once = batsignal -bif90

      $monitorName = eDP-1

      monitor = $monitorName, preferred, 0x0, 1.333333

      # bind workspaces
      workspace = $monitorName, 1
      workspace = $monitorName, 2
      workspace = $monitorName, 3
      workspace = $monitorName, 4
      workspace = $monitorName, 5
      workspace = $monitorName, 6
      workspace = $monitorName, 7
      workspace = $monitorName, 8
      workspace = $monitorName, 9
      workspace = $displayPort, 10

      submap = dpms

      bind = ,w, exec, hyprland-dpms-toggle $monitorName
      bind = ,w, submap, reset

      submap = reset

      # monitor things
      misc {
          disable_hyprland_logo = yes # fixes random stripes from the anime gurl
      }

      submap = wallpaper

      $wallpaperDir = ~/Pictures/wallpapers
      $hyprWallpaperDir = /usr/share/hyprland

      bind = ,1, exec, hyprctl hyprpaper preload "$wallpaperDir/katana-zero.jpg"
      bind = ,1, exec, hyprctl hyprpaper wallpaper "$monitorName,$wallpaperDir/katana-zero.jpg"

      submap = reset
    '';
  };
}
