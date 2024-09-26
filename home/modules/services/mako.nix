{ config, lib, ... }:
let cfg = config.cyang.services.mako;
in
{
  options.cyang.services.mako = { enable = lib.mkEnableOption "mako, notices"; };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      sort = "-time";
      layer = "overlay";
      backgroundColor = "#2e3440";
      width = 300;
      height = 110;
      borderSize = 2;
      borderColor = "#5e81ac";
      borderRadius = 0;
      icons = true;
      maxIconSize = 64;
      defaultTimeout = 5000;
      ignoreTimeout = true;
      padding = "14";
      font = "Noto Sans 11";
      margin = "20";
      extraConfig = ''
        [urgency=low]
        border-color=#4c566a

        [urgency=normal]
        border-color=#4c566a

        [urgency=high]
        border-color=#8fbcbb
      '';
    };
  };
} 
