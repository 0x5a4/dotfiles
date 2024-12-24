{
  writeShellApplication,
  wob,
}:
writeShellApplication {
  name = "run-wob";

  runtimeInputs = [
    wob
  ];

  text = ''
    if (( $# < 1 )); then
        echo "usage: run-wob <socket>"
        exit
    fi

    rm -f "$@"
    mkfifo "$@"
    tail -f "$@" | wob
  '';
}
