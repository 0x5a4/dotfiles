{
  config,
  lib,
  pkgs,
  ...
}: {
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

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

  # home-manager = {
  #   config = ./home.nix;
  #   backupFileExtension = "hm-bak";
  #   useGlobalPkgs = true;
  # };

  user.shell = "${pkgs.fish}/bin/fish";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";
}
