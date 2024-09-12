{
  writeShellApplication,
  mako,
}:
writeShellApplication {
  name = "mako-query-mode";

  runtimeInputs = [
    mako
  ];

  text = ''
    if (( $# == 0 )); then
        echo "usage: mako-query-mode <mode>"
        exit
    fi

    makoctl mode | grep --quiet "^$*\$"
  '';
}
