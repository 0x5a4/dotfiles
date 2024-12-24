{
  writeShellApplication,
  slurp,
  wl-mirror,
  hyprland,
}:
writeShellApplication {
  name = "hyprland-mirror";

  runtimeInputs = [
    slurp
    wl-mirror
    hyprland
  ];

  text = ''
    doslurp() {
        slurp -b \#00000000 -B \#00000000 -c \#859900 -w 4 -f %o -or
    }

    echo "select mirror target"
    TARGET=$(doslurp)
    echo "selected $TARGET"
    echo "select mirror display"
    DISPLAY=$(doslurp)
    echo "selected $DISPLAY"

    hyprctl dispatch exec "\
        [monitor $DISPLAY; fullscreen; nodim; noanim] \
        wl-mirror $TARGET"

    sleep 0.1

    hyprctl dispatch workspace previous
  '';
}
