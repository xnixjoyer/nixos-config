{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/graphics-amd.nix
  ];

  networking.hostName = "nyx";

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-zen4;
    #boot.kernelPackages = pkgs.linuxPackages_latest;
services.udev.extraRules = ''
  ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="mq-deadline"
'';



boot.initrd.luks.devices."luks-9744935a-a72b-4e20-aa85-0652f855d7f8" = {
  bypassWorkqueues = true;
  allowDiscards = true;
};
  hardware.cpu.amd.updateMicrocode = true;
}
