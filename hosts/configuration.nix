# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, nixvim, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules
      ./driver.nix
      ./services
      ./utils

      ./dev.nix # DevMySelf
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # nixpkgs feature
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      nvidia.acceptLicense = true;
      permittedInsecurePackages = [
        "fluffychat-linux-1.20.0"
        "olm-3.2.16"
      ];
    };
  };


  # Debug
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # Debug End

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.efiSysMountPoint = "/boot";
    grub = rec {
      enable = true;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
      theme = inputs.distro-grub-themes.packages.${pkgs.system}.nixos-grub-theme;
      splashImage = "${theme}/splash_image.jpg";
    };
  };



  networking.hostName = "luckynix"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
  ];
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;
  #

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false; # 使用pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };



  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  services.getty.autologinUser = "dingduck";
  programs.adb.enable = true;
  users.users.dingduck = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "adbusers" "plugdev" "video" "kvm" ];
    packages = with pkgs; [ firefox alacritty ];
    openssh.authorizedKeys.keys = [
    ];
  };
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixvim.packages."${pkgs.system}".default
    wget
    nh
    git
    btop
    curl
    android-udev-rules
    android-tools
    mangohud
    tlrc
    rsync
    aria2
    ffmpeg-full

    # DNS Query
    dig

    # 打包与亚索
    unzipNLS
    p7zip
    unrar-wrapper
    # Professional video editing, color, effects and audio post-processing
    davinci-resolve

  ];

  environment.sessionVariables = rec {
    devGit = "github:luckycyang/dev-nix-flake";
    # lang
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  };
  environment.interactiveShellInit = ''
    alias aup='aria2c --conf-path=/home/dingduck/Downloads/aria2/.aria2.conf'
  '';
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # 设置
    settings = {
      # PermitRootLogin = "yes"; # 方便安装, 安装完成后注意关闭
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8000 ];
    allowedUDPPortRanges = [
      { from = 8000; to = 8080; }
      { from = 6881; to = 6999; }
    ];
    trustedInterfaces = [
      "virbr0" # kvm default network bridge
    ]; # add to lists, or can ping but not network
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
  networking.extraHosts = ''

  '';

}
