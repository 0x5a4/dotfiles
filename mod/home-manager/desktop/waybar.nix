{
  config,
  lib,
  pkgs,
  ...
}: {
  options.xfaf.desktop.waybar.enable = lib.mkEnableOption "install 0x5a4s waybar config";

  config = lib.mkIf config.xfaf.desktop.waybar.enable (let
    wlinhibit-script = pkgs.writeScriptBin "wlinhibit.sh" ''
      if pidof wlinhibit &> /dev/null; then
          echo '{"text":""}'
      else
          echo '{"text":"", "class":"deactivated"}'
      fi
    '';

    sharedModules = pkgs.writeText "waybar-modules.json" (builtins.toJSON {
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
        format-icons = ["" "" ""];
        on-click = "${pkgs.wp-switch-output}/bin/wp-switch-output";
        on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        states = {
          high = 80;
        };
      };
      battery = {
        format = "{capacity}% {icon}";
        format-charging = "󱐋 {capacity}% {icon}";
        format-icons = ["" "" "" "" ""];
        states = {
          low = 20;
        };
      };
      network = {
        format = "{ifname}";
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = " 󰈁 ";
        format-disconnected = "";
      };
      bluetooth = {
        format = "";
        format-disabled = "󰂲";
        format-connected = " {num_connections} connected";
        tooltip-format = "{controller_alias}\t{controller_address}";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click-right = "${pkgs.tlp}/bin/bluetooth toggle";
      };
      backlight = {
        tooltip = false;
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = ["" ""];
      };
      user = {
        format = "🐢 up {work_H}:{work_M}";
      };
      "custom/wlinhibit" = {
        tooltip = false;
        exec = "${wlinhibit-script}/bin/wlinhibit.sh";
        return-type = "json";
        restart-interval = 3;
        on-click = "killall wlinhibit || ${pkgs.wlinhibit}/bin/wlinhibit";
      };
    });
  in {
    stylix.targets.waybar.enable = false;

    home.packages = [
      (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ../../../config/waybar.css;
      settings = let
        # dont forget to flatten the result!
        mkModuleList = cfg: [
          (lib.optional cfg.uptime "user")
          (lib.optional cfg.clock "clock")
          (lib.optional cfg.hyprland-workspaces "hyprland/workspaces")
          (lib.optionals cfg.system-load ["memory" "cpu"])
          (lib.optional cfg.battery "battery")
          (lib.optional cfg.idle-inhibit "custom/wlinhibit")
          (lib.optional cfg.brightness "backlight")
          (lib.optional cfg.volume "wireplumber")
          (lib.optional cfg.network "network")
          (lib.optional cfg.bluetooth "bluetooth")
          (lib.optional cfg.hyprland-submap "hyprland/submap")
        ];
      in
        lib.mapAttrs (
          name: value: {
            layer = "top";
            position = value.bar.position;
            output = name;
            height = 32;

            include = [
              (builtins.toString sharedModules)
            ];

            modules-left = lib.pipe value.bar.modules.left [
              mkModuleList
              lib.flatten
            ];

            modules-center = lib.pipe value.bar.modules.center [
              mkModuleList
              lib.flatten
            ];

            modules-right = lib.pipe value.bar.modules.right [
              mkModuleList
              lib.reverseList
              lib.flatten
            ];
          }
        )
        (lib.filterAttrs (_: v: v.bar.enable) config.xfaf.desktop.monitors);
    };
  });
}
