#!/bin/bash

#######################################
# Author: hai.wang 
#######################################

################################################################
####################### Globle Variables #######################
################################################################

Currtet_Dir=`pwd`
Para1=$1
Para2=$2
Para3=$3
Para4=$4

Modify_System_img_Top_dir="$Para1/Modify_system_img_dir/modify_system/"
read_prop_file=$Modify_System_img_Top_dir/build.prop
check_info="ro.zgj.no.use=whtool"

wb_android_tools_path=`which wb_android_tools`
#echo "wb_android_tools_path=$wb_android_tools_path"

after_modify_system_img=before_system.img
after_modify_system_img_path=$Para1/Modify_system_img_dir/$after_modify_system_img

after_modify_intel_fw_path=$Para1/Customer_tools_FW
tmp_system_img_gz=$after_modify_intel_fw_path/new_system.img.gz
old_system_img_gz=$after_modify_intel_fw_path/system.img.gz
new_system_img_gz=$after_modify_intel_fw_path/system.img.gz

#############################################

######### func1 #########
color_loop=5
prop_loop=1

Check_fw_is_weibu () {

echo -en "\033[36m"

if [ -f $read_prop_file ];then

	for read_prop in `cat $read_prop_file`
	do

		if [[ "$read_prop" =~ $check_info ]];then

			umount $Modify_System_img_Top_dir -l
			echo 
			echo 
			echo "正在 创建 新的 升级固件, 需要 3分钟, 请稍等...!!"
			gzip < $after_modify_system_img_path > $tmp_system_img_gz
			
			rm $old_system_img_gz -rf; 
			mv $tmp_system_img_gz $new_system_img_gz

			echo -en "\033[0m"
			exit 0
		else
			wanghai_no_use=1
		fi

		((prop_loop++))
	done


	echo -en "\033[3${color_loop}m"
	echo 
	echo "此工具 只支持 微步代码 编译 出来的固件!!"
	echo 
	echo -en "\033[0m"
	exit 1

else
	echo "Not mount in $Modify_System_img_Top_dir, 请 解压 原始固件, 修改后 再次 压缩!!"
	echo -en "\033[0m"
	echo 
	exit 1
fi

}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 
	#echo intel_fw_path=$Para1
	Check_fw_is_weibu $Para1
fi

