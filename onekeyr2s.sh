#!/bin/bash
cp -r ./scripts/. ./
bash 01_get_ready.sh
cd openwrt
cp -r ../scripts/. ./
bash 02_prepare_package.sh
bash 03_convert_translation.sh
bash 04_remove_upx.sh
cp ../seed/config_no_docker.seed .config
make defconfig
make download -j10
chmod -R 755 ./
let make_process=$(nproc)+1
make toolchain/install -j${make_process} V=s
let make_process=$(nproc)+1
make -j${make_process} V=s || make -j${make_process} V=s
cd bin/targets/rockchip/armv8
/bin/bash ../../../../../scripts/05_cleaning.sh
