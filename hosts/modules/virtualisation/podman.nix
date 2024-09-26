{ config, lib, pkgs, ... }:
let
  cfg = config.cyang.virtualisation.podman;
in
{
  options.cyang.virtualisation.podman = {
    enable = lib.mkEnableOption "Thunar is a GTK file manager originally made for Xfce.";
  };
  config = lib.mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;


        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      docker-compose # start group of containers for dev
      #podman-compose # start group of containers for dev
    ];
  };
}
