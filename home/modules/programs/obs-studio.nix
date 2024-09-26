{ pkgs
, lib
, config
, ...
}:
with lib; let
  cfg = config.cyang.programs.obs-studio;
in
{
  options.cyang.programs.obs-studio = {
    enable = mkEnableOption "obs-studio";
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
