#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

Para1=
Para2=
Para3=
Para4=

if [ $# -eq 1 ];then
    Para1=$1
    Para2=system.img
elif [ $# -eq 2 ];then
    Para1=$1
    Para2=$2
elif [ $# -eq 3 ];then
    Para1=$1
    Para2=$2
    Para3=$3
elif [ $# -eq 4 ];then
    Para1=$1
    Para2=$2
    Para3=$3
    Para4=$4
else
#    echo "\$# == $#"
    Para2=system.img
fi

baytrain_444_bin_path=./x86_bin/baytrain_444
tmp_dir=tmp
old_system_img_bak=old_system_img_bak
save_new_system_img=save_new_system_img
modify_system_img=modify_system_img


mkdir $modify_system_img -p
mkdir $old_system_img_bak -p
mkdir $save_new_system_img -p
mkdir $tmp_dir -p


######### func1 #########
color_loop=2
Program_has_func_list () {
    echo -en "\033[3${color_loop}m"

    echo
    echo    "#################################";
    echo    "# 本软件具有两大功能:           #";
    echo    "#     功能1 : 解压 system.img   #";
    echo    "#     功能2 : 创建 system.img   #";
    echo    "#################################";
    echo

    echo -en "\033[0m"

    if [ $color_loop -ne 9 ];then
        ((color_loop++))
    else
        color_loop=0
    fi  

    echo -en "\033[3${color_loop}m"
    echo    "******************************************************************************************";
    echo    "# 使用方法:                                                                              #";
    echo    "#     功能1 : ./android_tools.sh -d system.img --> 解压 system.img [$modify_system_img]  #";
    echo    "#     功能2 : ./android_tools.sh -c        --> 创建 [save_new_system_img/new_system.img] #";
    echo    "#     功能3 : ./android_tools.sh -clean        --> 清空 当前目录                         #";
    echo    "#                                                                                        #";
    echo    "******************************************************************************************";
    echo


    echo -en "\033[0m"

}

######### func2 #########
Unzip_system_img(){

    echo -en "\033[32m"
    echo
    echo "Start unzip system.img ........"
    if [ ! -e $Para2 ];then
        echo "$Para2 do not exit !!"
        echo -en "\033[0m"

        tmp_img=`ls *.img`
        echo -en "\033[33m"
        echo 
        echo "You can do : "
        echo "  ./android_tools.sh -d $tmp_img"
        echo 
        echo -en "\033[0m"

        exit
    fi

    #echo "$baytrain_444_bin_path/simg2img $Para2 $tmp_dir/system.img.ext4"
    $baytrain_444_bin_path/simg2img $Para2 $tmp_dir/system.img.ext4

    echo -en "\033[34m"
    sudo mount -t ext4 -o loop $tmp_dir/system.img.ext4 $modify_system_img/
    echo -en "\033[0m"
    sudo chmod 777 -R $modify_system_img/

    echo -en "\033[35m"
    echo
    echo "Unzip $Para2 finished, you can modify $modify_system_img !!"
    echo
    echo -en "\033[0m"

    cp $Para2 $old_system_img_bak/

}

######### func3 #########
Compressed_modify_system_img(){

    echo -en "\033[32m"
    echo "Compressed $modify_system_img to new_system.img"
    echo -en "\033[0m"
    $baytrain_444_bin_path/mkuserimg.sh -s $modify_system_img/ save_new_system_img/new_system.img ext4 system 1073741824 $baytrain_444_bin_path/file_contexts

    echo -en "\033[33m"
    echo 
    echo "new system.img save in save_new_system_img/"
    echo 
    echo -en "\033[0m"
    #nautilus save_new_system_img

}

######### func3 #########
umount_modify_system_img(){
    tmp_mount_dir=`mount | grep $modify_system_img`

    echo -en "\033[32m"

    for tmp in $tmp_mount_dir
    do
    #    echo $tmp
        if [[ "$tmp" =~ "$modify_system_img" ]];then
            #echo "mount_dir=$tmp"
            sudo umount $tmp
            echo -en "\033[0m"
            exit
        fi
    done

    echo "Nothing to do ...."
    echo -en "\033[0m"

}

show_version(){
    echo -en "\033[32m"
    cat x86_bin/version_info.txt
    echo -en "\033[0m"
}

if [ $# -eq 0 ];then 
    Program_has_func_list
    exit 0
elif [ $Para1 == '-d' ];then
    Unzip_system_img
elif [ $Para1 == '-c' ];then
    Compressed_modify_system_img
elif [ $Para1 == '-clean' ];then
    umount_modify_system_img
elif [ $Para1 == '-v' ];then
    show_version
else
    echo -en "\033[32m"
    echo
    echo "Unknow $Para1 !!"
    echo
    echo -en "\033[0m"

    Program_has_func_list
fi



