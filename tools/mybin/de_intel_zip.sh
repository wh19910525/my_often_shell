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

Modify_system_img_dir=Modify_system_img_dir
Save_intel_tools_upgrade_package=Customer_tools_FW
Mosidfy_kernel_logo_top_dir="Modify_system_img_dir/kernel_logo"

##############################################

######### func1 #########
mkdir_must_dir (){

    mkdir $Mosidfy_kernel_logo_top_dir -p
    chmod 777 -R $Modify_system_img_dir

}



######### func2 #########
color_loop=4
Decompression_intel_upgrade_fw () {
	#echo -en "\033[32m"
#	echo "Para1=$Para1"
#	echo "Para2=$Para2"
#	echo "Para3=$Para3"
#	echo "Para4=$Para4"

	echo -en "\033[3${color_loop}m"

	echo 
	echo "正在 解压 ,可能 需要1分钟，请稍等 ..."
	#echo unzip $Para1 -d $Save_intel_tools_upgrade_package
	unzip $Para1 -d $Save_intel_tools_upgrade_package > /dev/null
	if [ $? -eq 0 ];then #unzip success ,return 0;
		echo -en "\033[35m"
		mkdir_must_dir
	else
		echo -en "\033[3${color_loop}m"
		echo 
		echo "Decompression $Para1 failed!!"
		echo -en "\033[0m"
		echo 
		exit 1
	fi
	echo

	echo -en "\033[0m"
}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 

	Decompression_intel_upgrade_fw $Para1
	#exit 0
fi

