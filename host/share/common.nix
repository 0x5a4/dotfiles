{pkgs, ...}: {
  imports = [
    ./locale.nix
  ];

  boot.plymouth.enable = true;
  xfaf.bootconfig.enable = true;
  xfaf.nixconfig.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
    sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  };

  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
  };

  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };
}
