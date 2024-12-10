{ lib
, config
, ...
}:
with lib; let
  cfg = config.cyang.programs.alacritty;
in
{
  options.cyang.programs.alacritty = {
    enable = mkEnableOption "Alacritty";
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "none";
          startup_mode = "maximized";
          dynamic_title = true;
          opacity = 0.9;
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
        };
        general.live_config_reload = true;
        font = {
          normal.family = "JetBrains Mono";
          bold.family = "JetBrains Mono";
          italic.family = "JetBrains Mono";
          bold_italic.family = "JetBrains Mono";
          size = 11;
        };
      };

    };
  };
}
