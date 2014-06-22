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

Check_must_exist_file=flash.xml
Top_modify_intel_fw_dir_name=Customer_tools_FW

Top_modify_intel_fw_dir_path=$Para1/$Top_modify_intel_fw_dir_name
Top_modify_intel_fw_must_exist_file=$Top_modify_intel_fw_dir_path/$Check_must_exist_file

##############################################

######### func1 #########
color_loop=5
Check_fw_is_weibu () {

	echo -en "\033[3${color_loop}m"

	if [ -e $Top_modify_intel_fw_must_exist_file ];then
		wanghai_no_use=1
		echo "$Top_modify_intel_fw_dir_path  is Intel FW top dir!!"
	else
		echo 

		for i in `ls $Top_modify_intel_fw_dir_path`
		do
#			echo "$Top_modify_intel_fw_dir_path/$i"
			if [ -d $Top_modify_intel_fw_dir_path/$i ];then
				if [ -e $Top_modify_intel_fw_dir_path/$i/$Check_must_exist_file ];then
					mv  $Top_modify_intel_fw_dir_path/$i/* $Top_modify_intel_fw_dir_path/
					rm $Top_modify_intel_fw_dir_path/$i -rf	
				fi
			fi
			
		done

		echo -en "\033[0m"
		echo 
	fi
		exit 0
	echo

	echo -en "\033[0m"
}

####### main func #########
Step2=1
if [ $Step2 -eq 1 ];then 
	#echo intel_fw_path=$Para1
	Check_fw_is_weibu $Para1
fi

