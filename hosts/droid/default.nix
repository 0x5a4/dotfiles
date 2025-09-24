{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{
  imports = [ inputs.stylix.nixOnDroidModules.stylix ];

  environment.etcBackupExtension = ".bak";

  environment.packages = with pkgs; [
    nano

    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnused
  ];

  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-setup-storage.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    xdg-open.enable = true;
  };

  environment.motd = ''
    Welcome to Nix-on-Droid!
  '';

  stylix.image = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
    sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      package = pkgs.nixVersions.latest;
      extraOptions = ''
        experimental-features = nix-command flakes pipe-operators
      '';
      registry = (lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs) // {
        np.flake = flakeInputs.nixpkgs;
      };
    };

  time.timeZone = "Europe/Berlin";

  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  user.shell = "${pkgs.fish}/bin/fish";

  system.stateVersion = "24.05";
}
