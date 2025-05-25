{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}: let
  cfg = config.passthrough;
  gpuIDs = [
    # lspci -nn | grep -iE '(nvidia|amd)'
    "10de:10f1" # Audio
    "10de:1c03" # Graphics
  ];
  intelBus = "PCI:0:2:0";
  nvidiaBus = "PCI:1:0:0";
in {
  options.passthrough = {
    enable = lib.mkEnableOption ''
      Enable GPU passthrough system settings.
    '';
  };

  config = lib.mkIf cfg.enable {
    specialisation = {
      gpuPassthrough.configuration = {
        system.nixos.tags = ["gpu_Passthrough"];
        boot = {
          blacklistedKernelModules = [
            "nouveau"
            "nvidia"
            "nvidia_modeset"
            "nvidia_uvm"
            "nvidia_drm"
          ];
          kernelModules = [
            "vfio"
            "vfio_iommu_type1"
            "vfio_pci"
            "vfio_virqfd"
          ];
          kernelParams = [
            "intel_iommu=on"
            "iommu=pt"
            ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
            "initcall_blacklist=sysfb_init"
          ];
        };

        users.users.kd = {
          extraGroups = [
            "kvm"
            "qemu-libvirtd"
            "libvirtd"
            "docker"
          ];
        };

        virtualisation = {
          spiceUSBRedirection.enable = true;
          docker = {
            enable = true;
            rootless = {
              enable = true;
            };
          };
          libvirtd = {
            enable = true;
            onBoot = "ignore";
            onShutdown = "shutdown";
            qemu = {
              ovmf.enable = true;
              runAsRoot = false;
            };
          };
        };

        environment = {
          systemPackages = with pkgs; [
            dmidecode
            lswh
            usbutils
            pciutils
            virt-manager
            looking-glass-client
            scream
          ];
        };

        hardware = {
          nvidia-container-toolkit.enable = true;
          graphics = {
            extraPackages = with pkgs; [
              #vpl-gpu-rt # For newer iGPU
              intel-media-sdk # For 10 gen and lower
              vaapiIntel
              intel-media-driver
              intel-compute-runtime
            ];
          };
          nvidia = {
            prime = {
              sync.enable = true;
              intelBusId = intelBus;
              nvidiaBusId = nvidiaBus;
            };
          };
        };
        services.xserver = {
          enable = true;
          videoDrivers = [
            "intel"
          ];
        };

        systemd = {
          tmpfiles.rules = [
            "f /dev/shm/scream 0660 kd qemu-libvirtd -"
            "f /dev/shm/looking-glass 0660 kd qemu-libvirtd -"
          ];

          user.services = {
            scream-ivshmem = {
              enable = true;
              description = "Scream IVSHMEM";
              serviceConfig = {
                ExecStart = "${pkgs.scream}/bin/scream /dev/shm/scream";
                Restart = "always";
              };
              wantedBy = ["multi-user.target"];
              requires = ["pipewire-pulse.service"];
            };
          };
        };
      };
    };
  };
}
