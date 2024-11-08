pkgs: {
  # pkg = pkgs.callPackage ./pkg.nix {};
  greetd-mini-wl-greeter = pkgs.callPackage ./greetd-mini-wl-greeter.nix { };
  hyprland-cursor-intersects = pkgs.callPackage ./hyprland-cursor-intersects.nix { };
  hyprland-dpms-toggle = pkgs.callPackage ./hyprland-dpms-toggle.nix { };
  hyprland-mirror = pkgs.callPackage ./hyprland-mirror.nix { };
  mako-query-mode = pkgs.callPackage ./mako-query-mode.nix { };
  nix-trim-generations = pkgs.callPackage ./nix-trim-generations.nix { };
  run-wob = pkgs.callPackage ./run-wob.nix { };
  wob-brightness = pkgs.callPackage ./wob-brightness.nix { };
  wob-volume = pkgs.callPackage ./wob-volume.nix { };
  wp-switch-output = pkgs.callPackage ./wp-switch-output.nix { };
}
