#!/bin/bash
echo "Start Prepare Package"

cd friendlywrt
git remote add upstream https://github.com/coolsnowwolf/openwrt && git fetch upstream
git checkout upstream/lede-17.01 -b tmp
git rm README.md
git commit -m 'reset'
git checkout master-v19.07.1
git rebase adc1a9a3676b8d7be1b48b5aed185a94d8e42728^ --onto tmp -X theirs
rm -f target/linux/rockchip-rk3328/patches-4.14/0001-net-thunderx-workaround-BGX-TX-Underflow-issue.patch target/linux/generic/hack-4.14/999-net-patch-linux-kernel-to-support-shortcut-fe.patch
git checkout upstream/lede-17.01 -- feeds.conf.default && sed -i -E 's/#(src-git.+)(helloworld.+)/\1\2/' feeds.conf.default
curl 'https://git.openwrt.org/?p=openwrt/openwrt.git;a=patch;h=22378beb581b113def1dc392ef75306a2168a163' | git apply --reject - || true

./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf feeds/packages/libs/libcap/ && svn co https://github.com/openwrt/packages/trunk/libs/libcap feeds/packages/libs/libcap
rm -rf feeds/packages/lang/golang/ && svn co https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang
sed -i '/enable-jsonc/i\\t--disable-cloud \\' feeds/packages/admin/netdata/Makefile

# 加载插件
cd package/lean/
if [[ `pwd` == *"rk3328"* ]]; then
  rm -rf luci-app-oled/ && git clone https://github.com/NateLol/luci-app-oled
fi
[ ! -d luci-app-adguardhome ] && git clone https://github.com/rufengsuixing/luci-app-adguardhome
[ ! -d luci-app-mentohust ] && git clone https://github.com/BoringCat/luci-app-mentohust
[ ! -d mentohust ] && svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/mentohust
rm -rf luci-theme-argon*/ ../lean/luci-theme-argon/ && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf luci-theme-edge/ && git clone -b 18.06 https://github.com/garypang13/luci-theme-edge
rm -rf luci-theme-infinityfreedom/ && git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
rm -rf luci-app-chinadns-ng/ && git clone https://github.com/WuSiYu/luci-app-chinadns-ng
rm -rf openwrt-chinadns-ng/ && git clone https://github.com/pexcn/openwrt-chinadns-ng
rm -rf v2ray/ && svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray
rm -rf v2ray-plugin/ && svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray-plugin
rm -rf trojan/ && svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/trojan

echo "---------------------------------开始添加插件-----------------------"
cd ../../
pwd
ls
