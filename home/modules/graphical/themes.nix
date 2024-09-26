{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.cyang.graphical.themes.nordic;
in
{
  options.cyang.graphical.themes.nordic = {
    enable = mkEnableOption "Nordic theme";
  };
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      cursorTheme = {
        package = pkgs.vimix-cursors;
        name = "Vimix-cursors";
      };

    };
    home = {
      pointerCursor = {
        gtk.enable = true;
        # x11.enable = true;
        package = pkgs.vimix-cursors;
        name = "Vimix-cursors";
      };
      packages = with pkgs; [
        qt5.qttools
        qt6Packages.qtstyleplugin-kvantum
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        breeze-icons
        dconf # issues 3113
      ];
    };
  };
}
