{
  writeShellApplication,
  wireplumber,
  jq,
  rofi-wayland,
}:
writeShellApplication {
  name = "wp-switch-output";

  runtimeInputs = [
    wireplumber
    jq
    rofi-wayland
  ];

  text = ''
    # create auxiliary wpexec script to list sinks
    SCRIPTFILE="/tmp/wpexec-list-sinks.lua"

    if [ ! -f "''${SCRIPTFILE}" ]; then
        tee "''${SCRIPTFILE}" > /dev/null << EOF
    #!/usr/bin/env wpexec

    obj_mgr = ObjectManager {
        Interest { type = "node" },
    }

    obj_mgr:connect("installed", function(om)
        local interest = Interest { type = "node",
            Constraint { "media.class", "matches", "*/Sink" }
        }

        local sinks = {}
        for obj in om:iterate(interest) do
            table.insert(sinks, ({
                id = obj["bound-id"],
                desc = obj["global-properties"]["node.description"]
            }))
        end

        local json = "["
        for i, sink in ipairs(sinks) do
            json = json .. '{ "id": "' .. sink.id .. '", "desc": "' .. sink.desc .. '" }'
            if i ~= #sinks then
                json = json .. ", "
            end
        end
        json = json .. "]"

        print(json)

        Core.quit()
    end)


    obj_mgr:activate()
    EOF
        chmod +x "''${SCRIPTFILE}"
    fi

    # get sinks as json
    SINKS=$("''${SCRIPTFILE}")
    # let the use select one through rofi
    SELECTION=$(echo "''${SINKS}" | jq -re '.[]|"\(.desc)"' | rofi -dmenu)
    # associate the selection back to its sink id
    SINKID=$(echo "''${SINKS}" | jq -re ".[]|select(.desc==\"''${SELECTION}\")|.id")

    # finally change default audio device
    wpctl set-default "''${SINKID}"
  '';
}
