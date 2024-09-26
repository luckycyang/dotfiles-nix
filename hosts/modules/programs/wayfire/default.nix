{ config, lib, pkgs, ... }:
let
  cfg = config.cyang.programs.wayfire;
in
with lib;
{
  options.cyang.programs.wayfire = {
    enable = mkEnableOption "Wayfire";
  };
  config = mkIf cfg.enable {
    programs = {
      wayfire = {
        enable = true;
        plugins = with pkgs.wayfirePlugins; [ wcm wf-shell wayfire-plugins-extra ];
      };
    };
  };
}
