{inputs, ...}: {
  additions = final: prev: import ./pkgs final.pkgs;

  overrides = final: prev: let
    nixpkgs-hyprland-39 = inputs.nixpkgs-hyprland-39.legacyPackages.${final.pkgs.stdenv.hostPlatform.system};
  in {
    rofi-calc-wayland =
      prev.rofi-calc.overrideAttrs
      (finalAttrs: previousAttrs: let
        unRofiInputs = prev.lib.lists.remove prev.rofi-unwrapped previousAttrs.buildInputs;
      in {
        buildInputs = unRofiInputs ++ [prev.rofi-wayland];
      });
  };
}
