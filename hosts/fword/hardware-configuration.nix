{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  disko.devices.disk.main = lib.xfaf.disko.mkGPT "/dev/nvme0n1" {
    boot = lib.xfaf.disko.mkBootPartition "2G";
    root = lib.xfaf.disko.mkLuks "crypt" {
      type = "btrfs";
      extraArgs = [ "-f" ];
      subvolumes =
        let
          mountOptions = [ "noatime" ];
        in
        {
          "/root" = {
            mountpoint = "/";
            inherit mountOptions;
          };
          "/nix" = {
            mountpoint = "/nix";
            inherit mountOptions;
          };
          "/swap" = {
            mountpoint = "/.swap";
            swap.swapfile.size = "16G";
          };
        };
    };
  };

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];

  hardware.bluetooth.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp170s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
