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

Zip_file_info="Zip archive data"
##############################################

######### func1 #########
color_loop=2
Check_file_is_intel_upgrade_fw () {
	echo -en "\033[3${color_loop}m"
	#echo -en "\033[32m"
#	echo "Para1=$Para1"
#	echo "Para2=$Para2"
#	echo "Para3=$Para3"
#	echo "Para4=$Para4"

	get_cmd_return_value=`file $Para1`
#	echo "get_cmd_return_value=$get_cmd_return_value"
	if [[ "$get_cmd_return_value" =~ $Zip_file_info ]];then
		wanghai_no_use=1
	else
		echo "$Para1 is not $Zip_file_info"
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

	Check_file_is_intel_upgrade_fw $Para1
	#exit 0
fi

