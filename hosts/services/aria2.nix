{ config, pkgs, ... }:

let
  # 在这里定义你要使用的下载路径和 secret
  aria2DownloadPath = "/home/dingduck/Downloads/aria2"; # 下载路径
  aria2Secret = "liang114514"; # secret
in
{
  # 启用 aria2 服务
  services.aria2 = {
    enable = true;
    # 配置下载路径
    configFile = ''
      dir=${aria2DownloadPath}
      rpc-listen-port=6800
      rpc-listen-all=true
      rpc-secret=${aria2Secret}
      rpc-allow-origin-all=true
      enable-rpc=true
      rpc-secure=false
      continue=true
      max-concurrent-downloads=5
      input-file=/var/lib/aria2/aria2.session
      save-session=/var/lib/aria2/aria2.session
      save-session-interval=60
    '';
  };

  # 开启防火墙的 6800 端口用于 Aria2 RPC 通信
  networking.firewall.allowedTCPPorts = [ 6800 ];

  # 启用定期保存下载会话
  systemd.services.aria2.serviceConfig = {
    ExecStopPost = "${pkgs.coreutils}/bin/sleep 5";
  };

  # 确保下载目录存在
  system.activationScripts.createDownloadDir = ''
    mkdir -p ${aria2DownloadPath}
    chown -R ${config.services.aria2.user} ${aria2DownloadPath}
  '';
}
