{inputs, ...}: {
  additions = final: prev: import ./pkgs final.pkgs;

  overrides = final: prev: let
    nixpkgs-hyprland-39 = inputs.nixpkgs-hyprland-39.legacyPackages.${final.pkgs.stdenv.hostPlatform.system};
  in {
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
