{ config, swww, lib, pkgs, ... }:
let
  cfg = config.cyang.programs.swww;
in
{
  options.cyang.programs.swww = {
    enable = lib.mkEnableOption "A Solution to your Wayland Wallpaper Woes";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      swww.packages."${pkgs.system}".swww
    ];
  };
}
