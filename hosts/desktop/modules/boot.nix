{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    initrd = {
      kernelModules = [ "amdgpu" ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
