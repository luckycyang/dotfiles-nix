{ config, lib, ... }:
let
  cfg = config.cyang.services.wlsunset;
in
{
  options.cyang.services.wlsunset = {
    enable = lib.mkEnableOption "Day/night gamma adjustments for Wayland";
  };
  config = lib.mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      sunrise = "06:30";
      sunset = "18:00";
    };
  };
}
