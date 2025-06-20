{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.xfaf.desktop.waybar.enable = lib.mkEnableOption "install 0x5a4s waybar config";

  config = lib.mkIf config.xfaf.desktop.waybar.enable (
    let
      sharedModules = pkgs.writeText "waybar-modules.json" (
        builtins.toJSON {
          clock = {
            format = "  {:%R %d/%m}";
          };
          "hyprland/workspaces" = {
            all-outputs = true;
            format = "{name}";
            sort-by-number = true;
          };
          "hyprland/submap" = {
            tooltip = false;
            on-click = "${pkgs.hyprland}/bin/hyprctl dispatch submap reset";
          };
          "river/mode" = {
            tooltip = false;
            on-click = "${pkgs.river}/bin/riverctl enter-mode normal";
          };
          "river/tags" = rec {
            tooltip = false;
            num-tags = 10;
            tag-labels = (map toString (lib.range 1 9) ++ [ 0 ]);
            set-tags = lib.xfaf.powersOfTwo 10;
            toggle-tags = set-tags;
            hide-vacant = true;
          };
          cpu = {
            interval = 5;
            format = "";
            states = {
              medium = 20;
              high = 60;
            };
          };
          memory = {
            interval = 10;
            format = "";
            states = {
              medium = 40;
              high = 80;
            };
          };
          wireplumber = {
            tooltip = false;
            format = "{icon} {volume}%";
            format-muted = "󰝟 <span strikethrough='true'>{volume}%</span>";
            format-icons = [
              ""
              ""
              ""
            ];
            on-click = "${lib.getExe pkgs.wp-switch-output}";
            on-click-right = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
            states = {
              high = 80;
            };
          };
          battery = {
            format = "{icon} {capacity}%";
            format-charging = "{icon} {capacity}% 󱐋";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            states = {
              low = 20;
            };
          };
          network = {
            format = "{ifname}";
            format-wifi = "  {essid} ({signalStrength}%)";
            format-ethernet = " 󰈁 ";
            format-disconnected = "";
          };
          bluetooth = {
            format = "";
            format-disabled = "󰂲";
            format-connected = " {num_connections}";
            tooltip-format = "{controller_alias}\t{controller_address}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            on-click-right = "${lib.getExe' pkgs.tlp "bluetooth"} toggle";
          };
          backlight = {
            tooltip = false;
            device = "intel_backlight";
            format = "{icon} {percent}%";
            format-icons = [
              ""
              ""
            ];
          };
          user = {
            format = "🐢 up {work_H}:{work_M}";
          };
          idle_inhibitor = {
            format = "{icon}";
            tooltip = false;
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
          tray = {
            icon-size = 21;
            spacing = 10;
          };
        }
      );
    in
    {
      stylix.targets.waybar.enable = false;

      home.packages = [ pkgs.nerd-fonts.symbols-only ];

      programs.waybar = {
        enable = true;
        systemd.enable = true;
        style = ./waybar.css;
        settings =
          let
            # dont forget to flatten the result!
            mkModuleList = cfg: [
              (lib.optional cfg.uptime "user")
              (lib.optional cfg.clock "clock")
              (lib.optional cfg.hyprland-workspaces "hyprland/workspaces")
              (lib.optional cfg.river-tags "river/tags")
              (lib.optionals cfg.system-load [
                "memory"
                "cpu"
              ])
              (lib.optional cfg.battery "battery")
              (lib.optional cfg.idle-inhibit "idle_inhibitor")
              (lib.optional cfg.brightness "backlight")
              (lib.optional cfg.volume "wireplumber")
              (lib.optional cfg.network "network")
              (lib.optional cfg.bluetooth "bluetooth")
              (lib.optional cfg.hyprland-submap "hyprland/submap")
              (lib.optional cfg.river-mode "river/mode")
              (lib.optional cfg.tray "tray")
            ];
          in
          config.xfaf.desktop.monitors
          |> lib.filterAttrs (_: v: v.bar.enable)
          |> lib.mapAttrs (
            name: value: {
              layer = "top";
              position = value.bar.position;
              output = name;
              height = 32;

              include = sharedModules |> builtins.toString |> lib.singleton;

              modules-left = value.bar.modules.left |> mkModuleList |> lib.flatten;

              modules-center = value.bar.modules.center |> mkModuleList |> lib.flatten;

              modules-right = value.bar.modules.right |> mkModuleList |> lib.reverseList |> lib.flatten;
            }
          );
      };
    }
  );
}
