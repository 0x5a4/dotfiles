{pkgs, inputs, ...}: {
  environment.etcBackupExtension = ".bak";

  environment.packages = with pkgs; [
    nano

    # Some common stuff that people expect to have
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
    I officially diagnose you with a serious nix addiction!
  '';

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Europe/Berlin";

  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
  };

  user.shell = "${pkgs.fish}/bin/fish";

  system.stateVersion = "24.05";
}
