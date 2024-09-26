{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.cyang.programs.wofi;
in
{
  options.cyang.programs.wofi = {
    enable = mkEnableOption "Wofi";
  };
  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      package = pkgs.wofi;
      settings = {
        location = "center";
        allow_images = true;
      };
    };
    xdg.configFile.".config/style.css".source = ./style.css;
  };
}
