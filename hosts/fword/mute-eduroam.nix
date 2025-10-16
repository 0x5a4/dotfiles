{ lib, pkgs, ... }:
{
  systemd.user.services.eduroam-mute = {
    Install.WantedBy = [ "wireplumber.service" ];

    Unit = {
      Description = "mute wireplumber as soon as a connection to eduroam is established";
      After = [ "wireplumber.service" ];
    };

    Service =
      let
        wpaEventHandler = pkgs.writeShellApplication {
          name = "wpa-event-handler-script";

          runtimeInputs = with pkgs; [
            wpa_supplicant
            gnused
            wob-volume
          ];

          text = ''
            if [ "$2" = "CONNECTED" ]; then
              if [ "$(wpa_cli get_network "$WPA_ID" ssid | sed -e 's/^.//' -e 's/.$//' -e '2b;d')" = "eduroam" ]; then
                wob-volume muteon
              fi
            fi
          '';
        };
      in
      {
        ExecStart =
          lib.getExe
          <| pkgs.writeShellApplication {
            name = "eduroam-mute-start";

            runtimeInputs =
              with pkgs;
              [
                wpa_supplicant
                gnugrep
                gnused
              ]
              ++ [ wpaEventHandler ];

            text = ''
              WPA_ID=$(wpa_cli status | grep ^id= | sed 's/id=//') wpa-event-handler-script _ CONNECTED

              wpa_cli -a ${lib.getExe wpaEventHandler}
            '';
          };
        Restart = "always";

        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateUsers = true;
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service";
      };
  };
}
