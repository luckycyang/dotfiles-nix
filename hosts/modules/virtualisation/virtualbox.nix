{ pkgs
, lib
, config
, ...
}:
let
  cfg = config.cyang.programs.virtualbox;
in
{
  options.cyang.programs.virtualbox = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "virtualbox";
    };
  };
  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
    virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}
