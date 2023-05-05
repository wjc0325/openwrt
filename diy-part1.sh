#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
# repatch kenso8's naiveproxy patchfiles
sed -i 's/if (is_linux) {/if (is_linux || is_chromeos) {/' package/feeds/kenzo/naiveproxy/patches/100-build-add-OpenWrt-staging-libraries.patch
sed -i 's/@@ -746,7 +746,6/@@ -751,7 +751,6/' package/feeds/kenzo/naiveproxy/patches/101-build-drop-useless-deps-simd_asm.patch
