#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

Board_out="redhookbay"
Intel_android_top="$ANDROID_BUILD_TOP"
Currtet_Dir=`pwd`
Tmp_Dir="out/target/product/$Board_out/tmp_system"

Linux_X86_Tools_Dir="out/host/linux-x86/bin"
Source_Dir="$Currtet_Dir/$1"

######### func1 #########
usage () {
    echo -en "\033[32m"
    echo "Let System_Dir --> system.img.gz"
    echo "Usage:"
    echo "  $0 <Target_DirSystem> "
    echo -en "\033[0m"
}

######### func2 #########
check_is_target_dir () {
    if [ ! -d $Source_Dir ]; then #2:check target is not a dir;
        echo "[$Source_Dir] is not a Dir!!"
        exit 2
    fi

    if [ ! -e $Source_Dir/build.prop ]
    then
        echo " $Source_Dir is not an android system !!"
        exit 3
    else 
        echo "OK , we will tar [$Source_Dir] --> system.img.gz!!"
    fi
}

######### func3 #########
make_SystemDir_to_SystemImgGz () {

##./out/host/linux-x86/bin/mkuserimg.sh out/target/product/$Board_out/system out/target/product/$Board_out/obj/PACKAGING/systemimage_intermediates/system.img ext4 system 1073741824

#1test
#echo "mkdir $Intel_android_top/$Tmp_Dir -p"
mkdir $Intel_android_top/$Tmp_Dir -p

#2test
#echo "$Intel_android_top/$Linux_X86_Tools_Dir/mkuserimg.sh $Source_Dir $Intel_android_top/$Tmp_Dir/system.img ext4 system 1073741824"
#$Intel_android_top/$Linux_X86_Tools_Dir/mkuserimg.sh $Source_Dir $Intel_android_top/$Tmp_Dir/system.img ext4 system 2147483648
#$Intel_android_top/$Linux_X86_Tools_Dir/mkuserimg.sh $Source_Dir $Intel_android_top/$Tmp_Dir/system.img ext4 system 1610612736
#$Intel_android_top/$Linux_X86_Tools_Dir/mkuserimg.sh $Source_Dir $Intel_android_top/$Tmp_Dir/system.img ext4 system 1283457024
$Intel_android_top/$Linux_X86_Tools_Dir/mkuserimg.sh $Source_Dir $Intel_android_top/$Tmp_Dir/system.img ext4 system 1073741824

echo -e "\033[;31m 

    Note: First: make $Source_Dir -->  $Intel_android_top/$Tmp_Dir/system.img

\033[0m"

#3test
#echo "$Intel_android_top/$Linux_X86_Tools_Dir/minigzip < $Intel_android_top/$Tmp_Dir/system.img > $Intel_android_top/$Tmp_Dir/new_system.img.gz"  
$Intel_android_top/$Linux_X86_Tools_Dir/minigzip < $Intel_android_top/$Tmp_Dir/system.img > $Intel_android_top/$Tmp_Dir/new_system.img.gz 

echo -e "\033[;35m 

    Note: Second: tar $Source_Dir  --> $Intel_android_top/$Tmp_Dir/new_system.img.gz

\033[0m"

}

#main func
if [ x != x$ANDROID_BUILD_TOP ] # 1:check is or not ,lunch;
then

    if [ $# -ne 1 ]; then
        usage
    else

        check_is_target_dir
        make_SystemDir_to_SystemImgGz
    fi

else
    echo "Please do :lunch redhookbay-usereng"
    exit 1
fi

