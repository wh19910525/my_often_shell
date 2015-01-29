#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

new_recovery=$ANDROID_PRODUCT_OUT/recovery.img

if [ !  -e $new_recovery ];then
    echo "$new_recovery do not exist !!"
    exit
fi



connect_android_device(){
    while true
    do
    has_find_android_device=`fastboot devices`
        if [[ "$has_find_android_device" =~ "fastboot" ]];then
            echo "已经连上android设备"
            break
        fi

    done
}

###############
#Step 1
echo "正在寻找androi设备 ..."
adb wait-for-device
echo "已经找到android设备 ..."

#Step 2
echo "正在重启android设备, 进入fastboot mode ..."
adb reboot-bootloader

#Step 3
connect_android_device

#Step 4
fastboot flash recovery $new_recovery

#Step 5
fastboot reboot




