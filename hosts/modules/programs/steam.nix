{ config, lib, ... }:
let
  cfg = config.cyang.programs.steam;
in
{
  options.cyang.programs.steam = {
    enable = lib.mkEnableOption "My Steam Config";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = true;
      };
    };
    hardware.steam-hardware.enable = true;
    hardware.opengl.driSupport32Bit = lib.mkForce true; # because steam true and nixos-hardware is flase but steam launch in opengl 32bit dri
  };
}
