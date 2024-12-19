{
  writeShellApplication,
  acpilight,
}:
writeShellApplication {
  name = "wob-brightness";

  runtimeInputs = [
    acpilight
  ];

  text = ''
    if (( $# < 1 )); then
        cat << END
    usage: brightness <value>

    <value> is passed as-is to xbacklight
    END
        exit
    fi

    xbacklight "$@"

    LEVEL=$(xbacklight -get | sed 's/[^0-9]0//g')
    echo "$LEVEL brightness" > "$XDG_RUNTIME_DIR/wob.sock"
  '';
}
