{ config
, pkgs
, lib
, ...
}:
{
  config = {
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    services.blueman.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
    hardware = {
      bluetooth.enable = true; # enables support for Bluetooth
      bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
      graphics = {
        enable = true;
        # driSupport = true;
        enable32Bit = true;
        extraPackages = with pkgs;[
          rocmPackages.clr.icd
          rocmPackages.clr
          rocmPackages.rocminfo
          rocmPackages.rocm-runtime
        ];
      };
    };
    # This is necesery because many programs hard-code the path to hip
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    # 这里和 opengl 会冲突, opengl 就不要添加 32bit 和 extraPackages 了
    hardware.amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        supportExperimental.enable = true;
      };
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "560.35.03";
        sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
        sha256_aarch64 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
        openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:6:0:0";
      };
    };
  };
}
