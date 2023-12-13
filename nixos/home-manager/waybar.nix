{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        output = "eDP-1";
        layer = "top";
        position = "top";
        exclusive = true;
        passtrough = false;
        height = 32;
        modules-left = [
          "clock"
          "hyprland/workspaces"
          "memory"
          "cpu"
          "network"
          "bluetooth"
        ];
        modules-right = [
          "hyprland/submap"
          "battery"
          "backlight"
          "custom/mako"
          "wireplumber"
          "user"
        ];
      } // (builtins.fromJSON (builtins.readFile ../../config/waybar/shared-modules.json));
    };
  };
}
