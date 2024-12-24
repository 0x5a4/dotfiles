{ xfaf-lib, ... }:
{
  disko.devices = {
    disk =
      let
        zfsConfig = device: {
          inherit device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      in
      {
        main = xfaf-lib.disko.mkGPT "/dev/nvme0n1" {
          boot = xfaf-lib.disko.mkBootPartition "2 ";
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              mountpoint = "/";
              mountOptions = [ "noatime" ];
            };
          };
        };
        sda = zfsConfig "/dev/sda";
        sdb = zfsConfig "/dev/sdb";
        sdc = zfsConfig "/dev/sdc";
        sdd = zfsConfig "/dev/sdd";
      };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "raidz1";
        mountpoint = "/mnt/zroot";
      };
    };
  };
}
