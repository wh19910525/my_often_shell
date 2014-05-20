#!/bin/bash

#######################################
# Author: hai.wang 
#######################################
Intel_android_top="$ANDROID_BUILD_TOP"
Currtet_Dir=`pwd`
Source_Dir="$Currtet_Dir/$1"
Dst_size=$2
Dst_path=$Intel_android_top/vendor/intel/clovertrail/board/redhookbay/custom_require/kernel_logo
Dst_logo_name=`date "+%Y-%m-%d_%H-%M-%S"`
################

######### func1 #########
usage () {
    echo -en "\033[32m"
    echo "Convert logo to logo.bmp for kernel"
    echo "Usage:"
    echo "  intel_make_kernel_logo.sh [Src-logo] [sizexsize] ----> kernel_logo.bmp"
    echo "  intel_make_kernel_logo.sh [Src-logo] [rotate 90, 180, 270] ----> kernel_logo.bmp"
    echo 
    echo "  Example:"
    echo "     intel_make_kernel_logo.sh [Src.bmp] [512x384]"
    echo "     intel_make_kernel_logo.sh [Src.bmp] [rotate:90]"
    echo -en "\033[0m"
}

######### func2 #########
check_is_target_dir () {
    if [ ! -e $Source_Dir ]; then #2:check target is not a dir;
        echo "[$Source_Dir] does not exit!!"
        exit 2
    fi
    mkdir $Dst_path -p
#echo ${Dst_size%:*}
#echo ${Dst_size#*:}

    if [ ${Dst_size%:*} == rotate ] # 
    then
        echo convert -rotate ${Dst_size#*:} $Source_Dir $Dst_path/$Dst_logo_name.bmp
        convert -rotate ${Dst_size#*:} $Source_Dir $Dst_path/$Dst_logo_name.bmp
      # convert -rotate 90 logo.bmp logo.bmp
    else

        echo convert $Source_Dir  -gravity center -crop $Dst_size+0+0 $Dst_path/$Dst_logo_name.bmp
        convert $Source_Dir  -gravity center -crop $Dst_size+0+0 $Dst_path/$Dst_logo_name.bmp
    fi

}


#main func
if [ x != x$ANDROID_BUILD_TOP ] # 1:check is or not ,lunch;
then

    if [ $# -ne 2 ]; then
        usage
    else

        check_is_target_dir
    fi

else
    echo "Please do :lunch redhookbay-usereng"
    exit 1
fi

