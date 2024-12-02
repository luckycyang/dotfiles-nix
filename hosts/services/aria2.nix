{ config, pkgs, ... }:

let
  # 在这里定义你要使用的下载路径和 secret
  aria2DownloadPath = "/home/dingduck/Downloads/aria2"; # 下载路径
  aria2Secret = "/home/dingduck/Downloads/aria2/.secret"; # secret
in
{
  # 启用 aria2 服务
  services.aria2 = {
    enable = true;
    extraArguments = "--rpc-listen-all --remote-time=true";
    openPorts = true;
    downloadDir = aria2DownloadPath;
    rpcSecretFile = aria2Secret;
  };
  # 确保下载目录存在
  system.activationScripts.createDownloadDir = ''
    mkdir -p ${aria2DownloadPath}
    chown u+rw ${aria2DownloadPath}
  '';
}
