#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

resign_apk(){
echo -e "\033[;33mPlease select sign mode: 1 -->only v1, 2 -->only v2, other -->v1+v2\033[0m"
read Project_name

if [ x$Project_name == x ];then
    sign_mode="def"
elif [ $Project_name == 1 ];then
    sign_mode="only_v1"
elif [ $Project_name == 2 ];then
    sign_mode="only_v2"
else
    sign_mode="def"
fi
echo "sign-mode=[${sign_mode}]"

if [ $sign_mode == "def" ];then
echo "use mode=[${sign_mode}]"
#android 7.0 resigned apk v1 and v2:
java -Djava.library.path=${ANDROID_BUILD_TOP}/out/host/linux-x86/lib64 -jar ${ANDROID_BUILD_TOP}/out/host/linux-x86/framework/signapk.jar --min-sdk-version 8 ${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.x509.pem ${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.pk8 $1 $2
fi

if [ $sign_mode == "only_v1" ];then
echo "use mode=[${sign_mode}]"
#android 7.0 resigned apk only v1:
java \
-Djava.library.path=${ANDROID_BUILD_TOP}/out/host/linux-x86/lib64 \
-jar ${ANDROID_BUILD_TOP}/out/host/linux-x86/framework/signapk.jar \
--min-sdk-version 8 \
--disable-v2 \
${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.x509.pem \
${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.pk8 \
$1 $2
fi

if [ $sign_mode == "only_v2" ];then
echo "use mode=[${sign_mode}]"
#android 7.0 resigned apk only v1:
java \
-Djava.library.path=${ANDROID_BUILD_TOP}/out/host/linux-x86/lib64 \
-jar ${ANDROID_BUILD_TOP}/out/host/linux-x86/framework/signapk.jar \
--min-sdk-version 8 \
--disable-v1 \
${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.x509.pem \
${ANDROID_BUILD_TOP}/vendor/nexgo/build/resource/security-keys/releasekey.pk8 \
$1 $2
fi

echo -e "\033[;33mResigned $1 --> $2\033[0m"
}
#####################################

echo -e "\033[;33mModify v2 signed apk, Id-Value\033[0m"
java -jar ${ANDROID_BUILD_TOP}/out/host/linux-x86/framework/fdebug_apk_v2_sign.jar $1


