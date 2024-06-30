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

      exec-once = batsignal -bi

      $monitorName = eDP-1
      $fscsright = Dell Inc. DELL P2715Q V48W271PA8VL
      $fscsleft = Dell Inc. DELL P2715Q V48W271PA4BL
      $fscsother = Dell Inc. DELL P2715Q V48W271PA4CL
      $fscsbeamer = Acer Technologies H6510BD JFZ110018401

      monitor = $monitorName, preferred, 0x0, 1.333333
      monitor = desc:$fscsright, preferred, 0x-1440, 1.5
      monitor = desc:$fscsleft, preferred, 0x-1440, 1.5
      monitor = desc:$fscsother, preferred, 0x-1440, 1.5
      monitor = desc:$fscsbeamer, preferred, 0x-1080, 1

      # bind workspaces
      workspace = 1, monitor:$monitorName, default:true
      workspace = 2, monitor:$monitorName
      workspace = 3, monitor:$monitorName
      workspace = 4, monitor:$monitorName
      workspace = 5, monitor:$monitorName
      workspace = 6, monitor:$monitorName
      workspace = 7, monitor:$monitorName
      workspace = 8, monitor:$monitorName
      workspace = 9, monitor:$monitorName
      workspace = 10, monitor$displayPort, default:true

      submap = dpms

      bind = ,w, exec, hyprland-dpms-toggle $monitorName
      bind = ,w, submap, reset

      submap = reset

      # monitor things
      misc {
          disable_hyprland_logo = yes # fixes random stripes from the anime gurl
      }

      cursor {
          no_warps = false
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
