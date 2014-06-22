#! /bin/bash

#######################################
# Author: hai.wang 
#######################################

current_path=`pwd`
core_program=wb_android_tools
Will_save_all_program_path=/usr/local/wh/tools
GLOBLE_ENV_FILE="/etc/bash.bashrc"

Step2=1
if [ $Step2 -eq 1 ];then
	echo -en "\033[32m"
	#wanghai	
	echo >> $GLOBLE_ENV_FILE
	echo "MY_SHELL_PATH=$Will_save_all_program_path" >> $GLOBLE_ENV_FILE
	echo "export PATH=\$PATH:\$MY_SHELL_PATH" >> $GLOBLE_ENV_FILE
	echo >> $GLOBLE_ENV_FILE
	echo >> $GLOBLE_ENV_FILE

	mkdir -p $Will_save_all_program_path
	cp $current_path/mybin $Will_save_all_program_path/ -rf
	cp $current_path/$core_program $Will_save_all_program_path/weibu_tools -rf
	rm ./* -rf
	
	echo
	echo "请 打开一个 新的 终端, 使用 weibu_tools 命令!!"
	date "+%Y-%m-%d %H:%M:%S"
	echo "Install WeiBu tools success!!"
	echo

	echo -en "\033[0m"


fi







