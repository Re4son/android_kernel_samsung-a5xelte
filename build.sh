#!/bin/bash
DTS=arch/arm64/boot/dts
RDIR=$(pwd)
# GCC
export CROSS_COMPILE=/home/prashantp/linaro-7.3.1/bin/aarch64-opt-linux-android-
# Cleanup
make clean && make mrproper
# A510F NN Defcon
make samfr_a5xelte_00_defconfig
make exynos7580-a5xelte_eur_open_00.dtb exynos7580-a5xelte_eur_open_01.dtb exynos7580-a5xelte_eur_open_02.dtb exynos7580-a5xelte_eur_open_03.dtb exynos7580-a5xelte_eur_open_08.dtb exynos7580-a5xelte_eur_open_09.dtb
# Make zImage
make ARCH=arm64 -j5
# Make DT.img
./tools/dtbtool -o ./boot.img-dtb -v -s 2048 -p ./scripts/dtc/ $DTS/
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb
