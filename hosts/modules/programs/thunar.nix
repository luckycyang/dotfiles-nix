{ config, lib, pkgs, ... }:
let
  cfg = config.cyang.programs.thunar;
in
{
  options.cyang.programs.thunar = {
    enable = lib.mkEnableOption "Thunar is a GTK file manager originally made for Xfce.";
  };
  config = lib.mkIf cfg.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
