#!/bin/sh
export KERNELDIR=`readlink -f .`
ANYKERNEL_DIR=/home/tamas/Desktop/Anykernel2-EAS-rebase
ZIP_NAME="KangarooX-EAS-r3.4-test2"
export CROSS_COMPILE="/home/tamas/Desktop/tc/gcc-arm-8.2-2018.08-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-"
export CROSS_COMPILE_ARM32=/home/tamas/Desktop/tc/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export ARCH=arm64
export SUBARCH=arm64
# export KBUILD_BUILD_VERSION="4"
mkdir -p out
echo ""
echo " Cross-compiling KangarooX kernel for whyred..."
echo ""

cd $KERNELDIR/

if [ ! -f $KERNELDIR/out/.config ];
then
   make O=out ARCH=arm64 kangaroox-eas_defconfig
fi

make -j4 O=out ARCH=arm64

rm -f ${ANYKERNEL_DIR}/Image.gz*
rm -f ${ANYKERNEL_DIR}/zImage*
rm -f ${ANYKERNEL_DIR}/dtb*
mv $KERNELDIR/out/arch/arm64/boot/Image.*-dtb ${ANYKERNEL_DIR}/zImage-dtb
rm -rf ${ANYKERNEL_DIR}/modules/system/vendor/lib/modules
mkdir -p ${ANYKERNEL_DIR}/modules/system/vendor/lib/modules
cd ${ANYKERNEL_DIR}
rm *.zip
zip -r9 ${ZIP_NAME}.zip * -x README ${ZIP_NAME}.zip
echo ""
echo "KangarooX has been built for whyred !!!"
echo ""

