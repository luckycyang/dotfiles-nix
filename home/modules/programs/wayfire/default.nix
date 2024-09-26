{ config, lib, ... }:
let
  cfg = config.cyang.programs.wayfire;
in
{
  # wayfire 的启用在 hosts 上, 这里管理配置而已
  options.cyang.programs.wayfire = {
    enable = lib.mkEnableOption "A modular and extensible wayland compositor";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."wayfire.ini".source = ./wayfire.ini;
    xdg.configFile."wf-shell.ini".source = ./wf-shell.ini;
  };
}
