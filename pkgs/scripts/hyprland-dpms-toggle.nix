{
  writeShellApplication,
  jq,
  hyprland,
}:
writeShellApplication {
  name = "hyprland-dpms-toggle";

  runtimeInputs = [
    jq
    hyprland
  ];

  text = ''
    if (( $# == 0 )); then
        echo "usage: hyprland-dpms-toggle <monitor>"
        exit
    fi

    STATE=$(hyprctl monitors -j | jq ".[]|select(.name==\"$*\").dpmsStatus")

    if [ "$STATE" = "true" ]; then
        sleep 1 && hyprctl dispatch dpms off "$@"
    else
        sleep 1 && hyprctl dispatch dpms on "$@"
    fi
  '';
}
