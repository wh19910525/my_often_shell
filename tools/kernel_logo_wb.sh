#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

Para1=$1
Currtet_Dir=`pwd`
weibu_tools_install_path="/usr/local/wh/tools"
intel_sign_logo_path=$weibu_tools_install_path/sign
sign_bin="$intel_sign_logo_path/sign.sh"

echo para = $#
if [ $# -eq 1 ];then
    if [ -e $Para1 ];then

        echo -en "\033[36m"

        echo "############### start kernel logo #################"

        #echo cp $Currtet_Dir/$Para1 $intel_sign_logo_path/logo.bmp
        cp $Currtet_Dir/$Para1 $intel_sign_logo_path/logo.bmp 

        echo $sign_bin  > /dev/null
        $sign_bin  > /dev/null

        #echo cp $intel_sign_logo_path/logo.img $Currtet_Dir/splash.img
        cp $intel_sign_logo_path/logo.img $Currtet_Dir/splash.img
        cp $intel_sign_logo_path/logo.img $Currtet_Dir/logo.img

        echo "

        android 4.4 使用 splash.img;

        android 4.2 使用 logo.img;

        "

        echo "############### end kernel logo #################"

        echo -en "\033[0m"

    else

    echo -en "\033[33m"
    echo
    echo [$Para1] no exist!
    echo
    echo -en "\033[0m"

    fi

else

    echo -en "\033[33m"
    echo
    echo Usage: kernel_logo_wb.sh logo.bmp
    echo
    echo -en "\033[0m"

fi


