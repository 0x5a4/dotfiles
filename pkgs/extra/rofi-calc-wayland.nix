{
  lib,
  rofi-calc,
  rofi-unwrapped,
  rofi-wayland,
}:
rofi-calc.overrideAttrs (
  _: oldAttrs: {
    buildInputs = (lib.remove rofi-unwrapped oldAttrs.buildInputs) ++ [ rofi-wayland ];
  }
)
