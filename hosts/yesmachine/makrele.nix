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

  stylix.fonts.sizes.terminal = 10;

  xfaf.desktop.hyprland.enable = true;
  xfaf.desktop.hyprpaper.enable = true;

  xfaf.desktop.apps.rofi = {
    enable = true;
    makeDefault = true;
  };

  xfaf.desktop.monitors =
    let
      wallpaper-image = pkgs.fetchurl {
        name = "yesmachine-wallpaper-image";
        url = "https://images.wallpapersden.com/image/download/galaxies-pixel-art_bGpsaW6UmZqaraWkpJRnamtlrWZlbWU.jpg";
        hash = "sha256-Em1ECfdippXbFn7X4hOnqnzCONRt/Y00bFINdCvhe7M=";
      };

      wallpaper = pkgs.runCommandLocal "yesmachine-wallpaper" { } ''
        ${lib.getExe pkgs.imagemagick} ${wallpaper-image} -crop 50%x100% output.png
        mkdir $out
        mv output-0.png $out/left.png
        mv output-1.png $out/right.png
      '';
    in
    {
      DP-1 = {
        workspaces = lib.range 1 5;
        defaultWorkspace = 1;
        wallpaper = "${wallpaper}/right.png";
        position = "0x0";
        bar = {
          enable = true;
          modules.left = {
            clock = true;
          };
          modules.right = {
            uptime = true;
            volume = true;
            idle-inhibit = true;
            tray = true;
          };
        };
      };
      HDMI-A-1 = {
        workspaces = lib.range 6 10;
        defaultWorkspace = 6;
        wallpaper = "${wallpaper}/left.png";
        position = "-1920x0";
        bar = {
          enable = true;
          modules.left = {
            system-load = true;
            network = true;
          };
          modules.right = {
            clock = true;
            hyprland-workspaces = true;
            hyprland-submap = true;
          };
        };
      };
    };

  home.packages = with pkgs; [
    chromium
    element-desktop
    prismlauncher
    spotify
    thunderbird
    yubikey-manager
  ];

  home.stateVersion = "24.05";
}
