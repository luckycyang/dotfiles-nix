{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.cyang.graphical.river;
in
{
  options.cyang.graphical.river = {
    enable = mkEnableOption "A dynamic tiling Wayland compositor";
  };
  config = mkIf cfg.enable {
    wayland.windowManager.river = {
      enable = true;
      systemd.variables = [
        "-all"
      ];
      settings = {
        border-width = 2;
        declare-mode = [
          "locked"
          "normal"
          "passthrough"
        ];
        input = {
          pointer-foo-bar = {
            accel-profile = "flat";
            events = true;
            pointer-accel = -0.3;
            tap = false;
          };
        };
        map = {
          normal = {
            "Alt Q" = "close";
          };
        };
        rule-add = {
          "-app-id" = {
            "'bar'" = "csd";
            "'float*'" = {
              "-title" = {
                "'foo'" = "float";
              };
            };
          };
        };
        set-cursor-warp = "on-output-change";
        set-repeat = "50 300";
        spawn = [
          "firefox"
          "'alacritty'"
        ];
      };
    };
  };
}
