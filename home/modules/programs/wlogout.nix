{ config, lib, pkgs, ... }:
let
  cfg = config.cyang.programs.wlogout;
in
{
  options.cyang.programs.wlogout = {
    enable = lib.mkEnableOption "A wayland based logout menu";
  };
  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
      package = pkgs.wlogout;
    };
  };
}
