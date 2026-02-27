#!/bin/bash
# =============================================================================
# diy-part1.sh - OpenWrt 自定义脚本 (第一阶段)
# 执行时机：在 ./scripts/feeds update -a 之前
# 主要用途：修改源码核心、替换默认配置、删除占用空间的默认插件、打补丁
# =============================================================================

echo "----------------------------------------------------------"
echo "开始执行 diy-part1.sh ..."
echo "当前目录：$(pwd)"
echo "----------------------------------------------------------"

# 1. 修改默认 IP 地址 (可选，默认为 192.168.1.1)
# 如果希望改为 192.168.50.1，取消下面一行的注释
 sed -i 's/192.168.1.1/192.168.199.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认主机名 (Hostname)
# 将默认 'OpenWrt' 改为 'HiWiFi-B70'
sed -i 's/OpenWrt/HiWiFi-B70/g' package/base-files/files/bin/config_generate

# 3. 修改默认时区 (Asia/Shanghai)
sed -i 's/UTC/CST-8\nset tz CST-8\nset tzinfo :\/etc\/localtime/g' package/base-files/files/etc/system.conf
# 或者更简单的替换方式，针对某些源码结构：
sed -i 's/timezone UTC/timezone CST-8/g' package/base-files/files/etc/config/system
sed -i 's/timezone\.name '\''UTC'\''/timezone\.name '\''Asia\/Shanghai'\''/g' package/base-files/files/etc/config/system

# 4. 【关键】删除默认主题以节省空间 (B70 闪存仅 128MB)
# 我们将使用 Argon 主题替代，所以必须删除默认的 bootstrap 主题
echo "正在删除默认主题 luci-theme-bootstrap..."
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-app-argon-config  # 如果有旧的 argon 配置也先删掉，防止冲突

# 5. 删除其他不必要的默认插件 (根据源码情况选择性删除)
# 例如：如果源码自带了老旧的 SSR Plus+，而我们要用 PassWall，可以这里删除
# rm -rf package/lean/luci-app-ssr-plus 

# 6. 替换内核版本 (可选，通常不需要，MT7621 用默认即可)
# 如果遇到特定驱动问题，可以在此处打内核补丁
# patch -p1 < /path/to/your/patch/file.patch

# 7. 修改固件版本号 (显示在后台)
# 在版本号后添加编译日期或作者信息
echo "修改固件版本标识..."
sed -i 's/DISTRIB_REVISION=.*/DISTRIB_REVISION='$(date +%Y%m%d)'/g' package/lean/default-settings/files/zzz-default-settings
# 注意：不同源码路径可能不同，如果是 immortalwrt 可能是 package/base-files/files/etc/openwrt_release
if [ -f package/base-files/files/etc/openwrt_release ]; then
    sed -i "s/DISTRIB_REVISION='.*/DISTRIB_REVISION='$(date +%Y%m%d)-B70'/g" package/base-files/files/etc/openwrt_release
fi

echo "----------------------------------------------------------"
echo "diy-part1.sh 执行完毕！"
echo "----------------------------------------------------------"
