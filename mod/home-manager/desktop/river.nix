{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.xfaf.desktop.river.enable = lib.mkEnableOption "install 0x5a4s river config";

  config = lib.mkIf config.xfaf.desktop.river.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal-wlr
      wl-clipboard
      rivercarro
    ];

    wayland.windowManager.river = {
      enable = true;
      extraConfig = ''
        rivercarro \
          -main-ratio 0.5 \
          -no-smart-gaps \
          -per-tag \
          &
      '';

      settings =
        let
          tagNames = map toString ((lib.range 1 9) ++ [ 0 ]);
          tagBits = lib.xfaf.powersOfTwo 10;
          tags = lib.zipListsWith (name: mask: { inherit name mask; }) tagNames tagBits;

          generateTagBindings =
            option:
            lib.listToAttrs (
              lib.map (t: {
                inherit (t) name;
                value = {
                  "${option}" = t.mask;
                };
              }) tags
            );

          spawnWithFlags = flags: command: "spawn ${flags} '${command}'";
          spawn = spawnWithFlags "";

          mediaKeys = {
            "None XF86AudioNext" = spawn "${lib.getExe pkgs.playerctl} -p spotify next";
            "None XF86AudioPrev" = spawn "${lib.getExe pkgs.playerctl} -p spotify previous";
            "None XF86AudioPlay" = spawn "${lib.getExe pkgs.playerctl} -p spotify play-pause";
            "None XF86AudioLowerVolume" = spawnWithFlags "-repeat" "${lib.getExe pkgs.wob-volume} 2%-";
            "None XF86AudioRaiseVolume" = spawnWithFlags "-repeat" "${lib.getExe pkgs.wob-volume} 2%+";
            "None XF86AudioMute" = spawn "${lib.getExe pkgs.wob-volume} mutetoggle";

            "None XF86MonBrightnessUp" = spawnWithFlags "-repeat" "${lib.getExe pkgs.wob-brightness} +1";
            "None XF86MonBrightnessDown" = spawnWithFlags "-repeat" "${lib.getExe pkgs.wob-brightness} -1";
          };
        in
        {
          default-layout = "rivercarro";

          set-repeat = "25 250";
          keyboard-layout = "-variant nodeadkeys -options caps:escape de";
          set-cursor-warp = "on-output-change";
          hide-cursor = {
            timeout = "2500";
            when-typing = "enabled";
          };
          input = {
            "pointer-*" = {
              drag = "enabled";
              disable-while-typing = "enabled";
              natural-scroll = "disabled";
              tap = "enabled";
              tap-button-map = "left-right-middle";
            };
          };

          map.normal = {
            "Super H" = "focus-view previous";
            "Super L" = "focus-view next";
            "Super+Shift H" = "swap previous";
            "Super+Shift L" = "swap next";

            "Super U" = "focus-output previous";
            "Super I" = "focus-output next";
            "Super+Shift U" = "send-to-output previous";
            "Super+Shift I" = "send-to-output next";

            "Super Return" = "zoom";

            "Super T" = spawn "${config.xfaf.desktop.terminalCommand}";
            "Super W" = spawn "${config.xfaf.desktop.browserCommand}";
            "Super Space" =
              spawn "${lib.getExe' pkgs.psmisc "killall"} ${builtins.head (lib.splitString " " config.xfaf.desktop.launcherCommand)} || ${config.xfaf.desktop.launcherCommand}";
            
            "Super C" = spawn ''${lib.getExe' pkgs.psmisc "killall"} rofi || rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n {result} | wl-copy"'';
            
            "None Print" =
              spawn "${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";

            "Super Q" = "close";
            "Super F" = "toggle-fullscreen";

            "None XF86Tools" = spawn "${lib.getExe pkgs.wp-switch-output}";
            "None XF86AudioMedia" = spawn "${lib.getExe pkgs.wp-switch-output}";

            "Super" = generateTagBindings "set-focused-tags";
            "Super+Shift" = generateTagBindings "set-view-tags";
            "Super+Alt" = generateTagBindings "toggle-focused-tags";
            "Super+Shift+Alt" = generateTagBindings "toggle-view-tags";

            "Super P" = "enter-mode power";
            "Super N" = "enter-mode notify";
          } // mediaKeys;

          map.locked = mediaKeys;

          declare-mode = [ "power" "notify" ];

          map.power = {
            "None Escape" = "enter-mode normal";
            "Super P" = "enter-mode normal";

            "None S" = spawn "systemctl poweroff";
            "None R" = spawn "systemctl reboot";

            "None H" = spawn "systemctl hibernate";
            "None N" = spawn "systemctl suspend";

            "None L" = spawn "loginctl lock-session";

            "None X" = "exit";

            "None I" =
              spawn "${lib.getExe' pkgs.psmisc "killall"} wlinhibit || ${lib.getExe' pkgs.wlinhibit "wlinhibit"}";
          };

          map.notify = {
            "None Escape" = "enter-mode normal";
            "Super N" = "enter-mode normal";

            "None Space" = spawn "${lib.getExe' pkgs.mako "makoctl"} dismiss --all";
            "None R" = spawn "${lib.getExe' pkgs.mako "makoctl"} restore";
          };
        };
    };
  };
}
