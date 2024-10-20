{...}: {
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

    tlp = prev.tlp.overrideAttrs (old: {
      makeFlags =
        (old.makeFlags or [])
        ++ [
          "TLP_ULIB=/lib/udev"
          "TLP_NMDSP=/lib/NetworkManager/dispatcher.d"
          "TLP_SYSD=/lib/systemd/system"
          "TLP_SDSL=/lib/systemd/system-sleep"
          "TLP_ELOD=/lib/elogind/system-sleep"
          "TLP_CONFDPR=/share/tlp/deprecated.conf"
          "TLP_FISHCPL=/share/fish/vendor_completions.d"
          "TLP_ZSHCPL=/share/zsh/site-functions"
        ];
    });
  };
}
