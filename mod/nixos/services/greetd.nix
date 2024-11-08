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
      enable = lib.mkEnableOption "enable avahi/mdns service";
      defaultUser = lib.mkOption {
        description = "user to log in as";
        type = t.str;
      };
      command = lib.mkOption {
        description = "command to run on login";
        type = t.str;
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
            greeterCommand = pkgs.writeScriptBin "greeter.sh" ''
              export XKB_DEFAULT_LAYOUT=de
              export XKB_DEFAULT_VARIANT=nodeadkeys
              export XKB_DEFAULT_OPTION=caps:escape

              ${pkgs.cage}/bin/cage -s -m last -- \
                ${pkgs.greetd-mini-wl-greeter}/bin/greetd-mini-wl-greeter \
                --user ${opts.defaultUser} \
                --command ${opts.command} \
                --background-image ${backgroundImage}
            '';
          in
          {
            default_session = {
              command = "${greeterCommand}/bin/greeter.sh";
            };
          };
      };
    };
}
