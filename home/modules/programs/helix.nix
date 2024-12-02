{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.cyang.programs.helix;
in
{
  options.cyang.programs.helix = {
    enable = mkEnableOption "helix";
  };
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        metals
        nil
        nodePackages_latest.typescript-language-server
        markdown-oxide
        rust-analyzer
        slint-lsp
        rocmPackages.llvm.clang-tools-extra # cland 在工具包里面
        dockerfile-language-server-nodejs
        docker-compose-language-service
        yaml-language-server
        cmake-language-server
        # zig 语言的 LSP 和 Format 会在 devenv 提供， 或者自行提供, 因为 zig 还没有 release, 版本差异较大
        rocmPackages.llvm.lldb # lldb 把 c/c++ rust zig 一把嗦
        typst-lsp
        python312Packages.python-lsp-server


      ];
      settings = {
        theme = "catppuccin_macchiato";
        editor = {
          line-number = "absolute";
          lsp.display-messages = true;
          lsp.display-inlay-hints = true;
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "block";
          };
        };
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          esc = [ "collapse_selection" "keep_primary_selection" ];
        };
      };
    };
  };
}
