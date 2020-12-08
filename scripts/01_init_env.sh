#!/bin/bash
# 删除 docker 镜像
docker rmi `docker images -q`

# 配置git
git config --global user.email "action@github.com" && git config --global user.name "GitHub Action"

# 更新并下载依赖
sudo apt-get update -y
sudo apt-get -y --no-install-recommends install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler
sudo apt install -y hwinfo
sudo hwinfo --short

sudo rm -rf /etc/apt/sources.list.d
curl https://raw.githubusercontent.com/friendlyarm/build-env-on-ubuntu-bionic/master/install.sh  | sed '/#/d' | sed 's/\\//g' | sed 's/exit 0//g' | sed 's/sudo apt -y install//g' | sed 's/sudo apt-get -y install//g' | sed 's/:i386//g' | xargs sudo apt-get -y --no-install-recommends install
sudo rm -rf /usr/share/dotnet /usr/local/lib/android/sdk /usr/local/share/boost /opt/ghc

# 更新基础依赖
git clone https://github.com/friendlyarm/repo
sudo cp repo/repo /usr/bin/