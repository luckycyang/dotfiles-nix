{ config, lib, pkgs, pkgs-unstable, ... }:
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
        package = pkgs.wayfire;
        plugins = with pkgs.wayfirePlugins; [ wcm wf-shell wayfire-plugins-extra ];
      };
    };
  };
}
