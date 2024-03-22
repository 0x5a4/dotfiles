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
    ../share/lsp.nix
  ];

  nix.registry = {
    nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
  };

  boot.kernelParams = ["quiet" "loglevel=3"];
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  # Bootloader.
  boot.loader.timeout = 0;
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

  services.fwupd.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  system.stateVersion = "23.11";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 8080 22];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.notuser.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVGapwmgI9ZL7tf6YrcZP2T+rnmrnCgelOybl7yk60QvVhfc1ikOjagkXpXj28wX0JXMKS+1qiIJEz5SkSbhMl67wz2DXzxGx5Xe1WOZltsY7RAg4gbDh71cUxaeYB0J9geXr1HITDbcvb8r5VO910pB5bUtYGUzcWG2wY+brU4pq6rGc9IGjNuQ7kl3q4Rk4ZjUjI5VarBQrLlXWbn5COlhasvdnAd05zVN2J+868Jkxzy9DKjy6svPQqnzL40nP1oZYKQNmTxtsl+V+ScBXnZFjjxA7eoTbQ8M3kZS8FKu3V+Cn6of7BCV+kE4lMsXyhZLDKlyqwYjAkBsXYvAqGeovOH9bI2FX/iQBDOBQUlnBFxGXEZOpSs9/6EDF0V6mEw9mwkGrrXE5HnBjghuZtaWSmHRZZ/wL5gyKSmDOk0+vrUTWeldQ1Wj+l4qVPpRB5vBA6Riga7pEcqE8h7IgtqMiQXA+pSy2pVA1cRaRmJ57FMMuaLfLKDhgPLoRougVZF12aPdN13tuwy8H8Py0ARKPFY1P2GfmPzB0t1fEScfT1dgenSDCb0XJU//zvbOmf/AF0ZSAD2Y7LHcaXTDtOTblYPsm5FNmPvt4XW9mh8pweqIKh6xrkZa84yN8Jj7pIueXUMaXQjN/DzAm7M6uTTCzkRZmC7L3lSyN23oIjnw=="
  ];
}
