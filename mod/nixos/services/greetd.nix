{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.xfaf.services.greetd =
    let
      t = lib.types;
    in
    {
      enable = lib.mkEnableOption "enable greetd";
      defaultUser = lib.mkOption {
        description = "user to log in as";
        type = t.nonEmptyStr;
      };
      command = lib.mkOption {
        description = "command to run on login";
        type = t.nonEmptyStr;
      };
      output = lib.mkOption {
        description = "output to show the greeter on";
        type = t.nullOr t.nonEmptyStr;
        default = null;
      };
    };

  config =
    let
      opts = config.xfaf.services.greetd;
    in
    lib.mkIf opts.enable {
      services.greetd = {
        enable = true;
        settings =
          let
            backgroundImage = pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/97444e18b7fe97705e8caedd29ae05e62cb5d4b7/wallpapers/nixos-wallpaper-catppuccin-macchiato.png";
              hash = "sha256-SkXrLbHvBOItJ7+8vW+6iXV+2g0f8bUJf9KcCXYOZF0=";
            };
            riverConfig = pkgs.writeScriptBin "greeter.river.init.sh" ''
              riverctl="${lib.getExe' pkgs.river-classic "riverctl"}"

              $riverctl keyboard-layout \
                -variant nodeadkeys \
                -options caps:escape \
                de

              $riverctl rule-add fullscreen
              ${lib.optionalString (opts.output != null) ''
                $riverctl rule-add output "${opts.output}"
              ''}

              $riverctl hide-cursor timeout 1
              $riverctl hide-cursor when-typing enabled

              $riverctl default-layout rivertile
              ${lib.getExe' pkgs.river-classic "rivertile"} &

              ${lib.getExe pkgs.swaybg} -mfill -i ${backgroundImage} &

              ${lib.getExe pkgs.greetd-mini-wl-greeter} \
                --user ${opts.defaultUser} \
                --command ${opts.command} \
                --background-image ${backgroundImage}

              $riverctl exit
            '';
          in
          {
            default_session.command = "${lib.getExe' pkgs.river-classic "river"} -c ${lib.getExe riverConfig}";
          };
      };
    };
}
