#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

current_path=`pwd`
core_program=wb_android_tools
Will_save_all_program_path=/usr/local/wh/tools
GLOBLE_ENV_FILE="/etc/bash.bashrc"
has_add_globle_env=0

Step2=1
if [ $Step2 -eq 1 ];then

	echo -en "\033[32m"
	
	##### 2.if set flag, the following code will not be executed #####
	for read_my_shell_bin_path in `cat $GLOBLE_ENV_FILE`
	do

		if [[ "$read_my_shell_bin_path" =~ "has_set_wb_intel_tools_for_intel=1" ]];then
		   has_add_globle_env=1
		fi

	done

	if [ $has_add_globle_env -eq 1 ]
	then
		wanghai_no_use=1
	else
		echo
		echo "###### add by wanghai, add weibu intel tools shell scrupt ###### " >> $GLOBLE_ENV_FILE
		echo "has_set_wb_intel_tools_for_intel=1" >>  $GLOBLE_ENV_FILE
		
		echo "MY_WeiBu_Tools_PATH=$Will_save_all_program_path" >> $GLOBLE_ENV_FILE
		echo "export PATH=\$PATH:\$MY_WeiBu_Tools_PATH" >> $GLOBLE_ENV_FILE
		echo >> $GLOBLE_ENV_FILE
		echo >> $GLOBLE_ENV_FILE
	fi

	
	
	
	mkdir -p $Will_save_all_program_path
	rm $Will_save_all_program_path/* -rf
	mv $current_path/mybin $Will_save_all_program_path/ -f
	mv $current_path/$core_program $Will_save_all_program_path/weibu_tools -f
	#################
	rm ./install.sh
	#################
	
	
	
	echo
	echo "请 打开一个 新的 终端, 使用 weibu_tools 命令!!"
	date "+%Y-%m-%d %H:%M:%S"
	echo "Install WeiBu tools success!!"
	echo

	echo -en "\033[0m"


fi







