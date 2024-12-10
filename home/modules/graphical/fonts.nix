{ config, pkgs, lib, ... }:
let
  cfg = config.cyang.graphical.fonts;
in
{
  options.cyang.graphical.fonts = {
    enable = lib.mkEnableOption "Some common fonts";
  };
  config = lib.mkIf cfg.enable
    {
      home.packages = with pkgs; [
        wqy_zenhei
        jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        iosevka
        # nerd c
        powerline-fonts
        material-design-icons
        martian-mono
        font-awesome
        weather-icons
        source-code-pro
        fira-code-nerdfont
        source-han-sans
        source-han-serif
      ];
    };
}
