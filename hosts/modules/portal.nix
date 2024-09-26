{ config, lib, pkgs, ... }:
let cfg = config.cyang.portal;
in
{
  options.cyang.portal = { enable = lib.mkEnableOption "hyprland"; };
  config = lib.mkIf cfg.enable {
    services.dbus.enable = true;
    xdg.portal = {
      config.common.default = "*";
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

  };

}
