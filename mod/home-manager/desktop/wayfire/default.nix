{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./binds.nix
  ];

  options.xfaf.desktop.wayfire.enable = lib.mkEnableOption "install 0x5a4s wayfire config";

  config = lib.mkIf config.xfaf.desktop.wayfire.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal-wlr
      wl-clipboard
    ];

    wayland.windowManager.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wayfire-plugins-extra
        wcm
      ];
      settings = {
        core = {
          vwidth = 5;
          vheight = 5;
          plugins = lib.concatStringsSep " " [
            "animate"
            "annotate"
            "command"
            "cube"
            "decoration"
            "expo"
            "foreign-toplevel"
            "gtk-shell"
            "ipc"
            "oswitch"
            "session-lock"
            "shortcuts-inhibit"
            "simple-tile"
            "vswipe"
            "vswitch"
            "wm-actions"
            "wobbly"
            "wrot"
          ];
        };
        decoration = {
          title_height = 0;
          inactive_color = "\\#222222aa";
          active_color = "\\#333333dd";
        };
        input = {
          xkb_layout = "de";
          xkb_variant = "nodeadkeys";
          xkb_options = "caps:escape";
          kb_numlock_default_state = true;
          drag_lock = true;
        };
        cube = {
          zoom = 0.6;
          background_mode = "skydome";
          skydome_texture =
            builtins.toString
            <| pkgs.fetchurl {
              name = "skydome-texture.png";
              url = "https://img.itch.zone/aW1hZ2UvOTY3MDg0LzU1MjAyMTIucG5n/794x1000/K13gwE.png";
              hash = "sha256-psw6lxfxAcRSNZ/7Y3EQvpukL8HYpr0H96Wld3qL+wU=";
            };
        };
        simple-tile = {
          outer_vert_gap_size = 10;
          outer_horiz_gap_size = 10;
        };
        vswitch.wraparound = true;
        vswipe = {
          fingers = 3;
          gap = 0;
        };
        animate = {
          close_animation = "fire";
          open_animation = "zoom";
        };
      };
    };
  };
}
