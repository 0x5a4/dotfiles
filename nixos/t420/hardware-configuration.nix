{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8f0cc86c-6eb9-418f-b7e2-bb517c3669cd";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-f36541d3-8192-45ef-870d-c9fa2dedaa07".device = "/dev/disk/by-uuid/f36541d3-8192-45ef-870d-c9fa2dedaa07";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CD52-1799";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults"]
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/159b75fe-5da0-40a7-b7d2-9b81b8b583f2";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
