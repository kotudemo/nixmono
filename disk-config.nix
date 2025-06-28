{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1024M";
              content = {
               type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
