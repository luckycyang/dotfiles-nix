{ config, lib, ... }:
let
  cfg = config.cyang.programs.swaylock;
in
{
  options.cyang.programs.swaylock = {
    enable = lib.mkEnableOption "Screen locker for Wayland";
  };
  config = lib.mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
    };
  };
}
