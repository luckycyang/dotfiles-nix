{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.cyang.programs.waybar;
in
{
  options.cyang.programs.waybar = { enable = mkEnableOption "Waybar"; };
  config = mkIf cfg.enable {
    xdg.configFile."waybar/style.css".source = ./style.css;
    xdg.configFile."waybar/config".source = ./config;
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };
  };
}
