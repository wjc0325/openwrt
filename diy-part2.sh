#!/bin/bash
# =============================================================================
# diy-part2.sh - OpenWrt 自定义脚本 (第二阶段)
# 执行时机：在 ./scripts/feeds update -a && ./scripts/feeds install -a 之后
# 主要用途：添加第三方源、克隆插件、克隆主题
# =============================================================================

echo "开始执行 diy-part2.sh ..."

# 1. 添加第三方插件源 (例如 Lienol, PassWall 等)
# 假设你已经在 feeds.conf.default 里加了，或者在这里动态添加
# echo "src-git lienol https://github.com/Lienol/openwrt-package" >> feeds.conf.default
# ./scripts/feeds update lienol
# ./scripts/feeds install -a

# 2. 克隆 Argon 主题 (必须在 part2，因为依赖 feeds 更新后的环境)
rm -rf package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf package/luci-app-argon-config
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 3. 克隆 PassWall (支持 Hysteria2/VLESS)
# 如果源里没有，可以手动克隆
# rm -rf package/luci-app-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall

# 4. 其他插件 (Aria2, 去广告等通常直接在 menuconfig/.config 里选，不需要手动 git clone，除非源里没有)

echo "diy-part2.sh 执行完毕！"
