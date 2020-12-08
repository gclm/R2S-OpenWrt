#!/bin/bash

# 修改默认IP和增加DNS和路由
#cat ./patch/config_generate
mv -f ./patch/config_generate ./openwrt-lienol/package/base-files/files/bin/config_generate
cd ./openwrt-lienol/package/base-files/files/bin
#cat config_generate

exit 0
