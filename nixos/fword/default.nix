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

  boot.initrd.luks.devices."luks-b6fef4c9-c9ec-43dc-a200-1ec9e9b58ccb".device = "/dev/disk/by-uuid/b6fef4c9-c9ec-43dc-a200-1ec9e9b58ccb";

  networking.hostName = "fword"; # Define your hostname.

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

  users.users.notuser = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "no";
    extraGroups = ["wheel" "video" "docker"];
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.fish;
  programs.ssh.startAgent = true;

  nixpkgs.config.allowUnfree = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;

      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
    };
  };

  services.thermald.enable = true;

  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  services.fwupd.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  system.stateVersion = "23.11";
}
