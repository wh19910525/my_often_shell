#!/bin/bash

if [ $# == 0 ];then
    echo "`basename $0` src-file" 
    exit 0
fi

########################################
#BUILD_FLAGS=" -pie -fPIC "


########################################
# 1. 查找 编译器: GCC
########################################

if [ -z ${ANDROID_BUILD_TOP} ];then
	echo "请设置 Android TOP dir!!"
else
	AOSP_TOP_DIR=${ANDROID_BUILD_TOP}
fi

ARM_64_GCC=${AOSP_TOP_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-gcc
if [ ! -e ${ARM_64_GCC} ];then
	echo "no exist [${ARM_64_GCC}]"
    exit 1;
fi

########################################
#2. 查找 NDK工具:
########################################

#NDK_TOP_DIR="~/workspace/ndk/android-ndk-r21b"
NDK_TOP_DIR="/opt1/wanghairjxt/workspace/ndk/android-ndk-r21b"
if [ ! -e ${NDK_TOP_DIR} ];then
	echo "no exist [${NDK_TOP_DIR}]"
    exit 2;
fi

FIND_LIB_FILE_PATH="${NDK_TOP_DIR}/platforms/android-28/arch-arm64"
FIND_HEADS_FILE_PATH_01="${NDK_TOP_DIR}/sysroot"
FIND_HEADS_FILE_PATH_02="${NDK_TOP_DIR}/sysroot/usr/include/aarch64-linux-android"

if [ ! -e ${FIND_LIB_FILE_PATH} ];then
	echo "no exist [${FIND_LIB_FILE_PATH}]"
    exit 3;
fi

if [ ! -e ${FIND_HEADS_FILE_PATH_01} ];then
	echo "no exist [${FIND_HEADS_FILE_PATH_01}]"
    exit 4;
fi

if [ ! -e ${FIND_HEADS_FILE_PATH_02} ];then
	echo "no exist [${FIND_HEADS_FILE_PATH_02}]"
    exit 5;
fi

########################################
#3. 开始编译:
########################################
BUILD_CMD="${ARM_64_GCC} --sysroot=${FIND_LIB_FILE_PATH} -isysroot ${FIND_HEADS_FILE_PATH_01} -isystem ${FIND_HEADS_FILE_PATH_02} ${BUILD_FLAGS} $@"
echo "BUILD_CMD=[${BUILD_CMD}]"
${BUILD_CMD}


