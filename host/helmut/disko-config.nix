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
        main = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "2G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                    "noatime"
                    "umask=0077"
                  ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  mountpoint = "/";
                  mountOptions = [ "noatime" ];
                };
              };
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
