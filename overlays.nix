{inputs, ...}: {
  additions = final: prev: import ./pkgs final.pkgs;

  overrides = final: prev: {
    rofi-calc-wayland =
      prev.rofi-calc.overrideAttrs
      (finalAttrs: oldAttrs: let
        unRofiInputs = prev.lib.lists.remove prev.rofi-unwrapped oldAttrs.buildInputs;
      in {
        buildInputs = unRofiInputs ++ [prev.rofi-wayland];
      });

    hyprland =
      prev.hyprland.overrideAttrs
      (finalAttrs: oldAttrs: {
        patches =
          (oldAttrs.patches or [])
          ++ [./config/hyprland_splashes.patch];
      });
  };
}
