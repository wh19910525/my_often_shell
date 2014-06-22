#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

current_path=`pwd`

my_bin_path_loop=0
MY_SHELL_BIN_PATH=$current_path
Need_filter_dir=mybin
GLOBLE_ENV_FILE="/etc/bash.bashrc"
has_add_globle_env=0
Will_save_all_program_path=/usr/local/wh/tools

Step1=1
if [ $Step1 -eq 1 ];then
	###### 1. main func ######
	for my_bin_dir in `ls $current_path`
	do
		if [ -d $my_bin_dir -a x$my_bin_dir != x$Need_filter_dir ]
		then
			((my_bin_path_loop++))
			tmp_my_bin_path=$current_path/$my_bin_dir
			MY_SHELL_BIN_PATH=$MY_SHELL_BIN_PATH:$tmp_my_bin_path
			#echo $MY_SHELL_BIN_PATH
		fi
	 
	done

	##### 2.if set flag, the following code will not be executed #####
	for read_my_shell_bin_path in `cat $GLOBLE_ENV_FILE`
	do

		if [[ "$read_my_shell_bin_path" =~ "has_set_wb_tools_for_intel=1" ]];then
		#   echo has_add_globle_env=1
		   has_add_globle_env=1
		fi

	done

	if [ $has_add_globle_env -eq 1 ]
	then
		sed -i '/^MY_SHELL_PATH/ c\MY_SHELL_PATH='"${MY_SHELL_BIN_PATH}"'' $GLOBLE_ENV_FILE
	else
		echo
		echo "###### add by wanghai, add my often use shell scrupt ###### " >> $GLOBLE_ENV_FILE
		echo "has_set_wb_tools_for_intel=1" >>  $GLOBLE_ENV_FILE
		
		echo "MY_SHELL_PATH=$MY_SHELL_BIN_PATH" >> $GLOBLE_ENV_FILE
		echo "export PATH=\$PATH:\$MY_SHELL_PATH" >> $GLOBLE_ENV_FILE
		echo >> $GLOBLE_ENV_FILE
		echo >> $GLOBLE_ENV_FILE
	fi
################################

	#wanghai	
	echo mkdir -p $Will_save_all_program_path
	echo cp $current_path/mybin $Will_save_all_program_path/ -rf
	




################################

	echo -en "\033[32m"
	echo
	date "+%Y-%m-%d %H:%M:%S"
	echo "Install WeiBu tools success!!"
	echo

	echo -en "\033[0m"

fi






