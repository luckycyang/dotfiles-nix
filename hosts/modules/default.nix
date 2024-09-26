{ condig, ... }:
{
  imports = [
    ./portal.nix
    ./programs
    ./services
    ./virtualisation
  ];
  config.cyang = {
    portal.enable = true;
    programs = {
      wayfire.enable = true;
      thunar.enable = true;
      virt-manager.enable = true;
      steam.enable = true;
    };
    services = {
      udev.enable = true;
    };
    virtualisation.podman.enable = true;
  };
  config = {
    programs.light.enable = true;
    programs.nm-applet.enable = true;
  };
}
