# aTimes

把 Mac/Windows 上的文件夹**远程挂载**到你的 Ubuntu 服务器任意路径——
像本地磁盘一样使用，无副本、无同步等待。

- 粘贴 SSH 命令一键绑定，流量走 SSH 隧道（22 端口），无需配置防火墙
- 服务器上的用户和程序像使用普通文件一样使用挂载目录
- 网络波动自动等待恢复；离线超时挂载点干净消失，重连原地复活

## 安装

**Mac 一键安装（推荐，自动处理 macOS"已损坏"安全提示）：**

```bash
curl -fsSL https://ghfast.top/https://raw.githubusercontent.com/Fishason/aTimes/main/install-mac.sh | bash
```

**手动安装**：从 [Releases](https://github.com/Fishason/aTimes/releases/latest) 下载对应平台 zip，
mac 解压后先执行 `xattr -cr aTimes.app` 再打开。

## 下载（v0.7.7）

| 平台 | 文件 |
|---|---|
| Mac (Apple Silicon, M 系列芯片) | aTimes_0.7.7_Apple_Silicon.zip |
| Mac (Intel) | aTimes_0.7.7_Intel_Mac.zip |
| Windows (x64) | aTimes_0.7.7_windows_x64.zip |

解压后打开 aTimes 应用，粘贴你的 ssh 命令即可开始。
