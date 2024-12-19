{
  writeShellApplication,
  wireplumber,
}:
writeShellApplication {
  name = "wob-volume";

  runtimeInputs = [
    wireplumber
  ];

  text = ''
    if (( $# < 1 )); then
        cat << END
    usage:
        volume <value>

    <value> is passed as-is to wpctl set-volume, unless
    it is 'muteon' 'muteoff' or 'mutetoggle' in which case
    the respective action is performed
    END
        exit
    fi

    case "$1" in
        muteon) wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
            ;;
        muteoff) wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            ;;
        mutetoggle) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            ;;
        *) wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"
            ;;
    esac

    LEVEL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/[^0-9]//g')

    if (wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED); then
        echo "$LEVEL muted" > "$XDG_RUNTIME_DIR/wob.sock"
    else
        echo "$LEVEL" > "$XDG_RUNTIME_DIR/wob.sock"
    fi
  '';
}
