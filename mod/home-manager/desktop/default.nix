{ lib, ... }:
{
  imports = lib.xfaf.importAllChildren ./.;

  options.xfaf.desktop =
    let
      t = lib.types;
    in
    {
      browserCommand = lib.mkOption {
        description = "command used for running the browser";
        type = t.str;
      };

      terminalCommand = lib.mkOption {
        description = "command used for running the terminal";
        type = t.str;
      };

      launcherCommand = lib.mkOption {
        description = "command used for running the launcher";
        type = t.str;
      };

      monitors =
        let
          monitorOpts = t.submodule {
            options = {
              resolution = lib.mkOption {
                description = "resolution of this monitor. if not specified, resolution is inferred";
                type = t.nullOr t.nonEmptyStr;
                default = null;
              };

              refreshRate = lib.mkOption {
                description = "refresh rate of this monitor. if not specified, refresh rate is inferred";
                type = t.nullOr t.nonEmptyStr;
                default = null;
              };

              position = lib.mkOption {
                description = "absolute position of this monitor, e.g. 0x-1080";
                type = t.nullOr t.nonEmptyStr;
                default = null;
              };

              scale = lib.mkOption {
                description = "fractional scale of this monitor";
                type = t.nullOr t.number;
                default = 1;
              };

              rotate = lib.mkOption {
                description = "rotation of this monitor in degrees";
                type = t.ints.between 0 360;
                default = 0;
              };

              workspaces = lib.mkOption {
                description = "list of workspaces to bind to this monitor";
                type = t.listOf (t.either t.int t.nonEmptyStr);
                default = [ ];
              };

              defaultWorkspace = lib.mkOption {
                description = "default workspace selected on this monitor";
                type = t.nullOr (t.either t.int t.nonEmptyStr);
                default = null;
              };

              wallpaper = lib.mkOption {
                description = "wallpaper for this monitor";
                type = t.nullOr t.path;
                default = null;
              };

              bar =
                let
                  mkModuleOption = name: lib.mkEnableOption "enable the ${name} module";

                  moduleOpts = {
                    clock = mkModuleOption "clock";
                    hyprland-workspaces = mkModuleOption "hyprland workspaces";
                    hyprland-submap = mkModuleOption "hyprland submap";
                    system-load = mkModuleOption "system load";
                    battery = mkModuleOption "battery";
                    network = mkModuleOption "network";
                    bluetooth = mkModuleOption "bluetooth";
                    uptime = mkModuleOption "uptime";
                    idle-inhibit = mkModuleOption "idle inhibitor";
                    brightness = mkModuleOption "brightness";
                    volume = mkModuleOption "volume";
                  };
                in
                {
                  enable = lib.mkEnableOption "enable a bar on this monitor";

                  position = lib.mkOption {
                    description = "position of this bar";
                    type = t.enum [
                      "top"
                      "left"
                      "right"
                      "bottom"
                    ];
                    default = "top";
                  };

                  modules.left = moduleOpts;
                  modules.center = moduleOpts;
                  modules.right = moduleOpts;
                };
            };
          };
        in
        lib.mkOption {
          type = t.attrsOf monitorOpts;
          default = { };
        };
    };
}
