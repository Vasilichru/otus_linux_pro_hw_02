#!/bin/bash
uname -r  #посмотреть версию текущего ядра (опционально)
echo "START =========================+++++++++++++++++++++++++++++=======================================>"
export DEBIAN_FRONTEND=noninteractive
apt update 1>/dev/null
apt -y install make gcc build-essential flex bison libelf-dev libssl-dev debhelper-compat 1>/dev/null

mkdir /new_kernel && sudo chmod -R 777 /new_kernel && cd /new_kernel
echo "wget start"
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.8.9.tar.xz 2>/dev/null
echo "wget stop"

echo "starting untar"
tar xvf linux-6.8.9.tar.xz 2>/dev/null
echo "untar finished"

cd linux-6.8.9/

echo "cp cfg"
cp /boot/config-`uname -r` ./.config
echo "stop cp cfg"

echo "mk old conf"
yes "" | make oldconfig #1>/dev/null
#yes "" | make localmodconfig 1>/dev/null

echo "scripts"
sudo scripts/config --disable SYSTEM_TRUSTED_KEYS
sudo scripts/config --disable SYSTEM_REVOCATION_KEYS
echo "end scripts"


sudo make -j$((`nproc`)) bindeb-pkg #1>/dev/null
sudo dpkg -i ../*.deb

echo "FINISH =====================================================++++++++++++++++++++++++++++++++++++===========>"
uname -r
#reboot  #перезагрузка после обновления ядра (опционально)
