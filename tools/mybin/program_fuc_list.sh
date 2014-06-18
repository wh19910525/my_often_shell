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
Source_System_img_gz_File="$Currtet_Dir/$1"

######### func1 #########
usage () {
    echo -en "\033[32m"
    echo "Let system.img.gz --> System_Dir"
    echo "Usage:"
    echo "  $0 <system.img.gz> "
    echo -en "\033[0m"
    exit 2
}

######### func2 #########
check_is_target_SystemImgGz_file () {
    if [ ! -f $Source_System_img_gz_File ]; then #2:check target is not a dir;
        echo "[$Source_System_img_gz_File] is not a system.img.gz!!"
        exit 3
    fi
}

######### func3 #########
mount_System_Img () {

#test1
mkdir $Intel_android_top/$Tmp_Dir/m_system -p
umount $Intel_android_top/$Tmp_Dir/m_system -l > /dev/null
#echo "mkdir $Intel_android_top/$Tmp_Dir/m_system -p"

#test2
gunzip -c $Source_System_img_gz_File > $Intel_android_top/$Tmp_Dir/system_tmp.img
#echo "gunzip -c $Source_System_img_gz_File > $Intel_android_top/$Tmp_Dir/system.img"
if [ $? -ne 0 ]; then
    exit 4
fi

#test3
#echo "mount -t ext4 -o loop $Intel_android_top/$Tmp_Dir/system.img $Intel_android_top/$Tmp_Dir/m_system/"
mount -t ext4 -o loop $Intel_android_top/$Tmp_Dir/system_tmp.img $Intel_android_top/$Tmp_Dir/m_system/
if [ $? -ne 0 ]; then
    echo "mount failed!!" 
    exit 5
fi
chmod 777 -R $Intel_android_top/$Tmp_Dir/m_system/

echo -e "\033[;31m 

    Note: gunzip $Source_System_img_gz_File To $Intel_android_top/$Tmp_Dir/system.img !!
    Note: mount $Intel_android_top/$Tmp_Dir/system.img To $Intel_android_top/$Tmp_Dir/m_system/ finished!!

    Now , you can modify some file in [[$Intel_android_top/$Tmp_Dir/m_system/]] ;

\033[0m"

echo -e "\033[;35m 

    Final, you can use <intel1_Make_System.img.gz.sh>, make [[$Intel_android_top/$Tmp_Dir/m_system/]] to a new system.img.gz!!

\033[0m"

}

########### main func #########
Step1=0
if [ $Step1 -eq 1 ];then 

	if [ x != x$ANDROID_BUILD_TOP ] # 1:check is or not ,lunch;
	then
	    if [ $# -ne 1 ]; then
		usage
	    else
		check_is_target_SystemImgGz_file
		mount_System_Img
	    fi

	else
	    echo "Please do :lunch redhookbay-usereng"
	    exit 1

	fi
fi

################################################################
####################### Globle Variables #######################
################################################################
Para1=$1
Para2=$2
Para3=$3
Para4=$4

##############################################

######### func1 #########
color_loop=0
Program_has_func_list () {
	echo -en "\033[3${color_loop}m"
	#echo -en "\033[32m"
	echo "Para1=$Para1"
#	echo "Para2=$Para2"
#	echo "Para3=$Para3"
#	echo "Para4=$Para4"

	echo
	echo    "###########################################";
	echo    "# 本软件具有两大功能:                     #";
	echo    "#     功能1 : 解压 微步 4.2升级固件！！   #";
	echo    "#     功能2 : 压缩 微步 4.2升级固件！！   #";
	echo    "###########################################";
	echo

	echo -en "\033[0m"

	if [ $color_loop -ne 9 ];then
		((color_loop++))
	else
		color_loop=0
	fi

	echo -en "\033[3${color_loop}m"
	echo    "******************************************";
	echo    "# 使用方法:                     #";
	echo    "#     功能1 : weibu_tools -d 固件升级包 --> 解压 [固件升级包]  #";
	echo    "#     功能2 : 压缩 微步 4.2升级固件！！   #";
	echo    "###########################################";


	echo -en "\033[0m"

}


####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	Program_has_func_list $Para1
	
	#exit 0
fi




