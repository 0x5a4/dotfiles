{ ... }:
{
  mkGPT = device: partitions: {
    type = "disk";
    content = {
      inherit partitions;
      type = "gpt";
    };
  };

  # assumes ssds
  mkLuks = name: content: {
    size = "100%";
    content = {
      inherit name content;
      type = "luks";
      settings = {
        allowDiscards = true;
        bypassWorkqueues = true;
      };
      askPassword = true;
    };
  };

  mkBootPartition = size: {
    inherit size;
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
}
