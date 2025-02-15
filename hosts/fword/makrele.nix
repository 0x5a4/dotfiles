{
  pkgs,
  lib,
  outputs,
  ...
}:
{
  imports = [
    outputs.homeModules.xfaf

    ../share/common-home.nix
  ];

  xfaf.desktop.wayfire.enable = true;
  xfaf.desktop.hyprpaper.enable = true;

  xfaf.desktop.wluma.enable = true;
  xfaf.desktop.batsignal.enable = true;

  xfaf.desktop.monitors =
    let
      externalConfig = {
        workspaces = [ 0 ];
        defaultWorkspace = 0;
        bar = {
          enable = true;
          modules.left = {
            clock = true;
            network = true;
            bluetooth = true;
          };
          modules.right = {
            battery = true;
            volume = true;
          };
        };
      };
    in
    {
      eDP-1 = {
        scale = 1.175;
        workspaces = lib.range 1 9;
        defaultWorkspace = 1;
        bar = {
          enable = true;
          modules.left = {
            clock = true;
            hyprland-workspaces = true;
            system-load = true;
            network = true;
            bluetooth = true;
          };
          modules.right = {
            uptime = true;
            battery = true;
            volume = true;
            brightness = true;
            idle-inhibit = true;
            hyprland-submap = true;
          };
        };
      };
      DP-1 = externalConfig;
      DP-2 = externalConfig;
      DP-3 = externalConfig;
      DP-4 = externalConfig;
    };

  home.packages = with pkgs; [
    element-desktop
    jetbrains.idea-ultimate
    libreoffice
    prismlauncher
    spotify
    thunderbird
  ];

  home.stateVersion = "23.11";
}
