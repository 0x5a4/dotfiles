{
  config,
  pkgs,
  sops,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";

  sops.age.keyFile = "/home/notuser/.config/sops/age/keys.txt";

  imports = [
    ./hardware-configuration.nix
    ../share/desktop.nix
    ../share/wifi.nix
    ../share/cmdline.nix
  ];

  # Bootloader.
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "t420";

  # Enable swap on luks
  boot.initrd.luks.devices."luks-01c4abed-ca86-434d-a319-e2a1747fd239".device = "/dev/disk/by-uuid/01c4abed-ca86-434d-a319-e2a1747fd239";
  boot.initrd.luks.devices."luks-01c4abed-ca86-434d-a319-e2a1747fd239".keyFile = "/crypto_keyfile.bin";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.notuser = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "no";
    extraGroups = ["wheel"];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.fish;
  programs.ssh.startAgent = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
