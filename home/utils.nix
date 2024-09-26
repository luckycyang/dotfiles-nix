{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Pulseaudio command line mixer
    pamixer
    # Grab images from a Wayland compositor
    grim
    # Select a region in a Wayland compositor
    slurp
    # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    swappy



    # An xrandr clone for wlroots compositors
    wlr-randr

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    networkmanagerapplet
    pavucontrol
    wl-clipboard # Command-line copy/paste utilities for Wayland
    direnv # unclutter your .profile
    scrcpy # Screen share for android
  ];
}
