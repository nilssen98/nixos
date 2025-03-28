{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    amd-graphics.enable = lib.mkEnableOption "Enable amd-graphics";
  };

  config = lib.mkIf config.amd-graphics.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];

    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.graphics.enable32Bit = true; # For 32 bit applications

    hardware.graphics.extraPackages = with pkgs; [
      amdvlk
    ];

    # For 32 bit applications
    hardware.graphics.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
}
