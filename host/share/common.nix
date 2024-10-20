{pkgs, config, ...}: {
  imports = [
    ./locale.nix
  ];

  sops.secrets.nix-conf = {
    sopsFile = ../secrets/nix-conf;
    format = "binary";
  };

  boot.plymouth.enable = true;
  xfaf.bootconfig.enable = true;
  xfaf.nixconfig = {
    enable = true; 
    extraNixConfFile = config.sops.secrets.nix-conf.path;
  };

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
