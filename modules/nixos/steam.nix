{ config, lib, ... }:
{
  options = {
    steam.enable = lib.mkEnableOption "Enable steam ";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;

      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;

      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;

      # Open ports in the firewall for Steam Local Network Game Transfers
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
