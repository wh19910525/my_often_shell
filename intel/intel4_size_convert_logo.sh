#!/bin/bash

#######################################
# Author: hai.wang 
#######################################
Intel_android_top="$ANDROID_BUILD_TOP"
Currtet_Dir=`pwd`
Source_Dir="$Currtet_Dir/$1"
Dst_size=$2
Dst_path=$Currtet_Dir/after_convert_logo
Dst_logo_name=`date "+%Y-%m-%d_%H-%M-%S"`
################

######### func1 #########
usage () {
    echo -en "\033[32m"
    echo "Usage:"
    echo "  lot_size_convert_logo.sh [Src-logo-dir] [sizexsize] "
    echo "  lot_size_convert_logo.sh [Src-logo-dir] [modify_name to *.jpg *.png ] "
    echo "  Example:"
    echo "     lot_size_convert_logo.sh [Src-logo-dir] [1024x768]"
    echo "     lot_size_convert_logo.sh [Src-logo-dir] [jpg or png]"
    echo -en "\033[0m"
}

######### func2 #########
check_is_target_dir () {
loop=0
    if [ ! -d $Source_Dir ]; then #2:check target is not a dir;
        echo "[$Source_Dir] is not a dir!!"
        exit 2
    fi
    rm $Dst_path -rf
    mkdir $Dst_path -p

    if [ ${Dst_size} == jpg ] # 
    then

        for tmp_pic in `ls $Source_Dir`
        do
            ((loop++))
            echo pic: $loop 
            echo convert $Source_Dir/$tmp_pic $Dst_path/00$loop.jpg
            convert $Source_Dir/$tmp_pic $Dst_path/00$loop.jpg

        done
        exit 1
    elif [ ${Dst_size} == png ];then

        for tmp_pic in `ls $Source_Dir`
        do
            ((loop++))
            echo pic: $loop 
            echo convert $Source_Dir/$tmp_pic $Dst_path/00$loop.png
            convert $Source_Dir/$tmp_pic $Dst_path/00$loop.png
        done

        exit 2
    fi
echo ===============
    for tmp_pic in `ls $Source_Dir`
    do
        ((loop++))
        echo pic: $loop 
       ############## 强制 裁剪大小 ############
       # echo convert -resize  $Dst_size! $Source_Dir/$tmp_pic $Dst_path/${tmp_pic%.*}.jpg
       # convert -resize  $Dst_size! $Source_Dir/$tmp_pic $Dst_path/${tmp_pic%.*}.jpg
       
       ############## 从中心 裁剪 ############
        echo convert $Source_Dir/$tmp_pic  -gravity center -crop $Dst_size+0+0 $Dst_path/${tmp_pic%.*}.jpg
        convert $Source_Dir/$tmp_pic  -gravity center -crop $Dst_size+0+0 $Dst_path/${tmp_pic%.*}.jpg
    done

}

wh_check_is_target_dir () {
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

    if [ $# -ne 2 ]; then
        usage
    else

        check_is_target_dir
    fi


