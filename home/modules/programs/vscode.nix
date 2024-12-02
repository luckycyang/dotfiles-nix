{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.cyang.programs.vscode;
in
{
  options.cyang.programs.vscode = { enable = mkEnableOption "Visual Studio Code"; };
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions;
        [
          ms-ceintl.vscode-language-pack-zh-hans
          ms-python.python
          llvm-vs-code-extensions.vscode-clangd
          ms-vscode.cmake-tools
          vadimcn.vscode-lldb
          # NIX

          mkhl.direnv
          jnoortheen.nix-ide
          # rust
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          usernamehw.errorlens
          serayuzgur.crates
          myriad-dreamin.tinymist # typst

          # flutter && dart
          dart-code.flutter
          dart-code.dart-code
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "c-cpp-compile-run";
            publisher = "danielpinto8zz6";
            version = "1.0.58";
            sha256 = "sha256-lJ40S8p+rCxUCWVWXz4IyYzW0/bFL9vN7MicuGn/IHw=";
          }
          {
            name = "asm-code-lens";
            publisher = "maziac";
            version = "2.6.0";
            sha256 = "sha256-4p3kizvEqqsMNJOhyKxJQ0rH3ePjstKLWb22BYy3yZk=";
          }
          {
            name = "cortex-debug";
            publisher = "marus25";
            version = "1.12.1";
            sha256 = "sha256-ioK6gwtkaAcfxn11lqpwhrpILSfft/byeEqoEtJIfM0=";
          }
          {
            name = "debug-tracker-vscode";
            publisher = "mcu-debug";
            version = "0.0.15";
            sha256 = "sha256-2u4Moixrf94vDLBQzz57dToLbqzz7OenQL6G9BMCn3I=";
          }
          {
            name = "memory-view";
            publisher = "mcu-debug";
            version = "0.0.25";
            sha256 = "sha256-Tck3MYKHJloiXChY/GbFvpBgLBzu6yFfcBd6VTpdDkc=";
          }
          {
            name = "rtos-views";
            publisher = "mcu-debug";
            version = "0.0.7";
            sha256 = "sha256-VvMAYU7KiFxwLopUrOjvhBmA3ZKz4Zu8mywXZXCEHdo=";
          }
          {
            name = "peripheral-viewer";
            publisher = "mcu-debug";
            version = "1.4.6";
            sha256 = "sha256-flWBK+ugrbgy5pEDmGQeUzk1s2sCMQJRgrS3Ku1Oiag=";
          }
          {
            name = "probe-rs-debugger";
            publisher = "probe-rs";
            version = "0.23.0";
            sha256 = "sha256-PhEJ8TuzK4PYTnFVgv9rBec1EDViEVGS1ArUweNqS7Q=";
          }
          {
            name = "wavetrace";
            publisher = "wavetrace";
            version = "1.1.2";
            sha256 = "sha256-74MD7I2C5CI/cr+Cfuqu2Jl3UhaL3DdNiSeWfu8+ZYY=";
          }
        ];
    };
  };
}
