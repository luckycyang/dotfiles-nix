{ config
, lib
, ...
}:
with lib; let
  cfg = config.cyang.programs.starship;
in
{
  options.cyang.programs.starship = { enable = mkEnableOption "Starship for bash"; };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
