{ pkgs
, lib
, config
, ...
}:
let
  cfg = config.cyang.programs.virt-manager;
in
{
  options.cyang.programs.virt-manager = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Virt-Mnager for kvm";
    };
  };
  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.dingduck.extraGroups = [ "libvirtd" ];
  };
}
