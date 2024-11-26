{
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../share/common.nix
    ../share/wifi.nix

    inputs.hardware.nixosModules.framework-13th-gen-intel
    outputs.nixosModules.xfaf
  ];

  sops.age.keyFile = "/home/makrele/.config/sops/age/keys.txt";

  xfaf.nixconfig.allowUnfree = true;

  sops.secrets = {
    fword-root = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
    fword-makrele = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
  };

  users.users.root = {
    isSystemUser = true;
    hashedPasswordFile = config.sops.secrets.fword-root.path;
    uid = 0;
  };

  xfaf.users.makrele = {
    opts = {
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "video"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets.fword-makrele.path;
    };
    home-manager = {
      enable = true;
      config = ./makrele.nix;
    };
  };

  xfaf.services.tlp.enable = true;
  services.thermald.enable = true;

  xfaf.services.pipewire.enable = true;

  services.printing.enable = true;
  xfaf.services.avahi.enable = true;

  hardware.bluetooth.enable = true;

  # needed for desktop
  xfaf.services.greetd = {
    enable = true;
    command = "wayfire";
    defaultUser = "makrele";
    output = "eDP-1";
  };

  programs.steam.enable = true;

  networking.hostName = "fword";

  system.stateVersion = "23.11";
}
