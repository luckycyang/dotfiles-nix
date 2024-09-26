{ config, pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./modules
    ./utils.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dingduck";
  home.homeDirectory = "/home/dingduck";
  programs.git = {
    enable = true;
    userName = "luckycyang";
    userEmail = "kfove.liang@protonmail.com";
  };

  home.packages = (with pkgs; [
    dconf


    termius
    qq


    # Video Player
    vlc
    google-chrome

    # LibreOffice
    libreoffice-qt

    # Obsidian
    obsidian

    # Matrix 
    fluffychat

    # Kicad
    kicad

    # CubeMX
    stm32cubemx






  ]) ++ (with pkgs-unstable;
    [
      yesplaymusic
      android-studio
    ]);
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
