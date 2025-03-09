{
  modulesPath,
  lib,
  config,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko-config.nix
    ./hardware-configuration.nix

    ../share/common.nix

    outputs.nixosModules.xfaf
  ];

  sops.age.keyFile = "/home/makrele/.config/sops/age/keys.txt";

  sops.secrets = {
    helmut-root = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
    helmut-makrele = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
  };

  stylix.image = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
    sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  };

  users.users.root.hashedPasswordFile = config.sops.secrets.helmut-root.path;

  xfaf.users.makrele = {
    opts = {
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICAoWrXcbe0HbxOHRqbeSofUoYez8l5ydvTfpop0I5gD fword"
      ];
      hashedPasswordFile = config.sops.secrets.helmut-makrele.path;
    };
    home-manager = {
      enable = true;
      config = ./makrele.nix;
    };
  };

  security.pam.sshAgentAuth.enable = true;

  xfaf.services.ssh.enable = true;

  xfaf.services.tailscale = {
    enable = true;
    secretsFile = ../secrets/tailscale;
  };

  xfaf.services.traefik.enable = true;

  xfaf.services.vaultwarden = {
    enable = true;
    secretsFile = ../secrets/vaultwarden-env;
  };

  networking = {
    hostName = "helmut";
    hostId = "4e98920d";

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "enp3s0";
      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };
  };

  system.stateVersion = "24.05";
}
