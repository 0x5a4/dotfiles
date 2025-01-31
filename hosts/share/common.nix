{ pkgs, config, lib, ... }:
{
  imports = [
    ./locale.nix
  ];

  sops.secrets.nix-conf = {
    sopsFile = ../secrets/nix-conf;
    format = "binary";
    mode = "0444";
  };

  boot.plymouth.enable = true;
  xfaf.bootconfig.enable = true;
  xfaf.nixconfig = {
    enable = true;
    extraNixConfFile = config.sops.secrets.nix-conf.path;
  };

  xfaf.sudo.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
  };

  security.pam.services.swaylock = { };

  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };
}
