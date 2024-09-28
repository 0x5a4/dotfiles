{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) toString;
in {
  imports = [
    ./power.nix
    ./window.nix
    ./notify.nix
    ./binds.nix
    ./rules.nix
  ];

  options.xfaf.desktop.hyprland = {
    enable = lib.mkEnableOption "install 0x5a4s hyprland config";
    cursor_warps = lib.mkEnableOption "enable cursor warps";
  };

  config = lib.mkIf config.xfaf.desktop.hyprland.enable {
    home.packages = with pkgs; [
      wlinhibit
      wl-clipboard
      xdg-desktop-portal-hyprland
    ];

    stylix.targets.hyprpaper.enable = lib.mkForce false;
    services.hyprpaper = let
      monitorsWithWallpaper = lib.filterAttrs (_: v: v.wallpaper != null) config.xfaf.desktop.monitors;
    in {
      enable = true;
      settings = {
        splash = true;
        preload = lib.unique (lib.mapAttrsToList (_: v: builtins.toString v.wallpaper) monitorsWithWallpaper);
        wallpaper = lib.mapAttrsToList (name: v: "${name}, ${v.wallpaper}") monitorsWithWallpaper;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor =
          lib.foldlAttrs
          (
            acc: name: value: (let
              refreshRate = lib.optionalString (value.refreshRate != null) "@${value.refreshRate}";

              resolution =
                if value.resolution != null
                then "${value.resolution}${refreshRate}"
                else "preferred${refreshRate}";

              position =
                if value.position != null
                then value.position
                else "auto";

              rotationMap = {
                "0" = "0";
                "90" = "1";
                "180" = "2";
                "270" = "3";
              };

              rotation = let
                transform =
                  if (rotationMap ? "${toString value.rotate}")
                  then rotationMap."${toString value.rotate}"
                  else abort "hyprland only accepts rotations in 90 degree steps";
              in ",transform,${transform}";
            in
              acc ++ ["${name},${resolution},${position},${toString value.scale}${rotation}"])
          )
          [",preferred,auto,1"]
          config.xfaf.desktop.monitors;

        workspace =
          lib.foldlAttrs
          (acc: name: value:
            acc
            ++ (
              lib.map (w: let
                default =
                  if value ? "defaultWorkspace"
                  then value.defaultWorkspace == w
                  else false;
              in "${toString w}, monitor:${name}, default:${toString default}")
              value.workspaces
            ))
          []
          config.xfaf.desktop.monitors;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        general = {
          layout = "dwindle";
          border_size = 1;
          gaps_in = 2;
          gaps_out = 5;
        };

        cursor = {
          no_warps = !config.xfaf.desktop.hyprland.cursor_warps;
          inactive_timeout = 0;
        };

        misc = {
          mouse_move_focuses_monitor = false;
          key_press_enables_dpms = true;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = "de";
          kb_variant = "nodeadkeys";
          kb_options = "caps:escape";

          follow_mouse = 2;
          sensitivity = 0;
          numlock_by_default = true;

          touchpad = {
            natural_scroll = false;
          };
        };

        decoration = {
          rounding = 5;

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          inactive_opacity = 0.95;

          blur.size = 3;
        };

        animations = {
          enabled = true;
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
            "specialWorkspace, 1, 6, default, slidevert"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
          smart_resizing = false;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
        };
      };
    };
  };
}
