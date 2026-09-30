{
  inputs, 
  config,
  lib,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.clib.mkNixos "x86_64-linux" "broken";

  flake.modules.nixos.broken = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      home-manager
      will
    ];

    swapDevices = [{
      device = "/var/lib/swapfile";
      size = 16*1024; # 16 GB
    }];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    hardware.bluetooth.enable = true; # Enables the Bluetooth hardware service

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
      ];
    };

    networking.networkmanager.enable = true;

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/34373d79-4b92-4310-a444-86faa1492463";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/C693-5CAE";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}