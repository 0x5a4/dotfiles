{
  pkgs,
  lib,
  xfaf-lib,
  inputs,
  outputs,
  ...
}:
{
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

  terminal.font = "${pkgs.nerd-fonts.noto}/share/fonts/truetype/NerdFonts/Noto/NotoMonoNerdFontMono-Regular.ttf";

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
      inherit xfaf-lib inputs outputs;
    };
  };

  user.shell = "${pkgs.fish}/bin/fish";

  system.stateVersion = "24.05";
}
