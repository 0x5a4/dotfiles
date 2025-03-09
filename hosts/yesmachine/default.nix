{
  outputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../share/common.nix

    outputs.nixosModules.xfaf
  ];

  # sops.age.keyFile = "/home/makrele/.config/sops/age/keys.txt";

  stylix.image = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
    sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  };

  xfaf.nixconfig.allowUnfree = true;

  sops.secrets = {
    yesmachine-root = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
    yesmachine-makrele = {
      sopsFile = ../secrets/users.yaml;
      neededForUsers = true;
    };
  };

  users.users.root.hashedPasswordFile = config.sops.secrets.yesmachine-root.path;

  xfaf.users.makrele = {
    opts = {
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "video"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets.yesmachine-makrele.path;
    };
    home-manager = {
      enable = true;
      config = ./makrele.nix;
    };
  };

  xfaf.services.pipewire.enable = true;

  xfaf.services.ssh.enable = true;

  xfaf.services.avahi.enable = true;

  # needed for desktop
  programs.hyprland.enable = true;
  xfaf.services.greetd = {
    enable = true;
    defaultUser = "makrele";
    command = "Hyprland";
    output = "DP-1";
  };

  programs.steam.enable = true;

  services.pcscd.enable = true;

  networking.hostName = "yesmachine";

  system.stateVersion = "24.05";
}
