{ config, pkgs, ... }:
{
  config = {
    programs.adb.enable = true;
    services.udev.packages = [
      pkgs.android-udev-rules
    ];
  };
}