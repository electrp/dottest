{ inputs, lib, config, ... }:
{
  flake.nixosConfigurations = inputs.self.lib.clib.mkNixos "x86_64-linux" "stupid";

  flake.modules.nixos.stupid = { pkgs, config, ...}: {
    imports = [ 
      inputs.self.modules.nixos.home-manager
      inputs.self.modules.nixos.will
      inputs.self.modules.nixos.tailscale
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/4fb01360-40e1-4b28-be6c-de2d323b0fea";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/5CD4-89AC";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    # fileSystems."/home/will/mnt/big" =
    #   { device = "/dev/disk/by-uuid/B6B89216B891D569";
    #     fsType = "ntfs";
    #     options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" "nofail" ];
    #   };

    # fileSystems."/mnt/alt" =
    #   { device = "/dev/disk/by-uuid/760c2efe-1aa6-4968-9796-ee7655dd39c9";
    #     fsType = "ext4";
    #     options = [ "users" "nofail" ];
    #   };

    swapDevices = [ {
      device = "/var/lib/swapfile";
      size = 16*1024; # 16 GB
    }];

    networking.hostName = "stupid"; 
    networking.networkmanager.enable = true;

    programs.gamemode.enable = true;

    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ]; 
    
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      amdgpu = {
        opencl.enable = true;
        initrd.enable = true;
      };
      nvidia = {
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
    hardware.enableRedistributableFirmware = true;
    hardware.nvidia.modesetting.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    services.ipp-usb.enable = true;


    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}