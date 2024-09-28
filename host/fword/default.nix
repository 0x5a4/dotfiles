{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../share/locale.nix
    ../share/wifi.nix

    inputs.hardware.nixosModules.framework-13th-gen-intel
    outputs.nixosModules.xfaf
  ];

  sops.age.keyFile = "/home/makrele/.config/sops/age/keys.txt";

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
    sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  };

  boot.plymouth.enable = true;
  xfaf.bootconfig.enable = true;
  xfaf.nixconfig.enable = true;
  xfaf.nixconfig.allowUnfree = true;

  sops.secrets = {
    fword-root = {
      format = "yaml";
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
    fword-makrele = {
      format = "yaml";
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
  };

  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users.root = {
      isSystemUser = true;
      hashedPasswordFile = config.sops.secrets.fword-root.path;
      uid = 0;
    };
  };

  xfaf.users.makrele = {
    opts = {
      shell = pkgs.fish;
      extraGroups = ["wheel" "video" "docker"];
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
  programs.hyprland.enable = true;
  xfaf.services.greetd = {
    enable = true;
    defaultUser = "makrele";
    command = "hyprland";
  };
  
  environment.variables = {
    NIXOS_OZONE_WL = 1;
  };

  networking.hostName = "fword";

  system.stateVersion = "23.11";
}
