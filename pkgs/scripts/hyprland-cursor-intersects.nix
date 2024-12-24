{
  writeShellApplication,
  jq,
  hyprland,
}:
writeShellApplication {
  name = "hyprland-cursor-intersects";

  runtimeInputs = [
    jq
    hyprland
  ];

  text = ''
    CURSORPOS="$(hyprctl -j cursorpos)"
    X=$(echo "$CURSORPOS" | jq -e .x)
    Y=$(echo "$CURSORPOS" | jq -e .y)

    ACTIVE_WORKSPACE="$(hyprctl -j activeworkspace | jq -e .id)"

    INTERSECTS=$(hyprctl -j clients | jq -e ".[] |
        select(.mapped) |
        select(
            .at[0] <= $X and
            .at[0] + .size[0] >= $X and
            .at[1] <= $Y and
            .at[1] + .size[1] >= $Y
        ) |
        select(.workspace.id==$ACTIVE_WORKSPACE)
    ")

    # prioritize fullscreen > floating > tiled
    echo "$INTERSECTS" | jq -se "sort_by(.floating | not) | sort_by(.fullscreen | not)"
  '';
}
