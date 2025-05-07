{
  config,
  lib,
  ...
}:
{
  options.xfaf.desktop.hyprland =
    let
      t = lib.types;

      mkWorkspaceOpt =
        default: description:
        lib.mkOption {
          description = "workspace specifier for ${description}";
          type = t.either t.ints.unsigned t.str;
          default = default;
        };
    in
    {
      browserWorkspace = mkWorkspaceOpt 2 "firefox";
      officeWorkspace = mkWorkspaceOpt 3 "office stuff";
      gameWorkspace = mkWorkspaceOpt 4 "games! yay!";
      gameLauncherWorkspace = mkWorkspaceOpt 5 "game launchers";
      shadowRealmWorkspace = mkWorkspaceOpt 8 "stuff your ashamed to have installed (like chromium)";
      discordWorkspace = mkWorkspaceOpt 9 "discord";
      spotifyWorkspace = mkWorkspaceOpt "special:spotify" "spotify";

      extraGameClasses = lib.mkOption {
        description = "additional classes for games to apply rules to";
        type = t.listOf t.str;
        default = [ ];
      };
    };

  config = lib.mkIf config.xfaf.desktop.hyprland.enable {
    wayland.windowManager.hyprland.settings =
      let
        cfg = config.xfaf.desktop.hyprland;

        toStr = builtins.toString;

        browserWorkspace = toStr cfg.browserWorkspace;
        officeWorkspace = toStr cfg.officeWorkspace;
        gameWorkspace = toStr cfg.gameWorkspace;
        gameLauncherWorkspace = toStr cfg.gameLauncherWorkspace;
        shadowRealm = toStr cfg.shadowRealmWorkspace;
        discordWorkspace = toStr cfg.discordWorkspace;
        spotifyWorkspace = toStr cfg.spotifyWorkspace;

        genGameRules =
          classes:
          builtins.concatMap (e: [
            "workspace ${gameWorkspace}, class:${e}"
            "fullscreen, class:${e}"
            "idleinhibit always, class:${e}"
            "forcergbx, class:${e}"
          ]) classes;
      in
      {
        workspace =
          let
            spotifySelector =
              if lib.types.isType lib.types.str spotifyWorkspace then
                "name:${spotifyWorkspace}"
              else
                "${spotifyWorkspace}";
          in
          [
            "${spotifySelector},gapsout:100,on-created-empty:spotify --enable-features=UseOzonePlatform --ozone-platfrom=wayland"
          ];

        windowrule =
          [
            # Browser
            "workspace ${browserWorkspace} silent, class:(firefox|librewolf)"

            # Office Stuff
            "workspace ${officeWorkspace}, class:thunderbird"
            "workspace ${officeWorkspace}, class:filezilla"
            "workspace ${officeWorkspace}, class:libreoffice-.*"
            "workspace ${officeWorkspace}, class:soffice"

            # Game Launchers
            "workspace ${gameLauncherWorkspace} silent, class:org.prismlauncher.PrismLauncher"
            "workspace ${gameLauncherWorkspace} silent, class:steam"

            # Banish Chromium to the Shadow Realm
            "workspace ${shadowRealm} silent, class:Chromium-browser-chromium"
            "workspace ${shadowRealm} silent, class:[gG]oogle-chrome"

            # Communication
            "workspace ${discordWorkspace}, class:(discord|WebCord|vesktop)"
            "workspace ${discordWorkspace}, class:Element"

            # Spotify
            "workspace ${spotifyWorkspace} silent, class:Spotify"
            "tile, class:Spotify"
          ]
          ++ (
            genGameRules [
              "steam_app_[0-9]*"
              "Stardew Valley"
              "Minecraft\*? 1.[0-9|.]*"
              "com.mojang.minecraft"
              "hl_linux"
              "org.libretro.RetroArch"
              "^GT: New Horizons [0-9].[0-9](\.[0-9])?"
            ]
            ++ cfg.extraGameClasses
          );

        windowrulev2 = [
          # Steam needs some special stuff
          "workspace ${gameLauncherWorkspace} silent, title:Steam"
          "center, title:Steam" # this is for the steam update window
        ];
      };
  };
}
