#!/bin/bash
# aTimes mac 一键安装脚本
#   curl -fsSL <脚本地址> | bash
# 自动完成：识别芯片 → 镜像下载 → 解除隔离 → 安装到 /Applications → 打开
set -euo pipefail

REPO="Fishason/aTimes"
VER="${ATIMES_VERSION:-latest}"

case "$(uname -m)" in
  arm64) ASSET_ARCH="Apple_Silicon" ;;
  x86_64) ASSET_ARCH="Intel_Mac" ;;
  *) echo "不支持的架构: $(uname -m)"; exit 1 ;;
esac

# 取最新版本号
if [ "$VER" = "latest" ]; then
  VER=$(curl -fsSL "https://ghfast.top/https://api.github.com/repos/${REPO}/releases/latest" 2>/dev/null \
        | grep -oE '"tag_name": *"[^"]+"' | head -1 | sed 's/.*"v\{0,1\}\([^"]*\)"/\1/') || true
  [ -n "$VER" ] || VER=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
        | grep -oE '"tag_name": *"[^"]+"' | head -1 | sed 's/.*"v\{0,1\}\([^"]*\)"/\1/')
fi
ASSET="aTimes_${VER}_${ASSET_ARCH}.zip"
URLPATH="${REPO}/releases/download/v${VER}/${ASSET}"
echo "==> aTimes v${VER} (${ASSET_ARCH})"

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
ok=""
for prefix in "https://ghfast.top/https://github.com/" "https://gh-proxy.com/https://github.com/" "https://github.com/"; do
  echo "==> 下载 ${prefix%%/https*}..."
  if curl -fL --connect-timeout 8 -o "$TMP/a.zip" "${prefix}${URLPATH}"; then ok=1; break; fi
done
[ -n "$ok" ] || { echo "下载失败：所有镜像均不可达"; exit 1; }

echo "==> 安装到 /Applications"
ditto -xk "$TMP/a.zip" "$TMP/x"            # ditto 保留符号链接与权限
xattr -cr "$TMP/x/aTimes.app" 2>/dev/null || true   # 解除下载隔离标记
rm -rf /Applications/aTimes.app
mv "$TMP/x/aTimes.app" /Applications/

echo "==> 完成，正在打开 aTimes"
open /Applications/aTimes.app
