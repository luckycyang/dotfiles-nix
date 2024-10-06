{ ... }:
{
  imports = [
    ./programs
    ./graphical
    ./services
  ];
  config.cyang = {
    graphical = {
      hyprland.enable = true;
      river.enable = true;
    };
    programs = {
      wayfire.enable = true;
      helix.enable = true;
      starship.enable = true;
      vscode.enable = true;
      obs-studio.enable = true;
      swww.enable = true;
    };

  };
}
